import 'package:flutter/material.dart';
import 'package:terabayt_flutter/screens/category_screen.dart';

import '../../model/category_model.dart';

class HomeDrawer extends StatelessWidget {
  List<CategoryModel> categories;

  HomeDrawer(this.categories, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff9f9f9f),
      child: Container(
        width: double.infinity,
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              height: 11,
              width: double.infinity,
              child: Center(
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/img.png"),
                ),
              ),
            )),
            Container(
              width: double.infinity,
              height: 400,
              child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    return CustomItem(
                      text: categories[index].name,
                      categoryId: categories[index].id,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  onTap(num newsCategoryId, String categoryName, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CategoryScreen(
            caetgoryId: newsCategoryId.toInt(), categoryName: categoryName);
      },
    ));
  }
}

class CustomItem extends StatelessWidget {
  String text;
  num categoryId;

  CustomItem({Key? key, required this.text, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Color(0xff838383)),
                bottom: BorderSide(color: Color(0xff838383)))),
        child: InkWell(
          onTap: () {
             Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CategoryScreen(
                    caetgoryId: categoryId.toInt(),
                    categoryName: text);
              },
            ));
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, top: 18, bottom: 18),
            width: double.infinity,
            child: Text(text,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
