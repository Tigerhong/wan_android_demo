part of 'SystemDataChildItem.dart';

_SystemDataChildItemFromJson(Map<String, dynamic> json) {
  return SystemDataChildItem(
    json["children"],
    json['courseId'] as int,
    json['id'] as int,
    json['name'] as String,
    json['order'] as int,
    json['parentChapterId'] as int,
    json['userControlSetTop'] as bool,
    json['visible'] as int,
  );
}
