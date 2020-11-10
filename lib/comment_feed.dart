// Comment Section Page

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/news_content.dart';

class CommentListPage extends StatelessWidget {
  final List<Comment> comments;
  final Story story;

  CommentListPage({this.story, this.comments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(this.story.title), backgroundColor: Colors.redAccent),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/model-4.jpg"), fit: BoxFit.fill)),
          child: ListView.builder(
            itemCount: this.comments.length,
            itemBuilder: (context, index) {
              return this.comments[index].text == null
                  ? SizedBox()
                  : ListTile(
                      leading: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: AutoSizeText("${1 + index}",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 22, color: Colors.white))),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(this.comments[index].text,
                            style:
                                TextStyle(fontSize: 18, color: Colors.lime)),
                      ));
            },
          ),
        ));
  }
}
