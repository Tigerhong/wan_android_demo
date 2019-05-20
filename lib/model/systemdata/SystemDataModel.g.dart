part of 'SystemDataModel.dart';

_$SystemDataModelFromJson(Map<String, dynamic> json) {
  return SystemDataModel(
       (json["data"] as List)
          ?.map((e) => e == null
          ? null
          : SystemDataItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}