part of 'HomeBannerModel.dart';

Map<String, dynamic> _$HomeBannerModelToJson(HomeBannerModel instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data,
    };

HomeBannerModel _$HomeBannerModellnFromJson(Map<String, dynamic> json) {
  return HomeBannerModel(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : HomeBannerItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}
