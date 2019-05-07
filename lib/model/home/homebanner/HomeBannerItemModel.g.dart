part of 'HomeBannerItemModel.dart';
Map<String, dynamic> _$HomeBannerItemModelToJson(
    HomeBannerItemModel instance)=> <String, dynamic>{
  'desc': instance.desc,
  'id': instance.id,
  'imagePath': instance.imagePath,
  'isVisible': instance.isVisible,
  'order': instance.order,
  'title': instance.title,
  'type': instance.type,
  'url': instance.url,
};

HomeBannerItemModel _$HomeBannerItemModelnFromJson(Map<String, dynamic> json) {
  return HomeBannerItemModel(
    desc: json['desc'] as String,
    id: json['id'] as int,
    imagePath: json['imagePath'] as String,
    isVisible: json['isVisible'] as int,
    order: json['order'] as int,
    title: json['title'] as String,
    type: json['type'] as int,
    url: json['url'] as String,
  );
}
