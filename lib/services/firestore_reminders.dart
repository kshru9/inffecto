import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future addReminder(String _userId,int id, String title, String description, List<String> daysOfWeek, String time) async {
    //final firebaseUser = await FirebaseAuth.instance.currentUser();
    //final userId = firebaseUser.getIdToken().toString();
    //_getUserId();
    await Firestore.instance.collection('users').document(_userId).collection('notifications').document().
    setData({'id': id,'title':title, 'time': time, 'days': daysOfWeek,}, merge: true);
    //final notificationCollection = Firestore.instance.collection('users').document(userId).collection('notifications');
    // final QuerySnapshot result =  await notificationCollection.getDocuments();
    // final List<DocumentSnapshot> documents = result.documents;
    // int id =0;
    // int i = documents.length;
    // List<String> documentIds;
    // for (id=0; id<i; id++){
    //   documentIds.add(documents[id].documentID);
    // }
    // String _id = "0";
    
    // while (id < i){
    //   if (documents[id].documentID == id){
    //     id +=1;
    //   }
    //   else{

    //   }
    // }
    // for (final document in documents){
    //   if (document.documentID == id.toString()){
    //     id+=1;
    //   }
    //   else{
    //     await Firestore.instance.collection('users').document(userId).collection('notifications').document(id.toString()).setData(
    //       {'title':title, 'time': dateTime, 'selectedDays': daysOfWeek}, merge: true);
    //     showHourlyNotifications(id, title, description);
    //     break;
    //   }
    // }
}

