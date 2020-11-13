import 'package:flutter/material.dart';
import 'package:hacker_news/Pages/news_feed.dart';
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
      seconds: 10,
      routeName: "/",
      imageBackground: AssetImage("assets/launch-image.png"),
      loadingText: Text("HACKER NEWS",
          style: TextStyle(
              fontSize: 55,
              color: Colors.redAccent,
              backgroundColor: Colors.black)),
      useLoader: false,
      navigateAfterSeconds: NewsFeed(),
    );
  }
}
