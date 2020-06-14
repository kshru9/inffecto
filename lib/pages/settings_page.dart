import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:project/pages/login_signup_page.dart';
import 'package:project/services/authentication.dart';
import 'package:project/themedata/themes.dart';
import 'package:project/widgets/drawer.dart';


var dropdownValue = 'Purple';

class Settings extends StatefulWidget{
  static const String tag = "settings";
  Settings({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => SettingsState();
}

bool dataSync = true;


class SettingsState extends State<Settings>{
  String email;
  getEmail() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userId = user.getIdToken().toString();
    final snapshot = await Firestore.instance.collection('users').document(userId).get();
    setState(() {
      email=snapshot.data['email'];
    });
  }

    Future signOut() async {
    FirebaseAuth.instance.signOut();
    runApp(
      new MaterialApp(
        home: new LoginSignupPage(),
      )

  );
  }

  void initState(){
    super.initState();
    //getEmail();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(context),
      appBar: AppBar(
        backgroundColor: settingsColor,
        title: Text(
          "Settings",
        ),
      ),  
      body: Container(
        color: GFColors.LIGHT,
        child:ListView(
        children: <Widget>[
          ListTile(
            title: Text("Change Password"),
            leading: Icon(Icons.pages, color: Colors.blue,),
            onTap: (){
              widget.auth.resetPassword(email);
            }
          ),
          Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ListTile(
            title: Text("Privacy Policy"),
            leading: Icon(Icons.android, color: Colors.blue,),
            onTap: (){},
          ),
          Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ListTile(
            title: Text("User Agreement"),
            leading: Icon(Icons.android, color: Colors.blue,),
            onTap: (){},
          ),
          Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
        ],
      ),
      // body:ListView(
      //   physics: AlwaysScrollableScrollPhysics(),
      //   children: <Widget>[
      //     SizedBox(height: 10,),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "Update Photo",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){
      //         Navigator.push(context, MaterialPageRoute(builder: (context)=>Faq()));
      //       },
      //       child: Text(
      //         "FAQ Page",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "Account Settings",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "Notification Settings",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "Ringtone Settings",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Text(
      //             "Data Sync: ",
      //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //           ),
      //           SizedBox(width: 10,),
      //           ToggleSwitch(
      //             minWidth: 80, 
      //             activeBgColor: Colors.red, 
      //             activeTextColor: Colors.white, 
      //             inactiveBgColor: Colors.grey[400], 
      //             inactiveTextColor: Colors.white, 
      //             labels: <String>["Off", "On"],
      //             onToggle: (value){
      //               if(value == 0){
      //                 print(value);
      //               }
      //               else{
      //                 print(value);
      //               }
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "User Agreement",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),

      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "Privacy Policy",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
 
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "Feedback",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),
          
      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){
      //         final RenderBox box = context.findRenderObject();
      //                         Share.share('look what I made',
      //                             sharePositionOrigin:
      //                                 box.localToGlobal(Offset.zero) &
      //                                     box.size);
      //       },
      //       child: Text(
      //         "Spread the word",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),





      //     MaterialButton(
      //       elevation: 1,
      //       onPressed: (){},
      //       child: Text(
      //         "Version: 3.2.1",
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54),
      //       ),
      //     ),
      //     Divider( height: 10, thickness: 2, endIndent: 10, indent: 10, ),


      //   ],
      // ),
    ));
  }
}