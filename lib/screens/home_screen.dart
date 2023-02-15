import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terabayt_flutter/model/category_model.dart';
import 'package:terabayt_flutter/model/news_model.dart';
import 'package:terabayt_flutter/screens/category_screen.dart';

import '../api/category_api.dart';
import 'drawer/home_drawer.dart';
import 'info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Status { initial, loading, fail, success }

enum _StatusPag { initial, loading, fail, success }

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadData();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {}
    });
    super.initState();
  }

  Future fetch(first_update) async {
    statusPag = _StatusPag.loading;
    var aa = await api.newsListPagginition(0, first_update);
    news.addAll(aa);
    statusPag = _StatusPag.success;
    setState(() {});
  }

  var categories = <CategoryModel>[];
  var news = <NewsModel>[];
  final api = CategoryAndProductApi(Dio());
  var current = 0;
  var status = _Status.initial;
  var statusPag = _StatusPag.initial;
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    print(status);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9f9f9f),
        title: Text(
          "Terabayt",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19,
              color: Color(0xff141414)),
        ),
      ),
      drawer: HomeDrawer(categories),
      body: Builder(builder: (context) {
        if (status == _Status.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (status == _Status.success) {
          return ListView.builder(
              itemCount: news.length + 1,
              controller: controller,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index < news.length) {
                  if(index%4==0){
                    return CardItem(imageUrl: news[index].image, textModel: news[index].title ,ontap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return  InfoScreen(newsModel: news[index],);

                      },));
                    },);

                  }
                  else{
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return  InfoScreen(newsModel: news[index],);

                        },));

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Card(
                          elevation: 3,
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    height: 120,
                                    fit: BoxFit.fill,
                                    width: 120,
                                    imageUrl: news[index].image,
                                    placeholder: (context, url) => CupertinoActivityIndicator(color: Colors.black,radius: 15),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        news[index].title,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 14.8,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                        maxLines: 3,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  }
                }
                else {
                  var first_update = news[index - 1].published_at.toString();
                  fetch(first_update);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              });
        }
        return Text(status.name);
      }),
    );
  }

  Future<void> loadData() async {
    status = _Status.loading;
    setState(() {});
    try {
      news = await api.newsListbyCategory(482);
      categories = await api.categoryList();
      status = _Status.success;
      print(categories.toString());
      print(news.toString());
      setState(() {});
    } catch (e) {
      status = _Status.fail;
      print(e);
      setState(() {});
    }
  }
}
class CardItem extends StatelessWidget {
  final String imageUrl;
  final String textModel;
  Function()? ontap;
  CardItem({Key? key, required this.imageUrl, required this.textModel,required this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

            return InkWell(
              onTap: ontap,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,
                    margin:
                    EdgeInsets.only(left: 4, right: 4, top: 5, bottom: 10),
                    child: CachedNetworkImage(
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.white12,
                              BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => CupertinoActivityIndicator(radius: 22, ),
                      imageUrl: imageUrl,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 230,

                    color: Colors.black26,
                    margin: EdgeInsets.only(left: 4, right: 4, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:  [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                textModel.toString(),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );

  }
}

