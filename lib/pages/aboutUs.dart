import 'package:flutter/material.dart';


class AboutUs extends StatefulWidget {
  static const String tag = "aboutus";

  AboutUs({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AboutUs> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us"),),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "This app is developed and made by students of IIT Gandhinagar under the Student Summer Technical Project 2020."
            ),
          ),

          Column(
            children: <Widget>[
              SizedBox(height: 100),
              Card(child: Container(padding: EdgeInsets.all(10), child: Text("Anupam Kumar"),), color: Colors.lightBlueAccent,),
              Text("anupam.kumar@iitgn.ac.in"),
              SizedBox(height: 50),
              Card(child: Container(padding: EdgeInsets.all(10), child: Text("Shruti Katpara"),), color: Colors.lightBlueAccent,),
              Text("shruti.katpara@iitgn.ac.in"),
            ],
          )






        ],
      ),
    );
  }
}