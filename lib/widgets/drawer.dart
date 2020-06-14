import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:project/themedata/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/pages/login_signup_page.dart';



String _email = "Hello, User!";
getEmail() async{
  final user = await FirebaseAuth.instance.currentUser();
  final userId = user.getIdToken().toString();
  final document = await Firestore.instance.collection('users').document(userId).get();
  _email = document['email'] == null ? "Hello, User!" : document['email'];
}

Widget drawerIcon(BuildContext context, String title, Function onpress, var icondata, var clr){
  return InkWell(
    onTap: (){ onpress();},
    child: Container(
      width: double.infinity,
      height: 40,
      margin: EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: clr,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Align(
        alignment: Alignment(-0.5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 15,),
            
            Icon(icondata, size: 20, color: Colors.white,),
            
            SizedBox(width: 15,),
            
            Text(
              title, 
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color:Colors.white, 
                //fontWeight: FontWeight.bold, 
                fontSize: 18, 
                fontFamily: 'RobotoSlab'
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future signOut() async {
    FirebaseAuth.instance.signOut();
    runApp(
      new MaterialApp(
        home: new LoginSignupPage(),
      )

  );
  }

Widget showDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 30,),
        GFListTile(
            avatar: GFAvatar(backgroundColor: Colors.white,),
            titleText: "UserName",
          ),
        // Header Image
        // DrawerHeader(
        //   child: Center(
        //     child: Container(
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(20),
        //         child: Image(image: AssetImage("assets/mustache.png")),
        //       ), 
        //     ),
        //   ),
        //   decoration: BoxDecoration(
        //     color: mytheme.primaryColor,
        //   ),
        // ),
        SizedBox(height: 30,),

        // My Dashboard
        drawerIcon(context, "Dashboard", (){ 
          Navigator.pop(context); Navigator.pop(context); 
          }, FontAwesomeIcons.home, Colors.green),
        // My Account
        drawerIcon(context, "My Account", (){ 
          Navigator.pop(context); Navigator.pop(context);
          Navigator.of(context).pushNamed('accountpage'); 
        }, Icons.account_circle, myAccountColor),
        // Helpline
        drawerIcon(context, "Helpline", (){
          Navigator.pop(context); Navigator.pop(context);
          Navigator.of(context).pushNamed('helpline');
        }, Icons.call, helplineColor),
        drawerIcon(context, "Reminders", (){
          Navigator.pop(context); Navigator.pop(context);
          Navigator.of(context).pushNamed('reminders');
        }, Icons.alarm, Colors.amber),
        drawerIcon(context, "Safety Test", (){
          Navigator.pop(context); Navigator.pop(context);
          Navigator.of(context).pushNamed('safetytest');
        }, Icons.local_hospital, stColor),
        drawerIcon(context, "Settings", (){
          Navigator.pop(context); Navigator.pop(context);
          Navigator.of(context).pushNamed('settings');
        }, Icons.settings, settingsColor),
        drawerIcon(context, "About Us.", (){}, Icons.info, Colors.cyan),

        Spacer(),

        // Log out
        drawerIcon(context, "Sign Out", (){signOut();}, FontAwesomeIcons.signOutAlt, Colors.grey[400],),
      ],
    ),
  );
}