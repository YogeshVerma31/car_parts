import 'dart:convert';

import 'package:car_parts/data/model/chat_model.dart';
import 'package:car_parts/data/repository/chat_repository_impl.dart';
import 'package:car_parts/providers/network/api_endpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../constants/firestore_constants.dart';

import '../services/media_services.dart';
import '../services/media_services_interface.dart';
import '../utils/utils.dart';

class ChatController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  var isPhoneNumber = false.obs;
  var _isLoading = false.obs;
  var _orderStatus = ''.obs;
  var _limit = 20;
  final int _limitIncrement = 20;

  var _orderId = '';
  var _authToken = '';
  var _listMessageSize = 0;

  int get listMessageSize => _listMessageSize;

  bool get isLoading => _isLoading.value;

  String get orderStatus => _orderStatus.value;

  int get limit => _limit;

  String imageFileName = '';
  dynamic imageFile;

  final isButtonLoading = false.obs;

  final _chatRepository = ChatRepositoryImpl();

  void setLoading(bool loading) {
    _isLoading.value = loading;
    update();
  }

  void setOrderStatus(String orderStatus) {
    _orderStatus.value = orderStatus;
    update();
  }

  Stream<QuerySnapshot<Object?>> fetchAllChats(
      BuildContext context, String documentId) {
    Stream<QuerySnapshot<Object?>>? data;
    final chats =
        _chatRepository.fetchAllChats(_limit, firebaseFirestore, documentId);
    chats?.fold(
        (l) => showSnackBar(context, l.message.toString()), (r) => data = r);
    return data!;
  }

  Stream<QuerySnapshot<Object?>> fetchPaymentStatus(
      BuildContext context, String documentId) {
    Stream<QuerySnapshot<Object?>>? data;
    final chats = _chatRepository.fetchPaymentStatus(
        _limit, firebaseFirestore, documentId);
    chats?.fold(
        (l) => showSnackBar(context, l.message.toString()), (r) => data = r);
    return data!;
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

  Future<void> getPhoto(String token, menuOptions options, bool isPhoto,
      context, String orderId) async {
    final dynamic pickedFile = isPhoto
        ? await MediaService().uploadSingleImage(context, options)
        : await MediaService().uploadVideo(context, options);
    if (pickedFile == null) return;
    if (isPhoto) {
      imageFile = pickedFile;
      imageFileName = pickedFile.path;
      _uploadImage(token, context, imageFile, orderId);
    }
  }

  Future<void> _uploadImage(String token, BuildContext context,
      dynamic imageFile, String orderId) async {
    setLoading(true);
    String imageUrl = '';
    final chats = await _chatRepository.uploadImage(
        imageFile, _limit, firebaseFirestore, firebaseStorage);
    chats?.fold((l) => showSnackBar(context, l.message.toString()),
        (r) => imageUrl = r);
    sendMessage(token, '3232', "senderName", "receiverName", imageUrl, true, '',
        orderId);
    setLoading(false);
  }

  void checkPhoneNumber(String message) {
    final pattern = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    isPhoneNumber.value = pattern.hasMatch(message);
  }
}
