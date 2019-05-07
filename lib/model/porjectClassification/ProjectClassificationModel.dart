import 'package:wan_android_demo/model/BaseModel.dart';
import 'package:wan_android_demo/model/porjectClassification/ProjectClassificationItemModel.dart';
part 'PorjectClassificationModel.g.dart';

class ProjectClassificationModel extends BaseModel<List<ProjectClassificationItemModel>>{

  ProjectClassificationModel(List<ProjectClassificationItemModel>data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ProjectClassificationModel.fromJson(Map<String, dynamic> json)=>
      _fromJson(json);
}