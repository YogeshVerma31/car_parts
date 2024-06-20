import 'package:json_annotation/json_annotation.dart';
part 'ad_model.g.dart';

@JsonSerializable()
class AdModel {
  bool? status;
  String? message;
  List<AdModelList>? data;

  AdModel({this.status, this.message, this.data});
  factory AdModel.fromJson(Map<String, dynamic> json) =>
      _$AdModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdModelToJson(this);
}

@JsonSerializable()
class AdModelList {
  String? id;
  String? icon;
  String? message;

  AdModelList({this.id, this.icon, this.message});
  factory AdModelList.fromJson(Map<String, dynamic> json) =>
      _$AdModelListFromJson(json);

  Map<String, dynamic> toJson() => _$AdModelListToJson(this);

}
