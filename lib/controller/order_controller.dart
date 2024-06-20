import 'dart:convert';

import 'package:car_parts/data/repository/order_repository_impl.dart';
import 'package:car_parts/utils/color.dart';
import 'package:car_parts/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:phone_pe_pg/phone_pe_pg.dart' as phonepe;
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

import '../constants/firestore_constants.dart';
import '../data/model/chat_model.dart';
import '../data/model/my_order.dart';
import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  phonepe.PhonePePg phonePePg = phonepe.PhonePePg(
    isUAT: false, // true for UAT environment, false for production
    saltKey: '6ea0bf8d-f958-405d-b960-de054e23dd73', saltIndex: '1',
  );
  var cfPaymentGatewayService = CFPaymentGatewayService();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  var isPhonePayInstalled = false.obs;

  @override
  void onInit() {
    cfPaymentGatewayService.setCallback(verifyPayment, onError, receivedEvent);
    super.onInit();
    // checkPhoneayInstall();
  }

  // checkPhoneayInstall() async {
  //   await PhonePePaymentSdk.init('PRODUCTION', '', 'KISHANAUTONLINE', true);
  //   isPhonePayInstalled.value = await PhonePePaymentSdk.isPhonePeInstalled();
  //   print("isPhonePayInstalled.value" + isPhonePayInstalled.value.toString());
  //   update();
  // }

  var myOrders = [Data()].obs;
  var isLoading = true.obs;
  var _orderId = '';
  var _authToken = '';

  void setLoading(bool loading) {
    isLoading.value = loading;
    update();
  }

  final _orderRepository = OrderRepositoryImpl();

  Future<void> getMyOrder() async {
    myOrders.clear();
    isLoading(true);
    try {
      final carBrandResponse = await _orderRepository.getOrdersBrand();
      isLoading(false);
      myOrders.addAll(carBrandResponse!.data!);
    } on FetchDataException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on BadRequestException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on UnauthorisedException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    }
  }

  String? getOrderStatus(String orderStatus) {
    switch (orderStatus) {
      case '1':
        return 'In Request';
      case '2':
        return 'Payment Requested';
      case '3':
        return 'Order Placed';
      case '4':
        return 'Order In-Transit';
      case '5':
        return 'Completed';
      case '6':
        return 'Cancelled';
    }
    return '';
  }

  Color? getOrderColor(String orderStatus) {
    switch (orderStatus) {
      case '1':
        return primaryColor;
      case '2':
        return Colors.yellow;
      case '3':
        return Colors.green;
      case '4':
        return Colors.black;
      case '5':
        return Colors.purple;
      case '6':
        return Colors.red;
    }
    return primaryColor;
  }

  void verifyPayment(String txnId) {
    setLoading(false);
    Fluttertoast.showToast(msg: "Payment Successfull!");
    paymentSuccessfull(_orderId, txnId, _authToken);
  }

  Future<void> paymentSuccessfull(
      String orderId, String txnId, String token) async {
    setLoading(true);
    try {
      http.Response response = await http.post(
          Uri.parse(APIEndpoint.baseApi + APIEndpoint.paymentSuccess),
          headers: {'token': token},
          body: jsonEncode({
            'orderId': orderId,
            'txn_Id': txnId,
          }));
      print(Uri.parse(APIEndpoint.baseApi + APIEndpoint.paymentSuccess));
      print(response.body);

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        setLoading(false);
        await getMyOrder();
        sendMessage(
            token,
            '3232',
            "senderName",
            "receiverName",
            "Payment is successfull and your transcationId is ${txnId}",
            false,
            '',
            orderId);
      } else {
        setLoading(false);
        print(response.body);
        Fluttertoast.showToast(msg: response.body.toString());
      }
    } catch (e) {
      setLoading(false);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void sendMessage(
      String senderId,
      String receiverId,
      String senderName,
      String receiverName,
      String message,
      bool isMedia,
      String mediaType,
      String orderId) {
    var messageId = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathOrdersCollection)
        .doc(orderId)
        .collection(FirestoreConstants.pathChatCollection)
        .doc(messageId);

    MessageModel messageChat = MessageModel(
        messageId: messageId,
        senderId: senderId,
        receiverId: receiverId,
        senderName: senderName,
        receiverName: receiverName,
        message: message,
        isMedia: isMedia,
        dateTime: DateTime.now().toString(),
        mediaType: mediaType);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    Fluttertoast.showToast(msg: errorResponse.getMessage().toString());
    setLoading(false);
  }

  void receivedEvent(String event_name, Map<dynamic, dynamic> meta_data) {
    print(event_name);
    print(meta_data);
  }

  // String orderId = "OrderId598";
  // String paymentSessionId =
  //     "session_8gsRuX0fIcS7E-0qb6AvaN1Ewuq_4BJBWraonw03Qjr979L84UfBGXOH8yabZaYp-ouT7KzIom6Oa8khuQSTA6wwbGtyeyx3WtduwT9hAcA0";

  // String orderId = "order_18482OupTxSofcClBAlgqyYxUVceHo8";
  // String paymentSessionId = "session_oeYlKCusKyW5pND4Swzn1rE2-gwnoM8MOC2nck9RjIiUQwXcPLWB3U1xHaaItb-uA9H1k6Fwziq9O63DWcfYGy_3B7rl1nDFo3MMeVqiYrBr";
  CFEnvironment environment = CFEnvironment.SANDBOX;

  CFSession? createSession(String orderId, paymentSessionId) {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }

  webCheckout(String orderId, String paymentId) async {
    setLoading(true);
    try {
      var session = createSession(orderId, paymentId);
      var cfWebCheckout =
          CFWebCheckoutPaymentBuilder().setSession(session!).build();
      cfPaymentGatewayService.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      setLoading(false);
      Fluttertoast.showToast(msg: e.message);
      print(e.message);
    }
  }

  void generateOrders(String orderId, String authToken, String name,
      String email, String number, double amount, BuildContext context) async {
    _orderId = orderId;
    _authToken = authToken;
    String txnId = 'TXN_${DateTime.now().microsecondsSinceEpoch}';
    List<phonepe.UpiAppInfo>? upiApps = await phonepe.PhonePePg.getUpiApps();
    isPhonePayInstalled.value =
        upiApps!.where((element) => element.appName == 'PhonePe').isNotEmpty
            ? true
            : false;
    update();
    print("isPhonePayInstalled.value${upiApps.length}");

    try {
      phonepe.PaymentRequest paymentRequest = phonepe.PaymentRequest(
          amount: amount,
          callbackUrl: "https://spareman.in/",
          deviceContext: phonepe.DeviceContext.getDefaultDeviceContext(),
          merchantId: 'KISHANAUTONLINE',
          merchantTransactionId: txnId,
          merchantUserId: '3652635',
          mobileNumber: number,
          redirectUrl: "https://spareman.in/",
          redirectMode: "GET",
          paymentInstrument: isPhonePayInstalled.value
              ? phonepe.UpiIntentPaymentInstrument(targetApp: 'com.phonepe.app')
              : phonepe.PayPagePaymentInstrument());
      if (isPhonePayInstalled.value) {
        final response =
            await phonePePg.startUpiTransaction(paymentRequest: paymentRequest);
        if (response.status == phonepe.UpiPaymentStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Transaction Successful")));
        } else if (response.status == phonepe.UpiPaymentStatus.pending) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Transaction Pending")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Transaction Failed")));
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => phonePePg.startPayPageTransaction(
                paymentRequest: paymentRequest,
                onPaymentComplete: (paymentStatusResponse, error) {
                  // print("ErrorPhonePe" + error);
                  // print("SuccessPhonePe${paymentStatusResponse?.code?.code}");
                  if (paymentStatusResponse != null &&
                      paymentStatusResponse.code?.code == "PAYMENT_SUCCESS") {
                    paymentSuccessfull(_orderId, txnId, authToken);
                    showSnackBar(context, "Payment Success!");
                  } else {
                    showSnackBar(context, "Payment failed!");
                  }
                  Navigator.pop(context);
                  // Handle payment status and error
                },
                appBar: AppBar(
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                )),
          ),
        );
        return;
      }
      http.Response response =
          await http.post(Uri.parse("https://sandbox.cashfree.com/pg/orders"),
              headers: {
                'Content-Type': 'application/json',
                'x-client-id': 'TEST340342482b8a97329c2ed54c97243043',
                'x-client-secret':
                    'TEST9883a775318bc019bde2df74177e5cafcbf3f9fc',
                'x-api-version': "2022-09-01",
                'x-request-id': 'FriendAutomative'
              },
              body: jsonEncode({
                'order_amount': amount,
                'order_id': "TXN_${DateTime.now().microsecondsSinceEpoch}",
                'order_currency': 'INR',
                'customer_details': {
                  'customer_id': "3652635",
                  'customer_name': name,
                  'customer_email': email,
                  'customer_phone': number
                },
                "order_meta": {"notify_url": "https://test.cashfree.com"},
                "order_note": "some order note here",
              }));
      print(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        webCheckout(item['order_id'], item['payment_session_id']);
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

}
