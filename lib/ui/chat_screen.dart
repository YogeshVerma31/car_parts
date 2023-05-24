import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_parts/services/media_services_interface.dart';
import 'package:car_parts/ui/post_image_viewer.dart';
import 'package:car_parts/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controller/chat_controller.dart';
import '../providers/network/api_endpoint.dart';

class ChatScreen extends StatefulWidget {
  String orderNumber;

  ChatScreen({Key? key, required this.orderNumber}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.put(ChatController());
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatController.getChat(widget.orderNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: Get.width * 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Number: ${widget.orderNumber}',
                style: titleStyle.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.white),
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Expanded(
              child: chatController.isLoading.value == false
                  ? _chatList()
                  : Container())),
          const SizedBox(
            height: 8.0,
          ),
          Obx(() => Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(Icons.image),
                      onTap: () {
                        _modalBottomSheetMenu();
                      },
                    ),
                    Container(
                      width: Get.width * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15.0),
                          border: InputBorder.none,
                          hintText: "Text Message here ..",
                        ),
                        cursorColor: Colors.blue,
                      ),
                    ),
                    chatController.isButtonLoading.value
                        ? Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1.5,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              chatController.postChat(
                                  widget.orderNumber, textController.text);
                              textController.text = '';
                            },
                            child: Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                              child: const Center(
                                child: Icon(
                                  Icons.send_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
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
                    Get.back();
                    chatController.getPhoto(
                        widget.orderNumber, menuOptions.camera, true, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Camera", style: titleStyle),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    chatController.getPhoto(
                        widget.orderNumber, menuOptions.gallery, true, context);
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

  Widget _chatList() {
    return ListView.builder(
        reverse: true,
        itemCount: chatController.chatDataList.isNotEmpty
            ? chatController.chatDataList.length
            : 0,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                chatController.chatDataList[index].type == 'admin'
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    chatController.chatDataList[index].type == 'user'
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          chatController.chatDataList[index].type == 'user'
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Colors.white,
                          elevation: 2.0,
                          shadowColor: Colors.white,
                          child: Container(
                              width: MediaQuery.of(context).size.width * .8,
                              alignment:
                                  chatController.chatDataList[index].type ==
                                          'user'
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white),
                              child: chatController.chatDataList[index].image ==
                                      ''
                                  ? Text(
                                      chatController.chatDataList[index].messg!,
                                      style: titleStyle.copyWith(
                                          color: Colors.black, fontSize: 16
                                          // fontSize: CommonFontSizes.sp16
                                          ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        Get.to(()=>PhotoViewerScreen(imageUrl: APIEndpoint.baseImageApi +
                                            chatController
                                                .chatDataList[index]
                                                .image!,));
                                      },
                                      child: SizedBox(
                                          height: 200.0,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.blue,
                                                    strokeWidth: 1.2,
                                                  ),
                                                ),
                                                imageUrl:
                                                    APIEndpoint.baseImageApi +
                                                        chatController
                                                            .chatDataList[index]
                                                            .image!,
                                                width: 200,
                                                height: 180,
                                                fit: BoxFit.cover,
                                              ))
                                          // CachedNetworkImage(
                                          //   placeholder: (context, url) =>
                                          //   const Center(
                                          //     child: CircularProgressIndicator(
                                          //       color: CommonColors.iconColors,
                                          //       strokeWidth: 1.2,
                                          //     ),
                                          //   ),
                                          //   imageUrl:
                                          //   chatController.linkList[index],
                                          //   fit: BoxFit.cover,
                                          // ),
                                          ),
                                    )),
                        ),
                        Text(
                            DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(chatController
                                    .chatDataList[index].add_on!)),
                            style: titleStyle.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                                // fontSize: CommonFontSizes.sp16
                                ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
