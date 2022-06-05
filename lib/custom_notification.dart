import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationTestState();
  }
}

class _NotificationTestState extends State<NotificationTest> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initState() {
    super.initState();
    var androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android:androidSetting);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void onSelectNotification(String? payload) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Good Morning!'),
          content: Text('$payload'),
        ));
  }

  Future _showNotificationAtTime() async {
    var scheduledNotificationDateTime = new DateTime.now().add(new Duration(seconds: 5));

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
    );

    var platformChannelSpecifics = NotificationDetails(android : androidPlatformChannelSpecifics );

    await _flutterLocalNotificationsPlugin.schedule(
      1,
      'Are you awake?',
      'Record your wake-up time!',
      DateTime.now().add(Duration(seconds: 5)),
      platformChannelSpecifics,
      payload: 'Your wake-up time is recorded.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showNotificationAtTime,
      child: Container(width: 30, height: 50, color: Colors.white,),
    );
  }
}