import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getflutter/getflutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/pages/login_signup_page.dart';
import 'package:project/pages/settings_page.dart';
import 'package:project/services/authentication.dart';
import 'package:project/services/faq.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:getflutter/colors/gf_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

_givelsr()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double lsr = prefs.getDouble('lsr');
  return lsr;
}
void set_lsr(double rating)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('lsr', rating);
}

_test_taken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int a = prefs.getInt('testtaken');
  return a;
}

inc_test_taken()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int a = prefs.getInt('testtaken');
  if(a == null) await prefs.setInt('testtaken', 1);
  else await prefs.setInt('testtaken', a+1);
}


Future<String> giveCity() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String a = prefs.getString("city");
  print("City is $a. which is ");

  if(a == null){
    return "--Unknown--";
  }
  else{
    return a;
  }
}

getDiff() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String dmy = prefs.getString('starttime');
  var now = DateTime.now();

  if(dmy == null || now == null){
    return 0;
  }

  print(dmy);
  print(now);

  var start = DateTime.parse(dmy);
  var diff = now.difference(start);
  return diff.inDays+1;
}

getName()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('name');
  return name;
}

class AccountPage extends StatefulWidget {
  static const String tag = 'accountpage';
  AccountPage({this.auth});
  final BaseAuth auth;
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  imageWidget() async {
    // Asking for Storage Permission
    Map<PermissionGroup, PermissionStatus> perm = await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    String path = (await getTemporaryDirectory()).path;
    File profileImage = File("$path/profile.jpg");
    
    if(profileImage.existsSync() == false){
      return Align(
        alignment: Alignment.center,
        child:  CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey[400],
          child: Icon(Icons.person, size: 80, color: Colors.blueGrey,),
        ),
      ); 
    }
    else{
      imageCache.clear(); // Very Important Line, Don't remove     
      return AvatarGlow(
        glowColor: Colors.blue,
        endRadius: 150,
        duration: Duration(milliseconds: 1200),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 0),
        child: Material(
          elevation: 10,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.lightBlue,
            radius: 80,
            child: Container(
              width: 150,
              height: 150 ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                image: DecorationImage(
                  image: Image.file(profileImage).image,
                  fit: BoxFit.cover
                )
              ),
            )
          ),
        ),
      );
    }
  }  
  
  Future setProfilePic() async {
    final picker = ImagePicker();
    PickedFile pickedFile;
    // asking for permissions
    Map<PermissionGroup, PermissionStatus> perm = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    
    // checking permissions
    PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    try{
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }
    catch(e){
      print(e);
      print("Returning, profile picture setting failed");
      return null;
    }
  

    // Saving in the memory
    if(permissionStatus == PermissionStatus.granted){
      try{
        String path = (await getTemporaryDirectory()).path;
        File(pickedFile.path).copy("$path/profile.jpg");
        setState(() {});
      }catch(e){
        print(e);
      }
    }
    else{
      print("Unable to save image.");
    }
  }




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
    getEmail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GFColors.LIGHT,
      body: ListView(
        children: <Widget>[
          //Spacer(),
          SizedBox(height: 30),
          FutureBuilder(
            future: imageWidget(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
              if(snapshot.connectionState == ConnectionState.done){
                return snapshot.data;
              }
              else{
                return Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  ),
                );
              }
            },   
          ),

          //Spacer(),
          
          MaterialButton(
            onPressed: ()=>setProfilePic(),
            child: Text("Change Profile Picture", style: TextStyle(color: GFColors.DARK),),
            color: Colors.lightBlueAccent
          ),
          //Spacer(),
          SizedBox(height: 30),
          Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.pages, color: Colors.blue,),
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));}
          ),
          Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ListTile(
            title: Text("Spread the word"),
            leading: Icon(Icons.share, color: Colors.blue,),
            onTap: (){
              final RenderBox box = context.findRenderObject();
              Share.share('Look what I made',
                sharePositionOrigin:
                  box.localToGlobal(Offset.zero) &
                    box.size
              );
            },
          ),
          Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ListTile(
            title: Text("Rate Us"),
            leading: Icon(Icons.rate_review, color: Colors.blue,),
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
            title: Text("FAQs"),
            leading: Icon(Icons.android, color: Colors.blue,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FaqPage()));
            },
          ),
          Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          
          ListTile(
            title: Text("Log out"),
            leading: Icon(Icons.android, color: Colors.blue,),
            onTap: ()=>signOut(),
          ),
        
          Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),

          //Spacer(),
        ],
      ),    
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:getflutter/components/avatar/gf_avatar.dart';
// import 'package:getflutter/components/list_tile/gf_list_tile.dart';
// import 'package:getflutter/getflutter.dart';
// import 'package:project/pages/login_signup_page.dart';
// import 'package:project/pages/settings_page.dart';
// import 'package:project/services/authentication.dart';
// import 'package:flutter/material.dart';
// import 'package:project/services/faq.dart';
// import 'package:share/share.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// _givelsr()async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   double lsr = prefs.getDouble('lsr');
//   return lsr;
// }
// void set_lsr(double rating)async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setDouble('lsr', rating);
// }

