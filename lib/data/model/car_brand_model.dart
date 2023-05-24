import 'package:json_annotation/json_annotation.dart';

part 'car_brand_model.g.dart';

@JsonSerializable()
class CarBrandModel {
  bool? status;
  String? message;
  List<Data>? data;

  CarBrandModel({this.status, this.message, this.data});

  factory CarBrandModel.fromJson(Map<String, dynamic> json) =>
      _$CarBrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarBrandModelToJson(this);
}

@JsonSerializable()
class Data {
  String? id;
  String? name;
  String? icon;
  String? status;
  String? display_order;
  String? added_on;
  String? tat;

  Data(
      {this.id,
      this.name,
      this.icon,
      this.status,
      this.display_order,
      this.added_on,
      this.tat});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
