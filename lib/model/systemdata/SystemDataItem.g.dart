part of 'SystemDataItem.dart';

_SystemDataItemFromJson(Map<String, dynamic> json) {

  return SystemDataItem(
      (json["children"] as List)
          ?.map((e) => e == null
          ? null
          : SystemDataChildItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['courseId'] as int,
      json['id'] as int,
    json['name'] as String,
    json['order'] as int,
    json['parentChapterId'] as int,
    json['userControlSetTop'] as bool,
    json['visible'] as int,
  );
}