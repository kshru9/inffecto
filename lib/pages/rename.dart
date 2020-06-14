import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:project/style/allstyles.dart';
import 'package:shared_preferences/shared_preferences.dart';



setName(String name)async{
  SharedPreferences prefs =await SharedPreferences.getInstance();
  prefs.setString('name', name);
}

class Rename extends StatelessWidget{
  static const String tag =  "rename";
  @override
  Widget build(BuildContext context) {
    String name;
    return Scaffold(
      backgroundColor: GFColors.FOCUS,
      body: Center(
        child: Container(
          width: 500,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: brad
          ),
          child: AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                onChanged: (value){
                  name = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Name" 
                ),
              ),
              GFButton(
                color: GFColors.SUCCESS,
                text: "Submit",
                onPressed: (){
                  setName(name);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ),
        ),
      ),  
    );
  }
}