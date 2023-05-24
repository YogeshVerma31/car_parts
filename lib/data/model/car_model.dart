import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  bool? status;
  String? message;
  List<CarData>? data;

  CarModel({this.status, this.message, this.data});

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class CarData {
  String? id;
  String? cid;
  String? models;
  String? status;

  CarData({
    this.id,
    this.models,
    this.cid,
    this.status,
  });

  factory CarData.fromJson(Map<String, dynamic> json) => _$CarDataFromJson(json);

  Map<String, dynamic> toJson() => _$CarDataToJson(this);
}