// _test_taken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   int a = prefs.getInt('testtaken');
//   return a;
// }

// inc_test_taken()async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   int a = prefs.getInt('testtaken');
//   if(a == null) await prefs.setInt('testtaken', 1);
//   else await prefs.setInt('testtaken', a+1);
// }


// Future<String> giveCity() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String a = prefs.getString("city");
//   print("City is $a. which is ");

//   if(a == null){
//     return "--Unknown--";
//   }
//   else{
//     return a;
//   }
// }

// getDiff() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String dmy = prefs.getString('starttime');
//   var now = DateTime.now();

//   if(dmy == null || now == null){
//     return 0;
//   }

//   print(dmy);
//   print(now);

//   var start = DateTime.parse(dmy);
//   var diff = now.difference(start);
//   return diff.inDays+1;
// }

// getName()async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String name = prefs.getString('name');
//   return name;
// }

// class AccountPage extends StatefulWidget {
//   static const String tag = 'accountpage';
//   AccountPage({this.auth});
//   final BaseAuth auth;
//   @override
//   _AccountPageState createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {

//   String email;
//   getEmail() async {
//     final user = await FirebaseAuth.instance.currentUser();
//     final userId = user.getIdToken().toString();
//     final snapshot = await Firestore.instance.collection('users').document(userId).get();
//     setState(() {
//       email=snapshot.data['email'];
//     });
//   }

//     Future signOut() async {
//     FirebaseAuth.instance.signOut();
//     runApp(
//       new MaterialApp(
//         home: new LoginSignupPage(),
//       )

//   );
//   }

//   void initState(){
//     super.initState();
//     //getEmail();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GFColors.LIGHT,
//       body: ListView(
//         children: <Widget>[
//           GFListTile(
//             avatar: GFAvatar(backgroundColor: Colors.white,),
//             titleText: email,
//           ),
//           // ListTile(
//           //   title: Text("Username"),
//           //   //subtitl,
//           //   leading: Icon(Icons.android, color: Colors.blue,),
//           // ),
//           Divider(
//               color: Colors.grey,
//               height: 20,
//               thickness: 1,
//               indent: 20,
//               endIndent: 20,
//             ),
//           ListTile(
//             title: Text("Settings"),
//             leading: Icon(Icons.pages, color: Colors.blue,),
//             onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));}
//           ),
//           Divider(
//               color: Colors.grey,
//               height: 20,
//               thickness: 1,
//               indent: 20,
//               endIndent: 20,
//             ),
//           ListTile(
//             title: Text("Spread the word"),
//             leading: Icon(Icons.share, color: Colors.blue,),
//             onTap: (){
//               final RenderBox box = context.findRenderObject();
//                               Share.share('look what I made',
//                                   sharePositionOrigin:
//                                       box.localToGlobal(Offset.zero) &
//                                           box.size);
//             },
//           ),
//           Divider(
//               color: Colors.grey,
//               height: 20,
//               thickness: 1,
//               indent: 20,
//               endIndent: 20,
//             ),
//           ListTile(
//             title: Text("Rate Us"),
//             leading: Icon(Icons.rate_review, color: Colors.blue,),
//             onTap: (){},
//           ),
//           Divider(
//               color: Colors.grey,
//               height: 20,
//               thickness: 1,
//               indent: 20,
//               endIndent: 20,
//             ),
//           ListTile(
//             title: Text("FAQs"),
//             leading: Icon(Icons.android, color: Colors.blue,),
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>FaqPage()));
//             },
//           ),
//           Divider(
//               color: Colors.grey,
//               height: 20,
//               thickness: 1,
//               indent: 20,
//               endIndent: 20,
//             ),
//           ListTile(
//             title: Text("Log out"),
//             leading: Icon(Icons.android, color: Colors.blue,),
//             onTap: ()=>signOut(),
//           ),
//           Divider(
//               color: Colors.grey,
//               height: 20,
//               thickness: 1,
//               indent: 20,
//               endIndent: 20,
//             ),
//         ],
//       )
//     );
//   }

// }


