part of 'AriticleTagModel.dart';

AriticleTagModel _AriticleTagModelModelFromJson(Map<String, dynamic> json) {
  return AriticleTagModel(
    name: json["name"] as String,
    url: json["url"] as String,
  );
}
