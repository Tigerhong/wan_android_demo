import 'package:json_annotation/json_annotation.dart';
part 'ProjectClassificationItemModel.g.dart';

@JsonSerializable()
class ProjectClassificationItemModel {
  var children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  ProjectClassificationItemModel({this.children, this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.userControlSetTop, this.visible});

  factory ProjectClassificationItemModel.fromJson(Map<String, dynamic> json)=>
      _fromJson(json);

}
