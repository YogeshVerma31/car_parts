// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => ChatData(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ChatDataKit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ChatDataKit _$ChatDataKitFromJson(Map<String, dynamic> json) => ChatDataKit(
      messg: json['messg'] as String?,
      add_on: json['add_on'] as String?,
      image: json['media'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ChatDataKitToJson(ChatDataKit instance) =>
    <String, dynamic>{
      'messg': instance.messg,
      'add_on': instance.add_on,
      'type': instance.type,
      'media':instance.image
    };
