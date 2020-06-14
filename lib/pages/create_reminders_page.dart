import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
import 'package:project/services/firestore_reminders.dart';
import 'package:project/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;


class HealthReminders extends StatefulWidget {
  static const String tag =  "reminders";
  _HealthRemindersState createState() => _HealthRemindersState();
}

class _HealthRemindersState extends State<HealthReminders> {

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // AndroidInitializationSettings androidInitializationSettings;
  // IOSInitializationSettings iosInitializationSettings;
  // InitializationSettings initializationSettings;

  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');
  String _userId;
  Future _getUserId()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId');
  }

  @override
  void initState() {
    super.initState();
    initializing();
    _getUserId();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings("app_icon");
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications(String id, String title, String description) async {
    await notification(id, title, description);
  }

  void _showNotificationsAfterSometime(int id, String title, String description, int afterTime) async {
    await notificationAfterSometime(id, title, description, afterTime);
  }

  void _showNotificationsonDay(int id, String title, String description, Time time, Day day) async {
    await notificationonDay(id, title, description, time, day);
  }

  // void _showNotificationsonTuesdays(String title, String description, Time time) async {
  //   await notificationonTuesdays("2", title, description, time);
  // }
  // void _showNotificationsonWednesdays(String title, String description, Time time) async {
  //   await notificationonWednesdays("2", title, description, time);
  // }
  // void _showNotificationsonThursdays(String title, String description, Time time) async {
  //   await notificationonThursdays("2", title, description, time);
  // }
  // void _showNotificationsonThursdays(String title, String description, Time time) async {
  //   await notificationonThursdays("2", title, description, time);
  // }
  // void _showNotificationsonFridays(String title, String description, Time time) async {
  //   await notificationonFridays("2", title, description, time);
  // }
  // void _showNotificationsonSaturdays(String title, String description, Time time) async {
  //   await notificationonSaturdays("2", title, description, time);
  // }

  Future<void> notification(String id, String title, String description) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            id, title, description,
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, description, notificationDetails);
  }

  Future<void> notificationAfterSometime(int id, String title, String description, int hours) async {
    //List<RepeatInterval> repeat = [];
    //String alarmUri = await platform.invokeMethod('getAlarmUri');
    //final x = UriAndroidNotificationSound(alarmUri);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            id.toString(), title, description,
            playSound: true,
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
        await flutterLocalNotificationsPlugin.periodicallyShow(id, title, description, RepeatInterval.Hourly, notificationDetails);
    //await flutterLocalNotificationsPlugin.schedule(8, title, description,  DateTime.now().add(new Duration(hours: hours)), notificationDetails);
    print("Notification scheduled for $hours");
  }

  Future<void> notificationonDay(int id, String title, String description,Time time, Day day) async {
    //String alarmUri = await platform.invokeMethod('getAlarmUri');
    //final x = UriAndroidNotificationSound(alarmUri);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            id.toString(), title, description,
            playSound: true,
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(2, title, description, day ,time , notificationDetails, payload: 'Default');
    print("Notification scheduled for $time on Monday");
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  addNotifications(List<String> days, String title, String description, Time time){
    int len = days.length;
    for(int i = 0; i < len; i++){
      if (days[i]=="Monday"){
        _showNotificationsonDay(1,title, description, time, Day.Monday);
      }
      else if (days[i]=="Tuesday"){
        _showNotificationsonDay(2,title, description, time, Day.Tuesday);
      }
      else if (days[i]=="Wednesday"){
        _showNotificationsonDay(3,title, description, time, Day.Wednesday);
      }
      else if (days[i]=="Thursday"){
        _showNotificationsonDay(4,title, description, time, Day.Thursday);
      }
      else if (days[i]=="Friday"){
        _showNotificationsonDay(5,title, description, time, Day.Friday);
      }
      else if (days[i]=="MSaturday"){
        _showNotificationsonDay(6,title, description, time, Day.Saturday);
      }
      else if (days[i]=="Sunday"){
        _showNotificationsonDay(7,title, description, time, Day.Sunday);
      }
    }
  }

  addNotificationsDrinkWater(String selectedCities, int id, String title, String description){
    _showNotificationsAfterSometime(8, title, description, 1);
    //   if (selectedCities == "Every 1 hour"){
    //     _showNotificationsAfterSometime(8, title, description, 1);
    //   }
    //   else if (selectedCities=="Every 2 hour"){
    //     _showNotificationsAfterSometime(id, title, description, 2);
    //   }
    //   else if (selectedCities=="Every 3 hour"){
    //     _showNotificationsAfterSometime(id, title, description, 3);
    //   }
    //   else if (selectedCities=="Every 4 hour"){
    //     _showNotificationsAfterSometime(id, title, description, 4);
    //   }
    //   else if (selectedCities=="Every 5 hour"){
    //     _showNotificationsAfterSometime(id, title, description, 5);
    //   }
    //   else if (selectedCities=="Every 6 hour"){
    //     _showNotificationsAfterSometime(id, title, description, 6);
    // }
  }

//   Future<String> _asyncInputDialog(BuildContext context) async {
//   String teamName = '';
//   return showDialog<String>(
//     context: context,
//     barrierDismissible: false, // dialog is dismissible with a tap on the barrier
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Enter custom interval'),
//         content: new Row(
//           children: <Widget>[
//             new Expanded(
//                 child: new TextField(
//               autofocus: true,
//               decoration: new InputDecoration(
//                   labelText: 'Custom Hourly Interval', hintText: '1'),
//               onChanged: (value) {
//                 teamName = value;
//               },
//             ))
//           ],
//         ),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('Ok'),
//             onPressed: () {
//               Navigator.of(context).pop(teamName);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

//   Widget GFCardDrinkWater(BuildContext context, String cardName, String assetImage) {
//     return GFCard(
//     boxFit: BoxFit.cover,
//     elevation: 20,
//     semanticContainer: true,
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     imageOverlay: AssetImage(assetImage),
//     content: Text(cardName, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
//     buttonBar: GFButtonBar(
//       alignment: WrapAlignment.center,
//      children: <Widget>[
//      FlatButton(
//        onPressed: () {
//         addNotificationsDrinkWater("Every 1 hour", 8, cardName, "Stay Healthy");
//         addReminder(8,cardName, "Stay Healthy",null, "Hourly");
//        },
//        child: Text('Set Reminder'),),
//        //color: Colors.transparent,
//      ]
//      ),
//    );
//   }

//     Widget GFCardTakeMedicine(BuildContext context, String cardName, String assetImage) {
//       DateTime _choosenTime = DateTime.now();
//       String title = "Select Days";
//     List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
//     List<String> selectedDays = [];
//     return GFCard(
//     boxFit: BoxFit.cover,
//     elevation: 20,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     semanticContainer: true,
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     imageOverlay: AssetImage(assetImage),
//      content: Text(cardName, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
//      buttonBar: GFButtonBar(
//       alignment: WrapAlignment.center,
//      children: <Widget>[
//       FlatButton(
//         child: Text("Add Alarm" ,style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold)),
//         onPressed:() {
//         DatePicker.showTimePicker(context, onConfirm: (time){
//                     _choosenTime = time;
//                   }, currentTime: DateTime.now());
//         showDialog(
//                     context: context,
//                     builder: (context) {
//                       return _MyDialogTakeMedicine(
//                         title: title,
//                         cities: days,
//                         selectedCities: selectedDays,
//                         onSelectedCitiesListChanged: (cities) {
//                           selectedDays = cities;
//                         }
//                       );
//                     }
//                   );
//                 },),
//        GFButton(
//        onPressed: () {
//         addNotifications(selectedDays, cardName ,"Stay Healthy", Time(_choosenTime.hour, _choosenTime.minute));
//         addReminder(1,cardName, "Stay Healthy", selectedDays, Time(_choosenTime.hour).toString());
//                 },
//       size: 25,
//        highlightElevation: 10,
//        text: 'Set Reminder',
//        color: Colors.blue,
//        elevation: 20,
//        ),
//       ],
//      ),
//    );
//   }

// Widget GFCardQuitSmoking(BuildContext context, String cardName, String assetImage) {
//     DateTime _choosenTime;
//     return GFCard(
//     boxFit: BoxFit.cover,
//     elevation: 20,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     semanticContainer: true,
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     imageOverlay: AssetImage(assetImage),
    
//      content: Text(cardName, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
//      buttonBar: GFButtonBar(
//     alignment: WrapAlignment.center,
//      children: <Widget>[
//          GFButton(
//        onPressed: () {
//         DatePicker.showTimePicker(context, onConfirm: (time){
//                     _choosenTime = time;
//                   }, currentTime: DateTime.now());
//                 },
//       size: 25,
//        highlightElevation: 10,
//        text: 'Select Time',
//        color: Colors.blue,
//        elevation: 20,
//        ),
//        GFButton(
//        onPressed: () {
//         addNotificationsDrinkWater("Every 1 hour", 8, cardName, "Stay Healthy");
//         addReminder(8,cardName, "Stay Healthy",null, "Hourly");
//                 },
//       size: 25,
//        highlightElevation: 10,
//        text: 'Set Reminder',
//        color: Colors.blue,
//        elevation: 20,
//        ),
//       ],
//      ),
//    );
//   }

  Widget drinkWaterAndWashHandsCard(BuildContext context, String cardName, Icon icon, Color color) {
    final List<String> allStates = ['Every 1 hour', 'Every 2 hour','Every 3 hour','Every 4 hour',];
    //const List<int> checklist = [1,2,3,4,5,6];
    String selectedStates = "";
    String custom = "Custom";
    final String title = 'Select Interval';
            return 
              Card(
              color: color,
              //elevation: 5,
              //shadowColor: Colors.blue[100],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:10),
                    ListTile(
                      leading: icon,
                      title: Text(cardName, style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold),),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        // FlatButton(child: const Text('Select Time'),
                        
                        // onPressed: (){showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return _MyDialogDrinkWater(
                        //       title: title,
                        //       cities: allStates,
                        //       selectedCities: selectedStates,
                        //       onSelectedCitiesListChanged: (cities) {
                        //         selectedStates = cities;
                        //       }
                        //     );
                        //   }
                        // );}
                        // ),
                        FlatButton(
                          child: const Text('Set Reminder', style: TextStyle( color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),),
                          onPressed: (){
                            // final snackBar = SnackBar(
                            //   content: Text('Yay! Hourly reminders added!'),
                            // );
                            addNotificationsDrinkWater(selectedStates, 8, cardName, "Stay Healthy");
                            addReminder(_userId,8,cardName, "Stay Healthy",null, "Hourly");
                            Fluttertoast.showToast(msg: 'Yay! Hourly reminders added!');
                            //Scaffold.of(context).showSnackBar(snackBar);
                            },
                        ),
                      ],
                    ),
                  ]
            )
            );
          }

  Widget takeMedicine(BuildContext context, String cardName, Icon icon, Color color){
    DateTime _choosenTime;
    String title = "Select Days";
    List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    List<String> selectedDays = [];
    return Card(
      color: color,
      //elevation: 5,
      shadowColor: Colors.blue[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: icon,
            title: Text(cardName, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)
          ),
          ButtonBar(
            children: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                child: Text('Select Time',style: TextStyle( color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: (){
                  DatePicker.showTimePicker(context, onConfirm: (time){
                    _choosenTime = time;
                  }, currentTime: DateTime.now());

                },),
              FlatButton(
                child: Text('Select Days',style: TextStyle( color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _MyDialogTakeMedicine(
                        title: title,
                        cities: days,
                        selectedCities: selectedDays,
                        onSelectedCitiesListChanged: (cities) {
                          selectedDays = cities;
                        }
                      );
                    }
                  );
                },),
                ],
              ),
              Row(children: <Widget>[
                
              FlatButton(child: Text('Set Reminder',style: TextStyle( color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
              onPressed: (){
                // final snackBar = SnackBar(
                //   content: Text('Yay! Reminder added!'),
                // );
                addReminder(_userId,1,cardName, "Stay Healthy", selectedDays, _choosenTime.hour.toString());
                addNotifications(selectedDays, cardName ,"Stay Healthy", Time(_choosenTime.hour, _choosenTime.minute));
                Fluttertoast.showToast(msg: 'Yay! Reminder added!');
              },)
              ],
              )
            ],
          )
        ],

      ),
    );
}

