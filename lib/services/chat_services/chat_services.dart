import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rsvp/models/message.dart';
import 'package:rsvp/services/auth_services/auth_services.dart';

class ChatServices {
  //instance firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String eventTitle, message) async {
    
    final String senderUsername = await AuthServices().getUsername();

    final Timestamp timestamp = Timestamp.now();

    //new message
    Message newMessage = Message(senderUsername, eventTitle, timestamp, message);

    //add to collection in firestore
    await _firestore.collection("Chat Room").doc(eventTitle).collection("messages").add(newMessage.toMap());

  }

  //get messages
  Stream<QuerySnapshot> getMessages(String eventTitle){
    return _firestore.collection("Chat Room").doc(eventTitle).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }

}