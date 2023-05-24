import 'package:json_annotation/json_annotation.dart';
part 'my_order.g.dart';

@JsonSerializable()
class MyOrderModel {
  bool? status;
  String? message;
  List<Data>? data;

  MyOrderModel({this.status, this.message, this.data});

  factory MyOrderModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderModelToJson(this);
}

@JsonSerializable()
class Data {
  String? id;
  String? email;
  String? phone;
  String? pincode;
  String? area;
  String? building;
  String? city;
  String? sdescr;
  List<String>? media;
  String? media1;
  String? name;
  String? state;
  String? year;
  String? model;
  String? company;
  String? user_id;
  String? added_on;
  String? status;


  Data(
      {this.id,
      this.email,
      this.phone,
      this.pincode,
      this.area,
      this.building,
      this.city,
      this.sdescr,
      this.media,
      this.media1,
        this.status,
      this.name,
      this.state,
      this.year,
        this.added_on,
      this.model,
      this.company,
      this.user_id});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
