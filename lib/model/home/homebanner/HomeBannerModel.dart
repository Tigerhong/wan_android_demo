import 'package:json_annotation/json_annotation.dart';
import 'package:wan_android_demo/model/BaseModel.dart';
import 'package:wan_android_demo/model/home/homebanner/HomeBannerItemModel.dart';

part 'package:wan_android_demo/model/home/homebanner/HomeBannerModel.g.dart';
@JsonSerializable()
class HomeBannerModel extends BaseModel<List<HomeBannerItemModel>>{

  HomeBannerModel(List<HomeBannerItemModel> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);


  factory HomeBannerModel.fromJson(Map<String, dynamic> json) => _$HomeBannerModellnFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerModelToJson(this);

}