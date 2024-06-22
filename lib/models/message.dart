import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderUsername;
  final String eventTitle;

  final String message;

  final Timestamp timestamp;

  Message(this.senderUsername, this.eventTitle, this.timestamp, this.message);

  Map<String, dynamic> toMap(){
    return{
      'sender': senderUsername,
      'event': eventTitle, 
      'message': message, 
      'timestamp': timestamp,
    };
  }
}