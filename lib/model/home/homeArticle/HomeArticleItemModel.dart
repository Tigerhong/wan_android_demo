import 'package:json_annotation/json_annotation.dart';
import 'package:wan_android_demo/model/home/homeArticle/AriticleTagModel.dart';

part 'package:wan_android_demo/model/home/homeArticle/HomeArticleItemModel.g.dart';
@JsonSerializable()
class HomeArticleItemModel {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String prefix;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<AriticleTagModel> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  HomeArticleItemModel({this.apkLink, this.author, this.chapterId,
      this.chapterName, this.collect, this.courseId, this.desc,
      this.envelopePic, this.fresh, this.id, this.link, this.niceDate,
      this.origin, this.prefix, this.projectLink, this.publishTime,
      this.superChapterId, this.superChapterName, this.tags, this.title,
      this.type, this.userId, this.visible, this.zan});
  factory HomeArticleItemModel.formJson(Map<String, dynamic> json)=>_HomeArticleItemModelFromJson(json);

  @override
  String toString() {
    return 'HomeArticleItemModel{apkLink: $apkLink, author: $author, chapterId: $chapterId, chapterName: $chapterName, collect: $collect, courseId: $courseId, desc: $desc, envelopePic: $envelopePic, fresh: $fresh, id: $id, link: $link, niceDate: $niceDate, origin: $origin, prefix: $prefix, projectLink: $projectLink, publishTime: $publishTime, superChapterId: $superChapterId, superChapterName: $superChapterName, tags: $tags, title: $title, type: $type, userId: $userId, visible: $visible, zan: $zan}';
  }

}


