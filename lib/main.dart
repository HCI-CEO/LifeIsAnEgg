import 'package:flutter/material.dart';
import 'package:life_is_an_egg/day_file_box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Is an Egg',
      theme: ThemeData(
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo_egg.png',
                fit: BoxFit.contain,
                height: 50,
              ),
            ],
          ),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[


              /************ 여기 캘린더 ************/


              FileBox(),
            ],
          ),
        ),// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}


