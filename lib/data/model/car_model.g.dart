// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CarData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CarData _$CarDataFromJson(Map<String, dynamic> json) => CarData(
      id: json['id'] as String?,
      models: json['models'] as String?,
      cid: json['cid'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CarDataToJson(CarData instance) => <String, dynamic>{
      'id': instance.id,
      'cid': instance.cid,
      'models': instance.models,
      'status': instance.status,
    };