@override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: GFColors.LIGHT,
      appBar: AppBar(

      ),
      drawer: showDrawer(context),
      body: Container(
        
        padding: EdgeInsets.all(10.0),
        // child: GridView.count(
        //   crossAxisCount: 2,
        //   children: <Widget>[
        //     GFCardDrinkWater(context, "Wash hands", 'assets/images/sanitizer.jpg'),
        //     GFCardQuitSmoking(context, "Quit Smoking", 'assets/images/quit_smoking.jpg'),
        //     GFCardTakeMedicine(context, "Take Medicine", 'assets/images/medicine.jpg'),
        //     GFCardDrinkWater(context, "Drink Water", 'assets/images/water_bottle.jpg'),
        //   ],),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              //SizedBox(height: 40,),
              // GFCardDrinkWater(context, "Drink Water", 'assets/images/drink_water.png'),
              // //GFCardDrinkWater(context, "Wash hands", 'assets/images/sanitizer.jpg'),
              // GFCardTakeMedicine(context, "Take Medicine", 'assets/images/medicine.jpg'),
              // GFCardQuitSmoking(context, "Quit Smoking", 'assets/images/quit_smoking.jpg'),
              drinkWaterAndWashHandsCard(context, 'Drink Water', Icon(Icons.local_drink, size: 35,), Colors.orangeAccent),
              SizedBox(height: 20,),
              drinkWaterAndWashHandsCard(context, 'Wash Hands/ Use Sanitizer', Icon(Icons.local_activity,size: 35,), Colors.grey[600]),
              SizedBox(height: 20,),
              takeMedicine(context, 'Take Medicine', Icon(Icons.local_hospital, size: 35,), Colors.redAccent),
              SizedBox(height: 20,),
              takeMedicine(context, 'Safety Test', Icon(Icons.apps, size: 35,), Colors.blueAccent),
              
            ]
          ),
          // child: GridView.count(crossAxisCount: 2,
          // children: <Widget>[
          //   drinkWaterAndWashHandsCard(context, 'Drink Water'),
          //   drinkWaterAndWashHandsCard(context, 'Wash Hands/ Use Sanitizer'),
          //   takeMedicine(context, 'Take Medicine'),
          // ],),
        ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=> allReminders()));
        },
      label: Icon(Icons.alarm)
      ),
    );
  }

}

