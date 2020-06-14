import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';


class FaqPage extends StatefulWidget {
  static const String tag = "faqpage";
  FaqPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


Widget question(String q, String ans){
  return ExpandablePanel(
    hasIcon: false,
    header: Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), 
          topRight: Radius.circular(8),
        ),
        color: Color(0xFFB8B8FF)
      ),
      child: Text(
        "Q. $q",
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16, color: Color(0xFF000000), fontWeight: FontWeight.w600),
      ),
    ),
    expanded: Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xFFDFF2D8),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
      ),
      child: Text(ans,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.start,
      ),
    ),
  );
}

String q1 = "What is Infecto Rating ?";
String ans1 = "Infecto Rating determines what are your chances of getting the COVID-19 infection in comparision to other people. ";
String q2 = "Does this represent my chances of death ?";
String ans2 = "No, it does not represent your percentage of death.\nAs mentioned above it is just a relative rating of your survival with respect to others.\nScientifically, the chances of any one getting infected are very low because very less people in any country are getting infected due to COVID-19.\nIf you have a rating of 30 and your friend has a rating of 60, it means that you are less likely getting infected by the virus.";
String q3 = "How accurate is infecto rating ?";
String ans3 = "Infecto Rating uses scientific methods to calculate a measure of your chances of getting the virus.\nHowever, it doesn't give any exact measure of any person getting infected or not infected in the near future.\nAlthought it is impossible to tell who will be the next person to get infected, by following certain measure";
String q4 = "Who are the developers of this app ?";
String ans4 = "This is an app made for educational purposes by students of IIT Gandhinagar";
String q5 = "What type of data do you collect ?";
String ans5 = "We collect the data that users give during the infecto test.\nHowever we don't sell or distribute that data to anyone.";



class _MyHomePageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF7F4),
      appBar: AppBar(
        title: Text("FAQ Page"),
        backgroundColor: Color(0xFF3B429F),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: 
          ListView(  
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            children: <Widget>[
              SizedBox(height: 12,),
              question(q1, ans1),
              SizedBox(height: 24,),
              question(q2, ans2),
              SizedBox(height: 24,),
              question(q3, ans3),
              SizedBox(height: 24,),
              question(q4, ans4),
              SizedBox(height: 24,),
              question(q5, ans5),
              SizedBox(height: 12,),
            ],
          ),
        ),
      ), 
    );
  }
}
