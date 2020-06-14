import 'package:flutter/material.dart';
import 'package:project/pages/aboutUs.dart';
import 'package:project/pages/account_page.dart';
import 'package:project/pages/create_reminders_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/rename.dart';
import 'package:project/pages/root_page.dart';
import 'package:project/pages/settings_page.dart';
import 'package:project/safety_test/firstquestion.dart';
import 'package:project/safety_test/fourthquestion.dart';
import 'package:project/safety_test/secondquestion.dart';
import 'package:project/safety_test/submitpage.dart';
import 'package:project/safety_test/thirdquestion.dart';
import 'package:project/services/authentication.dart';
import 'package:project/services/faq.dart';
import 'package:project/services/helpline.dart';
import 'package:project/themedata/themes.dart';
import 'package:project/transitions/flutter_page_transition.dart';

void main() {
  // Just for debugging process
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project',
      debugShowCheckedModeBanner: false,
      theme: mytheme,
      home: RootPage(auth: Auth()),
      onGenerateRoute: (RouteSettings routeSettings){
        return PageRouteBuilder<dynamic>(

          settings: routeSettings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            switch (routeSettings.name){
              case HomePage.tag:
                return HomePage();
              case AccountPage.tag:
                return AccountPage();
              case AboutUs.tag:
                return AboutUs();
              case Helpline.tag:{
                return Helpline();
              }
              case HealthReminders.tag:{
                return HealthReminders();
              }
              case Settings.tag:{
                return Settings();
              }
              case MyApp1.tag:{
                return new MyApp1();                
              }
              case MyApp2.tag:{
                return MyApp2();
              }
              case MyApp3.tag:{
                return MyApp3();
              }
              case MyApp4.tag:{
                return MyApp4();
              }
              case MyAppSubmitPage.tag:{
                return MyAppSubmitPage();
              }
              case FaqPage.tag:{
                return FaqPage();
              }
              case Rename.tag:
              return Rename();

              default:
                return Settings();
            }
          },
          transitionDuration: Duration(milliseconds:500),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
              return effectMap[PageTransitionType.slideInLeft](
                Curves.linearToEaseOut,
                animation, 
                secondaryAnimation, 
                child
              );
            }
          );
        },
    );
  }
}
