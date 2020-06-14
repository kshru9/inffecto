import 'package:flutter/material.dart';

var brad = BorderRadius.circular(10);

const elevation_of_all = 10;

var bs = BoxShadow(
  color: Colors.grey,
  blurRadius: 5,
  spreadRadius: 1
);


Widget makeDashboardIcon(context, String title, IconData icon, Color colorObj, Function onpress){
  return Container(
    height: 10,
    width: 10,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: MaterialButton(
        onPressed: ()=> onpress(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: colorObj,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, size: 60, color: Colors.white,),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 15),),
          ],
        ),
      ), 
    ),
  ); 
}