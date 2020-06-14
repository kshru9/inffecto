import 'package:getflutter/getflutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'firstquestion.dart';
import 'package:project/style/allstyles.dart';
import 'package:project/themedata/themes.dart';
import 'package:tuple/tuple.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
const api = 'https://api.covid19india.org/csv/latest/state_wise.csv';

List<String> allStates = ["Data Loading Please Wait"];

var brad_local = BorderRadius.circular(5);
String foreignTravel = "No";
List<String> states = [];

class MyApp2 extends StatefulWidget {
  static const String tag = "2q";
  MyApp2();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String fts = "[No]";
var ft = Colors.grey[500];
List<Tuple2<String, int>> rankedStates = [];
double score2 = -1;

var colorSelection = Colors.blueGrey[500];


List mainfields = [];
bool _dataLoaded = false;
class _MyHomePageState extends State<MyApp2> {
  String _dir;
  String _datafilename = "state_wise.csv";
  
  
  


  @override
  Future<void> initState()  {
    super.initState();
    return null;
  }


  Future<void> _loadData() async {
    if(_dataLoaded) return; // EH
    if(!fileDownloaded) {
      fileDownloaded = false;   // EH
      _dataLoaded = false;
      ranked = false;
      return;
    }

    _dir = (await getApplicationDocumentsDirectory()).path;
    final input = File("$_dir/$_datafilename").openRead();

    if(input == null){
      fileDownloaded = false; // EH
      _dataLoaded = false;    // EH
      return;                 // EH
    }

    final fields = await input.transform(utf8.decoder).transform(CsvToListConverter()).toList();
  
    mainfields = fields; // main assignment of the files for score2 calculation

    print("MAIN JOB SUCCESSFUL, DATA FILE TRANSFERRED OUTSIDE");

    allStates = [];
    rankedStates = List<Tuple2<String, int>>();    
    
    for(var i = 2; i<mainfields.length; i++){
      if(mainfields[i][0] != "State Unassigned"){
        allStates.add(mainfields[i][0]);
        rankedStates.add(Tuple2<String, int>(mainfields[i][0], mainfields[i][4]));
      }
    }
    
    allStates.sort();
    
    print("ALL STATES NAMES COLLECTED!!!");
    print(allStates);


    _dataLoaded = true;
  }
  
  


  
  @override
  Widget build(BuildContext context) {    
    _loadData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stColor,
        title: Text(
          "Question [ 2/4 ]",
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
              child: 
              Container(
                decoration:BoxDecoration(
                  color: mytheme.accentColor,
                  borderRadius: brad_local,
                  boxShadow: [bs]
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "Do you have any travel history of foreign country or another state in recent 15 days?",
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
            RawMaterialButton(
              shape: RoundedRectangleBorder(borderRadius: brad_local),
              fillColor: Colors.grey[500],
              
              child: Container(
                margin: EdgeInsets.only(left: 52, right: 52, top:20, bottom: 20),
                child: Text(
                  "Select States",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () { 
                showDialog(
                  context: context,
                  builder: (context) {
                    return _MyDialog(
                      title: "States",
                      cities: allStates,
                      selectedCities: states,
                      onSelectedCitiesListChanged: (cities) {
                        states = cities;
                      }
                    );
                  }
                );
              }
            ),

            
            RawMaterialButton(
              shape: RoundedRectangleBorder(borderRadius: brad_local),
              fillColor: ft,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Foreign Travel Status",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    Text(
                      fts,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),



                  ],
                ),
              ),
              onPressed: () {
                setState(() {
                  if(ft == colorSelection){
                    ft = Colors.grey[500];
                    fts = "[No]";
                    foreignTravel = "[No]";
                  } 
                  else {
                    ft = colorSelection;
                    fts = "[Yes]";
                    foreignTravel = "[Yes]";
                  }

                });
              }
            ),

            SizedBox(height: 80,),

            InkWell(
              onTap: (){
                _getScore2();
                Navigator.of(context).pushNamed('3q');
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


// Dialog Builder
class _MyDialog extends StatefulWidget {
  _MyDialog({
    this.title,
    this.cities,
    this.selectedCities,
    this.onSelectedCitiesListChanged,
  });

  final List<String> cities;
  final List<String> selectedCities;
  final ValueChanged<List<String>> onSelectedCitiesListChanged;
  final String title;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<String> _tempSelectedCities = [];

  @override
  void initState() {
    _tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: mytheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: widget.cities.length,
              itemBuilder: (BuildContext context, int index) {
                final cityName = widget.cities[index];
                return Container(
                  child: CheckboxListTile(
                    title: Text(
                      cityName,
                      style: TextStyle(
                        fontSize: 17,
                      )
                    ),
                    value: _tempSelectedCities.contains(cityName),
                    onChanged: (bool value) {
                      if (value) {
                        if (!_tempSelectedCities.contains(cityName)) {
                          setState(() {
                            _tempSelectedCities.add(cityName);
                          });
                        }
                      } else {
                        if (_tempSelectedCities.contains(cityName)) {
                          setState(() {
                            _tempSelectedCities.removeWhere(
                              (String city) => city == cityName);
                          });
                        }
                      }
                      widget.onSelectedCitiesListChanged(_tempSelectedCities);
                    }
                  ),
                );
              }
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                color: mytheme.accentColor,
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              RaisedButton(
                onPressed: () {
                  setState(() {
                    _tempSelectedCities = [];
                  });                
                },
                child: Text(
                  "Unselect All"
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

// helper function for fourthquestion.dart
List<String> statesfunction(){
  return allStates;
}


Map<String, int> statemap = {};


bool ranked = false;
void _ranking(){
  rankedStates.sort((a, b) => a.item2.compareTo(b.item2));
  
  //
  for(var someindex = 0; someindex<rankedStates.length; someindex = someindex+1){
    statemap[rankedStates[someindex].item1] = someindex+1;
  }
  //

  print("Ranking of the States Done !!!");
  print(statemap);
}

Future<double> _getScore2()async{
  if(!fileDownloaded || !_dataLoaded){
    score2 = 0;
    print("FILE not avail in Q2.");
    return null;
  }

  if(!ranked){
    _ranking();
    ranked = true;
  }

  if(rankedStates.length>40 || statemap.length>40){
    print("ERROR!!! ERROR!!! ERROR!!! ");
    print("debug something, eroor in state calculation");
  }

  // Allocation of 30
  double ret = 0;
  double statevar = 0;
  if(fts == "[Yes]") ret+=15;
  
  if(states.length!=0){
    for(String i in states){
      if(statevar<statemap[i]){
        statevar = statemap[i].toDouble();
      }
    }
    print("statevar is $statevar");
    statevar = (statevar*15)/statemap.length;
    ret+=statevar;
    if(ret<10 && states.length>=5) ret+=5;
  }


  ret = 100*ret;
  ret = ret.toInt().toDouble();
  ret = ret/100;
  score2 = ret;
  return 1;
}












// import 'package:getflutter/getflutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:project/safety_test/firstquestion.dart';
// import 'package:project/safety_test/thirdquestion.dart';
// import 'package:project/style/allstyles.dart';
// import 'package:project/themedata/themes.dart';
// import 'package:tuple/tuple.dart';
// import 'package:csv/csv.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// const api = 'https://api.covid19india.org/csv/latest/state_wise.csv';

// List<String> allStates = ["Data Loading Please Wait"];

// var brad_local = BorderRadius.circular(5);
// String foreignTravel;
// List<String> states;

// class MyApp2 extends StatefulWidget {
//   static const String tag = "2q";
  
//   MyApp2({Key key, this.documentId}) : super(key: key);
//   String documentId;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// List<String>selectedStates = [];
// String fts = "[No]";
// var ft = Colors.grey[500];
// List<Tuple2<String, int>> rankedStates = [];
// double score2 = -1;

// bool _dataLoaded = false;
// class _MyHomePageState extends State<MyApp2> {
//   String _dir;
//   String _datafilename = "state_wise.csv";
//   List mainfields = [];

//   updateRatingToFirebase(String foreignTravel, List<String> states) async {
//     final firebaseUser = await FirebaseAuth.instance.currentUser();
//     final userId = firebaseUser.getIdToken().toString();
//     Firestore.instance.collection('users').document(userId).collection('safetyTest').document(widget.documentId).updateData({
//       "Foreign travel": foreignTravel,
//       "India travel": states,
//     });
//   }

//   @override
//   Future<void> initState()  {
//     super.initState();
//     return null;
//   }


//   Future<void> _loadData() async {
//     if(_dataLoaded) return; // EH
//     if(!fileDownloaded) {
//       fileDownloaded = false;   // EH
//       _dataLoaded = false;
//       ranked = false;
//       return;
//     }

//     _dir = (await getApplicationDocumentsDirectory()).path;
//     final input = File("$_dir/$_datafilename").openRead();

//     if(input == null){
//       fileDownloaded = false; // EH
//       _dataLoaded = false;    // EH
//       return;                 // EH
//     }

//     final fields = await input.transform(utf8.decoder).transform(CsvToListConverter()).toList();
  
//     mainfields = fields; // main assignment of the files for score2 calculation

//     print("MAIN JOB SUCCESSFUL, DATA FILE TRANSFERRED OUTSIDE");

//     allStates = [];
//     rankedStates = List<Tuple2<String, int>>();    
    
//     for(var i = 2; i<mainfields.length; i++){
//       if(mainfields[i][0] != "State Unassigned"){
//         allStates.add(mainfields[i][0]);
//         rankedStates.add(Tuple2<String, int>(mainfields[i][0], mainfields[i][4]));
//       }
//     }
    
//     allStates.sort();
    
//     print("ALL STATES NAMES COLLECTED!!!");
//     print(allStates);


//     _dataLoaded = true;
//   }
  
  


  
//   @override
//   Widget build(BuildContext context) {    
//     _loadData();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: stColor,
//         title: Text(
//           "Question [ 2/4 ]",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(left: 20, right: 20),
//               child: 
//               Container(
//                 decoration:BoxDecoration(
//                   color: mytheme.accentColor,
//                   borderRadius: brad_local,
//                   boxShadow: [bs]
//                 ),
//                 child: Container(
//                   margin: EdgeInsets.all(20),
//                   child: Text(
//                     "Do you have any travel history of foreign country or another state in recent 15 days?",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             Divider(
//               color: Colors.grey,
//               height: 20,
//               thickness: 1,
//               indent: 20,
//               endIndent: 20,
//             ),
  
//             SizedBox(height: 20,),
//             RawMaterialButton(
//               shape: RoundedRectangleBorder(borderRadius: brad_local),
//               fillColor: Colors.grey[500],
              
//               child: Container(
//                 margin: EdgeInsets.only(left: 52, right: 52, top:20, bottom: 20),
//                 child: Text(
//                   "Select States",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               onPressed: () { 
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return _MyDialog(
//                       title: "States",
//                       cities: allStates,
//                       selectedCities: selectedStates,
//                       onSelectedCitiesListChanged: (cities) {
//                         selectedStates = cities;
//                       }
//                     );
//                   }
//                 );
//               }
//             ),

            
//             RawMaterialButton(
//               shape: RoundedRectangleBorder(borderRadius: brad_local),
//               fillColor: ft,
//               child: Container(
//                 margin: EdgeInsets.all(20),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       "Foreign Travel Status",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
                    
//                     Text(
//                       fts,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),



//                   ],
//                 ),
//               ),
//               onPressed: () {
//                 setState(() {
//                   if(ft == mytheme.accentColor){
//                     ft = Colors.grey[500];
//                     fts = "[No]";
//                   } 
//                   else {
//                     ft = mytheme.accentColor;
//                     fts = "[Yes]";
//                   }

//                 });
//               }
//             ),

//             SizedBox(height: 80,),

//             InkWell(
//               onTap: (){
//                 updateRatingToFirebase(fts=="No"? "No": "Yes", selectedStates);
//                 _getScore2();
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp3(documentId: widget.documentId,)));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 5,
//                       spreadRadius: 1
//                     )
//                   ],
//                   borderRadius: brad_local,
//                   color: GFColors.SUCCESS,
//                 ),
//                 child: Container(
//                   margin: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
//                   child: Text("Submit", 
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }


// // Dialog Builder
// class _MyDialog extends StatefulWidget {
//   _MyDialog({
//     this.title,
//     this.cities,
//     this.selectedCities,
//     this.onSelectedCitiesListChanged,
//   });

//   final List<String> cities;
//   final List<String> selectedCities;
//   final ValueChanged<List<String>> onSelectedCitiesListChanged;
//   final String title;

//   @override
//   _MyDialogState createState() => _MyDialogState();
// }

// class _MyDialogState extends State<_MyDialog> {
//   List<String> _tempSelectedCities = [];
//   @override
//   void initState() {
//     _tempSelectedCities = widget.selectedCities;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Column(
//         children: <Widget>[
//           SizedBox(height: 10,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text(
//                 widget.title,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: mytheme.primaryColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),

//           SizedBox(height: 10,),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.cities.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final cityName = widget.cities[index];
//                 return Container(
//                   child: CheckboxListTile(
//                     title: Text(
//                       cityName,
//                       style: TextStyle(
//                         fontSize: 17,
//                       )
//                     ),
//                     value: _tempSelectedCities.contains(cityName),
//                     onChanged: (bool value) {
//                       if (value) {
//                         if (!_tempSelectedCities.contains(cityName)) {
//                           setState(() {
//                             _tempSelectedCities.add(cityName);
//                           });
//                         }
//                       } else {
//                         if (_tempSelectedCities.contains(cityName)) {
//                           setState(() {
//                             _tempSelectedCities.removeWhere(
//                               (String city) => city == cityName);
//                           });
//                         }
//                       }
//                       widget.onSelectedCitiesListChanged(_tempSelectedCities);
//                     }
//                   ),
//                 );
//               }
//             ),
//           ),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
              
//               RaisedButton(
//                 onPressed: (){ 
//                   Navigator.pop(context);},
//                 color: mytheme.accentColor,
//                 child: Text(
//                   'Done',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),

//               RaisedButton(
//                 onPressed: () {
//                   setState(() {
//                     _tempSelectedCities = [];
//                   });                
//                 },
//                 child: Text(
//                   "Unselect All"
//                 ),
//               ),

//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // helper function for fourthquestion.dart
// List<String> statesfunction(){
//   return allStates;
// }


// Map<String, int> statemap = {};


// bool ranked = false;
// void _ranking(){
//   rankedStates.sort((a, b) => a.item2.compareTo(b.item2));
  
//   //
//   for(var someindex = 0; someindex<rankedStates.length; someindex = someindex+1){
//     statemap[rankedStates[someindex].item1] = someindex+1;
//   }
//   //

//   print("Ranking of the States Done !!!");
//   print(statemap);
// }

// Future<double> _getScore2()async{
//   if(!fileDownloaded || !_dataLoaded){
//     score2 = 0;
//     print("FILE not avail in Q2.");
//     return null;
//   }

//   if(!ranked){
//     _ranking();
//     ranked = true;
//   }

//   if(rankedStates.length>40 || statemap.length>40){
//     print("ERROR!!! ERROR!!! ERROR!!! ");
//     print("debug something, eroor in state calculation");
//   }

//   // Allocation of 30
//   double ret = 0;
//   double statevar = 0;
//   if(fts == "[Yes]") ret+=15;
  
//   if(selectedStates.length!=0){
//     for(String i in selectedStates){
//       if(statevar<statemap[i]){
//         statevar = statemap[i].toDouble();
//       }
//     }
//     print("statevar is $statevar");
//     statevar = (statevar*15)/statemap.length;
//     ret+=statevar;
//     if(ret<10 && selectedStates.length>=5) ret+=5;
//   }


//   ret = 100*ret;
//   ret = ret.toInt().toDouble();
//   ret = ret/100;
//   score2 = ret;
//   return 1;
// }