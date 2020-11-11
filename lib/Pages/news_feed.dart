// News Updates Page / Home page

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hacker_news/model/news_content.dart';
import 'package:hacker_news/web_services/web_request.dart';

import 'comment_feed.dart';


class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<Story> _stories = List<Story>();

  @override
  void initState() {
    super.initState();
    _populateTopStories();
  }

  void _populateTopStories() async {
    final responses = await Webrequest().getTopStories();
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();

    setState(() {
      _stories = stories;
    });
  }

  void _navigateToShowCommentsPage(BuildContext context, int index) async {
    final story = this._stories[index];
    final responses = await Webrequest().getCommentsByStory(story);
    final comments = responses.map((response) {
      final json = jsonDecode(response.body);
      return Comment.fromJSON(json);
    }).toList();

    debugPrint("$comments");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CommentListPage(story: story, comments: comments)));
  }

// Exit Alert Dialog box
  Future<bool> _onExit() {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text("Do yo want to exit?"), actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () => Navigator.pop(context, true),
              ),
            ]));
  }

  // Pull to Refresh
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    _populateTopStories();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onExit,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Hacker News"),
            backgroundColor: Colors.redAccent,
            centerTitle: true,
          ),
          body: Opacity(
            opacity: 1,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/model-3.jpg"),
                      fit: BoxFit.fill)),
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemCount: _stories.length,
                  itemBuilder: (_, index) {
                    return ExpansionTile(
                      title: Text(_stories[index].title,
                          style: TextStyle(color: Colors.lime, fontSize: 18)),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              child: Text(
                                "${_stories[index].commentIds.length} comments",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (_stories[index].commentIds.length > 0) {
                                  _navigateToShowCommentsPage(context, index);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          )),
    );
  }
}