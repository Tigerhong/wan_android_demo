import 'package:wan_android_demo/model/BaseModel.dart';
import 'package:wan_android_demo/model/wechat/WeChatItemModel.dart';
part 'WeChatModel.g.dart';

class WeChatModel extends BaseModel<List<WeChatItemModel>>{

  WeChatModel(List<WeChatItemModel>data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory WeChatModel.fromJson(Map<String, dynamic> json)=>
      _WeChatModelFromJson(json);
}