// Dialog Builder
class _MyDialogDrinkWater extends StatefulWidget {
  _MyDialogDrinkWater({
    this.title,
    this.cities,
    this.selectedCities,
    this.onSelectedCitiesListChanged,
  });

  final List<String> cities;
  final String selectedCities;
  final ValueChanged<String> onSelectedCitiesListChanged;
  final String title;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialogDrinkWater> {
  String _tempSelectedCities = "";
  String custom = "Custom";

  @override
  void initState() {
    _tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
  String teamName = '';
  return showDialog<String>(
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter custom interval'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Custom Interval', hintText: '1'),
              onChanged: (value) {
                teamName = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          SizedBox(height: 1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
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
                        if (_tempSelectedCities != cityName) {
                          setState(() {
                            _tempSelectedCities = cityName;
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

          // SizedBox(height: 1,),
          // Expanded(child: ListTile(
          //   title: Text(custom),
          //   onTap: ()async {
          //       final String currentTeam = await _asyncInputDialog(context);
          //       print("Current team name is $currentTeam");
          //       if (!_tempSelectedCities.contains("Every" + currentTeam + "hour")){
          //         setState(() {
          //           this.custom = currentTeam;
          //                   _tempSelectedCities.add(currentTeam);
          //                 });
          //       }
          //       widget.onSelectedCitiesListChanged(_tempSelectedCities);
          //     },
          // )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              RaisedButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.red,
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // RaisedButton(
              //   onPressed: () {
              //     setState(() {
              //       _tempSelectedCities = [];
              //     });
              //   },
              //   child: Text(
              //     "Unselect All"
              //   ),
              // ),

            ],
          ),
        ],
      ),
    );
  }
}


// Dialog Builder
class _MyDialogTakeMedicine extends StatefulWidget {
  _MyDialogTakeMedicine({
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
  _MyDialogStateTakeMedicine createState() => _MyDialogStateTakeMedicine();
}

class _MyDialogStateTakeMedicine extends State<_MyDialogTakeMedicine> {
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
                  color: Colors.black
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
                color: Colors.red,
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



class allReminders extends StatefulWidget{
  _allReminders createState() => _allReminders();
}

class _allReminders extends State<allReminders> {
  String _userID;
  _getUserId()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  _userID = pref.getString('userId');
}
  @override
  void initState(){
    _getUserId();
    super.initState();
    //getId();
  }

  // static Future<Stream<QuerySnapshot>> getAllNotifications() async{
  //   final firestoreUser = await FirebaseAuth.instance.currentUser();
  //   final userId = firestoreUser.getIdToken().toString();
  //   final allNotifications = Firestore.instance.collection('users').document(userId).collection('notifications').snapshots();
  //   return allNotifications;
  // }

  // Future<void> getId() async {
  //   final firestoreUser = await FirebaseAuth.instance.currentUser();
  //   final userId = firestoreUser.getIdToken().toString();
  //   _userID = userId;
	// 	print("ID SET!!!");
	// 	return null;

  // }

  Future<void> cancelNotification(int id)async {
    flutterLocalNotificationsPlugin.cancel(id); 
  }

  @override
  Widget build(BuildContext context) {
	//print("REBUILDING");
	//getId();
	//print(_userID);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("My Reminders"),
      ),
      drawer: showDrawer(context),
      body: StreamBuilder(
      stream: Firestore.instance.collection('users').document(_userID).collection('notifications').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
          return ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (_, int index) {
            var message = snapshot.data.documents[index]['title'];
            var from = (message == 'Drink Water' || message == 'Wash Hands/ Use Sanitizer') ? snapshot.data.documents[index][ 'time']: snapshot.data.documents[index][ 'time']+ ":00 " + "hours";
            return new ListTile(
                leading: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: new Image.network(
                        "http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png")),
                title: new Row(
                children: <Widget>[
                    new Expanded(child: new Text(message))
                ]
                ),
                subtitle: new Text(from),
                onLongPress: () {
                showModalBottomSheet<void>(context: context,
                    builder: (BuildContext context) {
                        return Container(
                            child: new Wrap(
                            children: <Widget>[
                                new ListTile(
                                leading: new Icon(Icons.delete),
                                title: new Text('Delete'),
                                onTap: () async {
                                  cancelNotification(snapshot.data.documents[index]['id']);
                                    await Firestore.instance.runTransaction((Transaction myTransaction) async {
                                        await myTransaction.delete(snapshot.data.documents[index].reference);
                                    });
    //     return new ListView(
    //       children: snapshot.data.documents.map((document) {
    //         return new ListTile(
    //           title: new Text(document['title']),
    //           subtitle: new Text(document['time']),
    //           trailing: IconButton(icon: Icon(Icons.delete),
    //           onPressed: () async => {
    //             await Firestore.instance.runTransaction(( myTransaction) async {
    //               await myTransaction.delete(snapshot.data.documents[index].reference);
    //               },

    //             cancelNotification(document['id']),
    //             }),
    //         );
    //       }).toList(),
    // );
    })
    ]
    )
    );});
});
    });
    })
    );
    }}