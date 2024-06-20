import 'package:car_parts/services/media_services_interface.dart';
import 'package:car_parts/ui/post_image_viewer.dart';
import 'package:car_parts/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/chat_controller.dart';
import '../data/model/chat_model.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../utils/color.dart';

class ChatScreen extends StatefulWidget {
  String? orderNumber;
  String? orderStatus;

  ChatScreen({Key? key, this.orderNumber, this.orderStatus}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController listScrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController productDetailController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  ChatController chatController = Get.put(ChatController());

  final FocusNode focusNode = FocusNode();
  String currentUserId = '';
  String userName = '';
  String userEmail = '';
  String userNumber = '';

  var listMessageSize = 0;

  @override
  void initState() {
    currentUserId = SharedPreference().getString('authToken');
    userName = SharedPreference().getString('name');
    userEmail = SharedPreference().getString('email');
    userNumber = SharedPreference().getString('number');
    listScrollController.addListener(_scrollListener);
    chatController.setOrderStatus(widget.orderStatus.toString());
    super.initState();
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        chatController.limit <= listMessageSize) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.orderNumber ?? '',
          style: titleStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              buildListMessage(),
              buildInput(),
            ],
          ),
          Obx(() => chatController.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink())
        ],
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
        child: StreamBuilder<QuerySnapshot>(
            stream: chatController.fetchAllChats(
                context, widget.orderNumber ?? '000-000'),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data?.docs.length ?? 0) > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index) {
                      return buildItem(context, snapshot.data?.docs[index]);
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No Chats"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
            }));
  }

  Widget buildInput() {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(maxHeight: 100, minHeight: 70),
      child: Row(
        children: <Widget>[
          // Button send image
          // Edit text
          Flexible(
            flex: 1,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 100, minHeight: 50),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => _modalBottomSheetMenu(),
                    child: const Icon(
                      Icons.image,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .6,
                        maxHeight: 100),
                    child: TextField(
                      onSubmitted: (value) {
                        onSendMessage(textEditingController.text, false);
                      },
                      onChanged: (value) {
                        chatController.checkPhoneNumber(value);
                      },
                      controller: textEditingController,
                      maxLines: 5,
                      minLines: 1,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type your message...',
                        hintStyle: titleStyle.copyWith(color: greyColor),
                      ),
                      // focusNode: focusNode,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Button send message

          Obx(() => chatController.isPhoneNumber.value != true
              ? InkWell(
                  onTap: () => onSendMessage(textEditingController.text, false),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: primaryColor),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox.shrink())
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? doc) {
    MessageModel messageChat = MessageModel.fromDocument(doc!);

    if (messageChat.senderId == currentUserId) {
      // Right (my message)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              messageChat.isMedia == false
                  // Text
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * .8,
                          minWidth: 30),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(1))),
                      child: Text(
                        messageChat.message,
                        style: titleStyle.copyWith(
                            color: primaryColor, fontSize: 15),
                      ),
                    )
                  : messageChat.isMedia == true
                      // Image
                      ? InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoViewerScreen(
                                imageUrl: messageChat.message,
                              ),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Material(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(1)),
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                messageChat.message,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, object, stackTrace) {
                                  return Material(
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      // Sticker
                      : Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'images/${messageChat.message}.gif',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
            ],
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            child: Text(
              DateFormat('dd MMM kk:mm a')
                  .format(DateTime.parse(messageChat.dateTime)),
              style: titleStyle.copyWith(
                color: greyColor,
                fontSize: 12,
              ),
            ),
          )
        ],
      );
    } else {
      // Left (peer message)
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                messageChat.isMedia == false
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .8,
                            minWidth: 30),
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(1),
                                bottomRight: Radius.circular(20))),
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          messageChat.message,
                          style: titleStyle.copyWith(
                              color: Colors.white, fontSize: 15),
                        ),
                      )
                    : InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoViewerScreen(
                                imageUrl: messageChat.message),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Material(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(1),
                                bottomRight: Radius.circular(20)),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              messageChat.message,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: greyColor100,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, object, stackTrace) =>
                                  Material(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'images/img_not_available.jpeg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
              ],
            ),
            // Time
            Container(
              margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Text(
                DateFormat('dd MMM kk:mm')
                    .format(DateTime.parse(messageChat.dateTime)),
                style: titleStyle.copyWith(
                  color: greyColor,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.pop(context);
                    chatController.getPhoto(currentUserId, menuOptions.camera,
                        true, context, widget.orderNumber ?? '000-0000-000');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Camera", style: titleStyle),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    chatController.getPhoto(currentUserId, menuOptions.gallery,
                        true, context, widget.orderNumber ?? '000-0000-000');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Gallery", style: titleStyle),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _showBottomBar() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Order Details",
                style: headingStyle.copyWith(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: productDetailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Detail',
                  hintText: 'Enter Product Detail',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: productPriceController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Price',
                  hintText: 'Enter Product Price',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void onSendMessage(String content, bool isMedia) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatController.sendMessage(currentUserId, '1234567890', "", "", content,
          isMedia, '', widget.orderNumber ?? '000-0000-00000');
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: greyColor);
    }
  }
}
