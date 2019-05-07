part of 'package:wan_android_demo/model/home/homeArticle/HomeArticleItemModel.dart';

HomeArticleItemModel _HomeArticleItemModelFromJson(Map<String, dynamic> json) {
  return HomeArticleItemModel(
    apkLink: json['apkLink'] as String,
    author: json['author'] as String,
    chapterId: json['chapterId'] as int,
    chapterName: json['chapterName'] as String,
    collect: json['collect'] as bool,
    courseId: json['courseId'] as int,
    desc: json['desc'] as String,
    envelopePic: json['envelopePic'] as String,
    fresh: json['fresh'] as bool,
    id: json['id'] as int,
    link: json['link'] as String,
    niceDate: json['niceDate'] as String,
    origin: json['origin'] as String,
    prefix: json['prefix'] as String,
    projectLink: json['projectLink'] as String,
    publishTime: json['publishTime'] as int,
    superChapterId: json['superChapterId'] as int,
    superChapterName: json['superChapterName'] as String,
    tags: (json['tags'] as List)
        ?.map((e) => e == null
            ? null
            : AriticleTagModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    type: json['type'] as int,
    userId: json['userId'] as int,
    visible: json['visible'] as int,
    zan: json['zan'] as int,
  );
}
