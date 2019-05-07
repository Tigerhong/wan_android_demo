import 'package:json_annotation/json_annotation.dart';
part 'AriticleTagModel.g.dart';

@JsonSerializable()
class AriticleTagModel {
  String name;
  String url;

  AriticleTagModel({this.name, this.url});

  factory AriticleTagModel.fromJson(Map<String, dynamic> json)=>
      _AriticleTagModelModelFromJson(json);

}