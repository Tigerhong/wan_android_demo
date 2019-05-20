import 'package:json_annotation/json_annotation.dart';
part 'SystemDataChildItem.g.dart';
@JsonSerializable()
class SystemDataChildItem{
 var children;
 int courseId;
 int id;
 String name;
 int order;
 int parentChapterId;
 bool userControlSetTop;
 int visible;

 SystemDataChildItem(this.children, this.courseId, this.id, this.name,
     this.order, this.parentChapterId, this.userControlSetTop, this.visible);

 factory SystemDataChildItem.fromJson(Map<String, dynamic> json) =>_SystemDataChildItemFromJson(json);


}