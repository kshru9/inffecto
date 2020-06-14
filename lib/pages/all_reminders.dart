// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:project/widgets/drawer.dart';
// import 'package:project/pages/create_reminders_page.dart';
// class allReminders extends StatefulWidget{
//   _allReminders createState() => _allReminders();
// }

// class _allReminders extends State<allReminders> {
//   String _userID;
//   @override
//   void initState(){
//     super.initState();
//     getId();
//   }

//   // static Future<Stream<QuerySnapshot>> getAllNotifications() async{
//   //   final firestoreUser = await FirebaseAuth.instance.currentUser();
//   //   final userId = firestoreUser.getIdToken().toString();
//   //   final allNotifications = Firestore.instance.collection('users').document(userId).collection('notifications').snapshots();
//   //   return allNotifications;
//   // }

//   Future<void> getId() async {
//     final firestoreUser = await FirebaseAuth.instance.currentUser();
//     final userId = firestoreUser.getIdToken().toString();
//     _userID = userId;
// 		print("ID SET!!!");
// 		return null;
		
//   }
//   @override
//   Widget build(BuildContext context) {
// 	print("REBUILDING");
// 	getId();
// 	print(_userID);
	
//     return Scaffold(
//       appBar: AppBar(

//       ),
//       drawer: showDrawer(context),
//       // body: FutureBuilder(
//       //   future: getAllNotifications(),
//       //   initialData: [],
//       //   builder: (context,snapshot){
//       //     final notifications = snapshot.data;
//       //     return Expanded(
//       //       child: ListView.builder(
//       //         itemCount: notifications.length,
//       //         itemBuilder: (context,index){
//       //           final notification = notifications[index];
//       //           return ListTile(
//       //             title: notification.data['title'],
//       //           );
//       //         })
//       //     );
//       //   },),
//       body: StreamBuilder(
//       stream: Firestore.instance.collection('users').document(_userID).collection('notifications').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) return new Text('Loading...');
//         else{
//         return new ListView(
//           children: snapshot.data.documents.map((document) {
//             return new ListTile(
//               title: new Text(document['title']),
//               subtitle: new Text(document['time']),
//               trailing: IconButton(icon: Icon(Icons.delete), onPressed: ()=>cancelNotification()),
//             );
//           }).toList(),
//     );
//     }
//   }
//       )
//   );
// }
// }