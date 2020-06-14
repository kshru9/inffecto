
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   intializeNotifications() async {
//     var intializeAndroid = AndroidInitializationSettings('app_icon');
//     var intializeIOS = IOSInitializationSettings();
//     var intiSettings = InitializationSettings(intializeAndroid, intializeIOS);
//     await localNotificationsPlugin.initialize(intiSettings);
//   }
// @override
//   void initState() {
//     super.initState();
//     initializing();
//   }

// void initializing() async {
//     intializeAndroid = AndroidInitializationSettings('app_icon');
//     intializeIOS = IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     initializationSettings = InitializationSettings(
//         androidInitializationSettings, iosInitializationSettings);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

// Future<void> onSelectNotification(String payload){
//     if (payload != null){
//       print("notification details: $payload");
//     }
// }

// Future<void> showNotification() async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'your channel id', 'your channel name', 'your channel description',
//     importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
// var iOSPlatformChannelSpecifics = IOSNotificationDetails();
// var platformChannelSpecifics = NotificationDetails(
//     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
// await localNotificationsPlugin.show(
//     0, 'plain title', 'plain body', platformChannelSpecifics,
//     payload: 'item x');
// }

// Future<void> showDailyNotification(DateTime _time, int id, String title, String description) async {
//     var time = Time(_time.hour, _time.minute, _time.second);
//     var androidChannelSpecifics = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var channelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
//     await localNotificationsPlugin.showDailyAtTime(id, title, description,time, channelSpecifics);
// }

// Future<void> showHourlyNotifications(int id, String title, String description) async {
//   var androidChannelSpecifics = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
//   var iosChannelSpecifics = IOSNotificationDetails();
//   var channelSpecifics = NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
//   await localNotificationsPlugin.periodicallyShow(id, title, description, RepeatInterval.Hourly, channelSpecifics);
// }

// Future<void> cancelNotification(int id) {
//     localNotificationsPlugin.cancel(id);
// }