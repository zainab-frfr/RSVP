import 'package:cloud_firestore/cloud_firestore.dart';

class EventServices {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  void addEvent(String title, description, date, time, host, venue) async {
    if (time.endsWith(':0')) {
      time += '0';
    }
    await _store.collection("Events").doc(title).set({
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'host': host,
      'venue': venue,
      'attendees': [],
    });
  }

  void addAttendee(String eventTitle, String username) async {
    DocumentReference eventDoc = _store.collection("Events").doc(eventTitle);

    await _store.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(eventDoc);

      if (!snapshot.exists) {
        throw Exception("Event does not exist!");
      }

      List<dynamic> attendeesList = snapshot.get('attendees');

      if (!attendeesList.contains(username)) {
        attendeesList.add(username);
        transaction.update(eventDoc, {'attendees': attendeesList});
      }
    });
  }

  Future<bool> isAttending(String title, String username) async {
    DocumentSnapshot eventDoc =
        await _store.collection("Events").doc(title).get();

    if (!eventDoc.exists) {
      throw Exception("Event does not exist!");
    }

    List<dynamic> rsvpList = eventDoc.get('attendees');

    return rsvpList.contains(username);
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
