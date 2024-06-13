import 'package:cloud_firestore/cloud_firestore.dart';

class EventServices{
  final FirebaseFirestore _store = FirebaseFirestore.instance;


  void addEvent(String title, description, date, time, host, venue) async{
    await _store.collection("Events").doc(title).set({
      'title' : title, 
      'description': description,
      'date': date, 
      'time': time,
      'host': host,
      'venue': venue,
    });
  }

  
}