
import 'package:dio/dio.dart';
import 'package:terabayt_flutter/model/news_model.dart';

import '../model/category_model.dart';

class CategoryAndProductApi{
   final Dio _dio;

  CategoryAndProductApi(  this._dio);

 Future<List<CategoryModel>> categoryList() async{
    final response = await Dio().get("https://www.terabayt.uz/api.php?action=categories");


    return (response.data  as List).map((e) => CategoryModel.fromJson(e)).toList();
}
 Future<List<NewsModel>> newsListbyCategory(num categoryId) async{
    final response = await Dio().get("https://www.terabayt.uz/api.php?action=posts&category=$categoryId&limit=30");


    return (response.data  as List).map((e) => NewsModel.fromJson(e)).toList();
}
 Future<List<NewsModel>> newsListPagginition(num categoryId,String first_update) async{
    final response = await Dio().get("https://www.terabayt.uz/api.php?action=posts&category=$categoryId&limit=30&first_update=$first_update");


    return (response.data  as List).map((e) => NewsModel.fromJson(e)).toList();
}


}