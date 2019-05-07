part of 'ProjectClassificationModel.dart';

ProjectClassificationModel _fromJson(Map<String, dynamic> json) {
  return ProjectClassificationModel(
    (json["data"] as List)
        ?.map((e) => e == null
            ? null
            : ProjectClassificationItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json["errorCode"] as int,
    json["errorMsg"] as String,
  );
}
