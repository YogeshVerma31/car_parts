import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String messageId;
  String senderId;
  String receiverId;
  String senderName;
  String receiverName;
  String message;
  bool isMedia;
  String mediaType;
  String dateTime;

  MessageModel(
      {required this.messageId,
      required this.senderId,
      required this.receiverId,
      required this.senderName,
      required this.receiverName,
      required this.message,
      required this.isMedia,
      required this.dateTime,
      required this.mediaType});

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': senderName,
      'receiverName': receiverName,
      'message': message,
      'isMedia': isMedia,
      'dateTime': dateTime,
      'mediaType': mediaType
    };
  }

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    return MessageModel(
      messageId: doc.get('messageId'),
      senderId: doc.get('senderId'),
      receiverId: doc.get('receiverId'),
      senderName: doc.get('senderName'),
      receiverName: doc.get('receiverName'),
      message: doc.get('message'),
      isMedia: doc.get('isMedia'),
      dateTime: doc.get("dateTime"),
      mediaType: doc.get('mediaType'),
    );
  }
}
