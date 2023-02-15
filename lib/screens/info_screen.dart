import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:terabayt_flutter/model/news_model.dart';

class InfoScreen extends StatefulWidget {
  NewsModel newsModel;

  InfoScreen({Key? key, required this.newsModel}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 12,
        backgroundColor: Color(0xff9f9f9f),
        title: Text(
          widget.newsModel.category_name,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff141414)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.newsModel.image,
              fit: BoxFit.fill,
              width: double.infinity,
              height: 250,
          placeholder: (context, url) => CupertinoActivityIndicator(color: Colors.black,radius: 15)
            ),
            Html(data: widget.newsModel.content,)
          ],
        ),
      ),
    );
  }
}
