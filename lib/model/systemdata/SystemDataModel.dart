
import 'package:wan_android_demo/model/BaseModel.dart';
import 'package:wan_android_demo/model/systemdata/SystemDataItem.dart';

part 'SystemDataModel.g.dart';
class SystemDataModel extends BaseModel {

  SystemDataModel(List<SystemDataItem>data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory SystemDataModel.fromJson(Map<String, dynamic> json) =>
      _$SystemDataModelFromJson(json);
}
