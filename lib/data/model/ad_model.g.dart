// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdModel _$AdModelFromJson(Map<String, dynamic> json) => AdModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdModelList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdModelToJson(AdModel instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

AdModelList _$AdModelListFromJson(Map<String, dynamic> json) => AdModelList(
      id: json['id'] as String?,
      icon: json['icon'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdModelListToJson(AdModelList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'message': instance.message,
    };
