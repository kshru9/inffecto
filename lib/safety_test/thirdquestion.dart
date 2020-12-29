import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:project/style/allstyles.dart';
import 'package:project/themedata/themes.dart';


var brad_local = BorderRadius.circular(5);
List<String> interaction = [];
class MyApp3 extends StatefulWidget {
  static const String tag = "3q";

  MyApp3({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
  
var color1 = Colors.grey[500];
var color2 = Colors.grey[500];
  

class _MyHomePageState extends State<MyApp3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stColor,
        title:Text(
          "Question [ 3/4 ]",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration:BoxDecoration(
                  color: mytheme.accentColor,
                  borderRadius: brad_local,
                  boxShadow: [bs]
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "Do yo have any recent interactions with any of the following?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                setState(() {
                  if(color1 == Colors.blueGrey[500]){
                    color1 = Colors.grey[500];
                    interaction.remove("Any person with previously mentioned symptoms");
                  }
                  else{
                    color1 = Colors.blueGrey[500];
                    interaction.add("Any person with previously mentioned symptoms");
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: brad_local
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15 ),
                  child: 
                  Text(
                    "Any person with previously mentioned symptoms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  if(color2 == Colors.blueGrey[500]){
                    color2 = Colors.grey[500];
                    interaction.remove("Any person with confirmed COVID-19");
                  }
                  else{
                    color2 = Colors.blueGrey[500];
                    interaction.add("Any person with confirmed COVID-19");
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: brad_local
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15 ),
                  child: 
                  Text(
                    "Any person with confirmed COVID-19",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 80,),
            InkWell(
              onTap: (){
                _getScore3();
                Navigator.of(context).pushNamed('4q');
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      spreadRadius: 1
                    )
                  ],
                  borderRadius: brad_local,
                  color: GFColors.SUCCESS,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  child: Text("Submit", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


double score3;

double _getScore3(){
  // Allocation of 30
  double  ret = 0;
  if(color1 == Colors.blueGrey[500]) ret+=10;
  if(color2 == Colors.blueGrey[500]) ret+=20;
  return score3 = ret; 
}