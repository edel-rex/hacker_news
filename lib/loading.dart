import 'package:flutter/material.dart';
import 'package:hacker_news/news_feed.dart';
import 'package:splashscreen/splashscreen.dart';

// intro loading screen
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      routeName: "/",
      seconds: 5,
      backgroundColor: Colors.grey[900], 
      image: Image.asset('assets/loading.gif'),
      photoSize: 250,
      useLoader: false,
      navigateAfterSeconds: NewsFeed(),
    );
  }
}
