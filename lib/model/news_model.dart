import 'dart:ffi';

class NewsModel {
  num id;
  String title;
  String excerpt;
  String content;
  int published_at;
  String post_modified;
  int first_update;
  String image;
  String category_name;

  NewsModel._(this.id, this.title, this.excerpt, this.content,
      this.published_at, this.post_modified, this.image, this.first_update,this.category_name);

  factory NewsModel.fromJson(dynamic json) => NewsModel._(
      json['id'],
      json['title'],
      json['excerpt'],
      json['content'],
      json['published_at'],
      json['post_modified'],
      json['image'],
      json['updated_at'],
      json['category_name']);
}
