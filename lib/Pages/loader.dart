import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/model-4.jpg"),
          fit: BoxFit.fill
        ),
      ),
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.blue,
            size: 30.0,
          ),
        )
    );
  }
}