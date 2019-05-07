part of 'ProjectClassificationItemModel.dart';

ProjectClassificationItemModel _fromJson(Map<String, dynamic> json) {
  return ProjectClassificationItemModel(
    children: json["children"],
    courseId: json["courseId"] as int,
    id: json["id"] as int,
    name: json["name"] as String,
    order: json["order"] as int,
    parentChapterId: json["parentChapterId"] as int,
    userControlSetTop: json["userControlSetTop"] as bool,
    visible: json["visible"] as int,
  );
}