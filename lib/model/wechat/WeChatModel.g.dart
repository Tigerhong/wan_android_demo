part of 'WeChatModel.dart';

WeChatModel _WeChatModelFromJson(Map<String, dynamic> json) {
  return WeChatModel(
    (json["data"] as List)
        ?.map((e) => e == null
            ? null
            : WeChatItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json["errorCode"] as int,
    json["errorMsg"] as String,
  );
}
