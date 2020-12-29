import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';
import 'package:project/style/allstyles.dart';
import 'dart:io';
import 'package:project/themedata/themes.dart';


const api = 'https://api.covid19india.org/csv/latest/state_wise.csv';
// API for state wise data from https://www.covid19india.org/

List<String> symp = [];
class MyApp1 extends StatefulWidget {
  static const String tag = "safetytest";
  MyApp1({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


var brad_local = BorderRadius.circular(5);

var colorSelection = Colors.blueGrey[500];

var color1 = Colors.grey[500];
var color2 = Colors.grey[500];
var color3 = Colors.grey[500];
var color4 = Colors.grey[500];
var color5 = Colors.grey[500];

bool fileDownloaded = false;

class _MyHomePageState extends State<MyApp1> {
  String _dir;
  String _datafilename = "state_wise.csv";

  Future<void> networkHandler()async{
    if(fileDownloaded) {
      print("file downloaded returning...");
      return;
    }
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        print("calling download_assets function");
        await _downloadAssets(_datafilename, _dir); // Very Important, Don't Remove
      }
    } on SocketException catch (_) {
      fileDownloaded = false;
      print('not connected');
    }
  }
@override
  void initState() {
    networkHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FFF6),
      appBar: AppBar(
        backgroundColor: stColor,
        title:Text(
          "Question [ 1/4 ]",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      //backgroundColor: Color(0xFFeaf4fc),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: 
              Container(
                decoration:BoxDecoration(
                  boxShadow: [bs],
                  color: mytheme.accentColor,
                  borderRadius: brad_local,
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "Do you have any of the symptoms?",
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
                  if(color1 == colorSelection){
                    color1 = Colors.grey[500];
                    symp.remove("Cough");
                  }
                  else{
                    color1 = colorSelection;
                    symp.add("Cough");
                  }
                });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: brad_local
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 70, right: 70, top: 15, bottom: 15 ),
                  child: 
                  Center(child:Text(
                    "Cough",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  if(color2 == colorSelection){
                    color2 = Colors.grey[500];
                    symp.remove("Shortness or Difficulty in breathing");
                  }
                  else{
                    color2 = colorSelection;
                    symp.add("Shortness or Difficulty in breathing");
                  }
                });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: brad_local
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15 ),
                  child: 
                  Center(child: Text(
                    "Shortness or Difficulty in breathing",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  if(color3 == colorSelection){
                    color3 = Colors.grey[500];
                    symp.remove("Sore Throat");
                  }
                  else{
                    color3 = colorSelection;
                    symp.remove("Sore Throat");
                  }
                });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                  color: color3,
                  borderRadius: brad_local
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 70, right: 70, top: 15, bottom: 15 ),
                  child: 
                  Center(child: Text(
                    "Sore Throat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  if(color4 == colorSelection){
                    color4 = Colors.grey[500];
                    symp.remove("Tiredness");
                  }
                  else{
                    color4 = colorSelection;
                    symp.add("Tiredness");
                  }
                });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                  color: color4,
                  borderRadius: brad_local
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 70, right: 70, top: 15, bottom: 15 ),
                  child: 
                  Center(child: Text(
                    "Tiredness",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  if(color5 == colorSelection){
                    color5 = Colors.grey[500];
                    symp.remove("Chest Pain");
                  }
                  else{
                    color5 = colorSelection;
                    symp.remove("Chest Pain");
                  }
                });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                  color: color5,
                  borderRadius: brad_local
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 70, right: 70, top: 15, bottom: 15 ),
                  child: 
                  Center(child: Text(
                    "Chest Pain",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                  ),
                ),
              ),
            ),

            

            SizedBox(height: 80,),
            InkWell(
              onTap: () {
                if(!fileDownloaded)networkHandler();
                _getScore1();

                Navigator.of(context).pushNamed('2q');
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

Future<File> _downloadFile(String url, String filename, String dir) async {
  var req = await Client().get(Uri.parse(url));
  var file = File('$dir/$filename');
  return file.writeAsBytes(req.bodyBytes);
}

Future<void> _downloadAssets(String name, String _dir) async {
  print("_downloadAssets called...");
  if (_dir == null) {
    _dir = (await getApplicationDocumentsDirectory()).path;
  }

  print("File Downloading Started");
  await _downloadFile('$api','$name',_dir);
  print("CONGRATULATIONS File downloading finished");

  fileDownloaded = true;
  return true;
}

double score1;

double _getScore1(){
  // Allocation of 30

  double ret = 0;
  if(color1 == mytheme.accentColor) ret++;
  if(color2 == mytheme.accentColor) ret++;
  if(color3 == mytheme.accentColor) ret++;
  if(color4 == mytheme.accentColor) ret++;
  if(color5 == mytheme.accentColor) ret++;

  score1 = ret*6;
  return 1;
}