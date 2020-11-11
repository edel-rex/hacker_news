// Web requests and Data fetching

import 'dart:convert';

import 'package:hacker_news/model/news_content.dart';
import 'package:hacker_news/web_services/urlList.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Webrequest {
  Future<Response> _getStory(int storyId) {
    return http.get(UrlList.urlForStory(storyId));
  }

  Future<List<Response>> getCommentsByStory(Story story) async {
    return Future.wait(story.commentIds.map((commentId) {
      return http.get(UrlList.urlForCommentById(commentId));
    }));
  }

  Future<List<Response>> getTopStories() async {
    final response = await http.get(UrlList.urlForTopStories());
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Unable to fetch data!");
    }
  }
}
