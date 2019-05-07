import 'package:json_annotation/json_annotation.dart';

part 'package:wan_android_demo/model/home/homebanner/HomeBannerItemModel.g.dart';

@JsonSerializable()
class HomeBannerItemModel {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  HomeBannerItemModel({this.desc, this.id, this.imagePath, this.isVisible,
      this.order, this.title, this.type, this.url});

  factory HomeBannerItemModel.fromJson(Map<String, dynamic> json) => _$HomeBannerItemModelnFromJson(json);
  Map<String, dynamic> toJson() => _$HomeBannerItemModelToJson(this);

}

