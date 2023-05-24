import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatData {
  bool? status;
  String? message;
  List<ChatDataKit>? data;

  ChatData({this.status, this.message, this.data});

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}

@JsonSerializable()
class ChatDataKit {
  String? messg;
  String? add_on;
  String? image;
  String? type;

  ChatDataKit({this.messg, this.add_on, this.type,this.image});

  factory ChatDataKit.fromJson(Map<String, dynamic> json) =>
      _$ChatDataKitFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataKitToJson(this);
}
