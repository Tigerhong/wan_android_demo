part of 'HomeArticleDataModel.dart';

HomeArticleDataModel _HomeArticleDataModelFromJson(Map<String, dynamic> json) {
//  if (json == null) return HomeArticleDataModel();
  return HomeArticleDataModel(
    curPage: json["curPage"] as int,
    offset: json["offset"] as int,
    datas: (json["datas"] as List)
        ?.map((e) => e == null
            ? null
            : HomeArticleItemModel.formJson(e as Map<String, dynamic>))
        ?.toList(),
    over: json["over"] as bool,
    pageCount: json["pageCount"] as int,
    size: json["size"] as int,
    total: json["total"] as int,
  );
}
