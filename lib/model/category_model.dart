import 'package:flutter/material.dart';

class CategoryModel{
  num id;
  String name;
  String slug;

  CategoryModel._(this.id, this.name, this.slug);

  factory CategoryModel.fromJson(dynamic json) => CategoryModel._(
     json['id'],
     json["name"],
     json['slug'],);

}