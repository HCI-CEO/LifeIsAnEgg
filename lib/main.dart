import 'package:flutter/material.dart';
import 'package:life_is_an_egg/calendar.dart';
import 'package:life_is_an_egg/custom_notification.dart';
import 'package:life_is_an_egg/day_file_box.dart';
import 'package:life_is_an_egg/global_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=>CalendarData(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 30,),
                    Image.asset(
                      'images/logo_egg.png',
                      fit: BoxFit.contain,
                      height: 50,
                    ),
                    NotificationTest(),
                  ],
                ),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox (
                      height: 404,
                      width: 355,
                      child:
                      Calendar(),
                    ),
                    const FileBox(),
                  ],
                ),
              ),// This trailing comma makes auto-formatting nicer for build methods.
            ),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/loading.gif',
            width: 100
        ),
      ),
    );
  }
}