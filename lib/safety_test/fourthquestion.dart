import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:project/safety_test/submitpage.dart';
import 'package:project/safety_test/thirdquestion.dart';
import 'firstquestion.dart';
import 'package:project/style/allstyles.dart';
import 'package:project/themedata/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'secondquestion.dart' as f2;

var brad_local = BorderRadius.circular(5);

setCity(String cityName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("city", cityName);
  print("all set for you $cityName");

  // Can remove this thing
  prefs = await SharedPreferences.getInstance();
  String checkString = await prefs.getString('city');
}

List<String> currentLocation = [];

class MyApp4 extends StatefulWidget {
  static const String tag = "4q";
  MyApp4({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp4> {
  List<String> _allStates = f2.statesfunction();

  addRatingToFirebase() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userId = user.getIdToken().toString();
    await Firestore.instance.collection('users').document(userId).collection('safetyTest').document().setData({
      'Safety Test rating': rating,
      'currentLocation': currentLocation,
      'interaction': interaction,
      'IndiaTravel': f2.states,
      'foreignTravel': f2.foreignTravel,
      'symptoms': symp
    });
  }

  @override
  Widget build(BuildContext context) {
    if(f2.allStates[0] != "Outside of India")_allStates.insert(0, "Outside of India");
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stColor,
        title: Text(
          "Question [ 4/4 ]",
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
                    "What is your current location ?",
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
                showDialog(
                  context: context,
                  builder: (context) {
                    return MyDialog(
                      title: "States",
                      cities: f2.allStates,
                      selectedCities: currentLocation,
                      onSelectedCitiesListChanged: (cities) {
                        currentLocation = cities;
                      }
                    );
                  }
                );
              
              },
              child: Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: brad_local,
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15 ),
                  child: 
                  Text(
                    "Select States",
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
                if(currentLocation.length != 0){
                  setCity(currentLocation[0]);
                }
                addRatingToFirebase();
                _getScore4();
                Navigator.of(context).pushNamed('submitpage');
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
                  color: GFColors.SUCCESS
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
class MyDialog extends StatefulWidget {
  MyDialog({
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

List<String> _tempSelectedCities = [];

class _MyDialogState extends State<MyDialog> {

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
                  color: mytheme.accentColor
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
                      _tempSelectedCities = [];
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
double score4;
double _getScore4(){
  if(!fileDownloaded){
    score4 = 0;
    return null;
  }

  // Allocation of 10
  double ret = 0;
  if(_tempSelectedCities.length == 0){
    ret = 5;
  }
  else if(_tempSelectedCities[0]!="Outside of India"){
    Map<String, int> statemap = f2.statemap;
    ret = (10*statemap[_tempSelectedCities[0]]/statemap.length);
  }
  else{
    ret = 5;
  }
  

  ret = ret*100;
  ret = ret.toInt().toDouble();
  ret = ret/100;
  return score4 = ret;
}