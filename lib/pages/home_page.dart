import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
import 'package:project/services/authentication.dart';
import 'package:project/themedata/themes.dart';
import '../style/allstyles.dart';


var LSR = -1; // add into sp

Widget _safetyStatus(){
  if(LSR!=-1){
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 5,
          color: GFColors.PRIMARY
        ),
      ),
      child: Text(
        "Latest Safety Rating: $LSR",
        style: TextStyle(
          color: GFColors.PRIMARY,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
  else{
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 5,
            color: Colors.redAccent
          ),
        ),
        child: Text(
          "Safety test not taken.\nClick for giving one",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      );
  }
}

class HomePage extends StatefulWidget {
  static const String tag = 'homepage';
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
    : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    bool once = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child:Text("Dashboard",)),
      ),
      body: WillPopScope(
      onWillPop: (){
        if(once){
          SystemNavigator.pop();
        }
        else{
          once = true;
          Fluttertoast.showToast(
            msg: "Press Once Again to Exit"
          );
        }

        return null;
      },  
      child: SafeArea(
        child: Scaffold(
          backgroundColor: GFColors.LIGHT,
          body: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: <Widget>[
              makeDashboardIcon(context, "My Account", Icons.account_circle, myAccountColor, 
              (){Navigator.of(context).pushNamed('accountpage');}),
              
              makeDashboardIcon(context, "Helpline", Icons.call, helplineColor,
              (){ Navigator.of(context).pushNamed('helpline'); }),            

              makeDashboardIcon(context, "Reminders", Icons.alarm, Colors.amber, (){
                Navigator.of(context).pushNamed('reminders');}),
              makeDashboardIcon(context, "Safety Test", Icons.local_hospital, stColor, (){
                Navigator.of(context).pushNamed('safetytest');
              }),
              makeDashboardIcon(context, "Settings", Icons.settings, Colors.blueGrey, 
              (){ Navigator.of(context).pushNamed('settings'); }),
              
              makeDashboardIcon(context, "About Us", Icons.info, Colors.cyan, (){
                Navigator.of(context).pushNamed('aboutus');
              })
            ],
          )
        ),
      )
    )
    );   
  }
}


