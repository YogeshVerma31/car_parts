// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrderModel _$MyOrderModelFromJson(Map<String, dynamic> json) => MyOrderModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyOrderModelToJson(MyOrderModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      pincode: json['pincode'] as String?,
      area: json['area'] as String?,
      building: json['building'] as String?,
      city: json['city'] as String?,
      sdescr: json['sdescr'] as String?,
      media:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList(),
      media1: json['media1'] as String?,
      status: json['status'] as String?,
      name: json['name'] as String?,
      state: json['state'] as String?,
      year: json['year'] as String?,
      added_on: json['added_on'] as String?,
      model: json['model'] as String?,
      orderId: json['orderId'] as String?,
      company: json['company'] as String?,
      user_id: json['user_id'] as String?,
      product_price: json['product_price'] as String?,
      shippingid: json['shippingid'] as String?,
      shipimage: json['shipimage'] as String?,
      shippingcompany: json['shippingcompany'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'orderId': instance.orderId,
      'phone': instance.phone,
      'pincode': instance.pincode,
      'area': instance.area,
      'building': instance.building,
      'city': instance.city,
      'sdescr': instance.sdescr,
      'media': instance.media,
      'media1': instance.media1,
      'name': instance.name,
      'state': instance.state,
      'year': instance.year,
      'model': instance.model,
      'company': instance.company,
      'user_id': instance.user_id,
      'added_on': instance.added_on,
      'status': instance.status,
      'product_price': instance.product_price,
      'shippingid': instance.shippingid,
      'shipimage': instance.shipimage,
      'shippingcompany': instance.shippingcompany,
    };
