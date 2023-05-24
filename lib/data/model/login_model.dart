import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class Data {
  String? name;
  String? phone;
  String? alt_phone;
  String? email;
  String? building;
  String? area;
  String? city;
  String? state;
  String? pincode;
  String? token;

  Data(
      {this.name,
      this.phone,
      this.email,
      this.building,
      this.area,
      this.city,
      this.state,
      this.pincode,
        this.alt_phone,
      this.token});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
