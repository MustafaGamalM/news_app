import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import '../moduls/webViewScreen.dart';

Widget itemBuilder(model, context) {
  return InkWell(
    onTap: () {
      navigateTo(WebViewScreen(model['url']), context);
    },
    child: Padding(
      padding:const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (model['urlToImage'] == null)
                        ? NetworkImage(
                            'https://media.gemini.media/img/large/2022/6/24/2022_6_24_15_40_54_904.jpeg')
                        : NetworkImage('${model['urlToImage']}')),
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      '${model['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    Text(
                      '${model['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]),
            ),
          )
        ],
      ),
    ),
  );
}

articleBuilder(list, {bool isearched = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => itemBuilder(list[index], context),
        separatorBuilder: (contex, index) =>
            Container(color: Colors.grey, height: 2),
        itemCount: list.length),
    fallback: (context) => Center(
      child: isearched ? Container() : CircularProgressIndicator(),
    ),
  );
}

navigateTo(Widget screen, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return screen;
  }));
}
