import 'package:json_annotation/json_annotation.dart';
import 'package:wan_android_demo/model/systemdata/SystemDataChildItem.dart';
part 'SystemDataItem.g.dart';
@JsonSerializable()
class SystemDataItem{
  List<SystemDataChildItem>children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;


  SystemDataItem(this.children, this.courseId, this.id, this.name,
      this.order, this.parentChapterId, this.userControlSetTop, this.visible);

  factory SystemDataItem.fromJson(Map<String, dynamic> json) =>_SystemDataItemFromJson(json);

}