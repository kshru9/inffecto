import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:project/themedata/themes.dart';
import 'fourthquestion.dart';
import 'secondquestion.dart';
import 'submitpage.dart';
import 'firstquestion.dart';
import 'thirdquestion.dart';

String safetyvar = "null";
var brad_local = BorderRadius.circular(5);

Widget tileMaker(String s){
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(8),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: brad_local,
      color: Color(0xFFB8B8FF),
    ),
    child: Container(
      child: Text(
        s,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w500
        ),
      ),
    ),
  );
}

class Details extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    if(grating<20){
      safetyvar = "very low";
    }
    else if(grating<40){
      safetyvar = "low";
    }
    else if(grating<60){
      safetyvar = "medium";
    }
    else if(grating<80){
      safetyvar = "high";
    }
    else{
      safetyvar = "very high";
    }
    
    return Scaffold(
      appBar: AppBar(title: Text("Details"), backgroundColor: stColor,),
      backgroundColor: GFColors.WHITE,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color(0xFFB8B8FF),
              borderRadius: brad_local,
            ),
            child: Text(
              "Your chances of getting the infection are $grating which means your infection chances are $safetyvar.",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: GFColors.DANGER,
              ),
            ),
          ),


          tileMaker("Test 1[ Symptoms ]: "+score1.toString()+"/30"),
          tileMaker("Test 2[ Travel History ]: "+score2.toString()+"/30",),
          tileMaker("Test 3[ Recent Interactions ]: "+score3.toString()+"/30"),
          tileMaker("Test 4[ Current Location ]: "+score4.toString()+"/10",),
        ],
      ),
    );
  }
}