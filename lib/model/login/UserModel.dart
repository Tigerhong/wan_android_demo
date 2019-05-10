import 'package:json_annotation/json_annotation.dart';
import 'package:wan_android_demo/model/BaseModel.dart';

import 'UserDetailModel.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel extends BaseModel<UserDetailModel> {
  UserModel(UserDetailModel data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);
}
