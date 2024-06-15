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

  //get event stream
  Stream<List<Map<String, dynamic>>> getEventStream() {
    return _store.collection("Events").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final event = doc.data();
        return event;
      }).toList();
    });
  }
}