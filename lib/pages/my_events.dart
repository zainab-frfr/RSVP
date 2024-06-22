import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsvp/components/drawer.dart';
import 'package:rsvp/components/event_tile.dart';
import 'package:rsvp/pages/event_details.dart';
import 'package:rsvp/services/auth_services/auth_services.dart';
import 'package:rsvp/services/events_services/event_services.dart';

class PersonalEventsPage extends StatelessWidget {
  PersonalEventsPage({super.key});

  final EventServices _eventService = EventServices();
  final AuthServices _auth = AuthServices();
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Events"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body:_eventsList(context) ,
      drawer: const MyDrawer(),
    );
  }

  Widget _eventsList(BuildContext context){
    return StreamBuilder(
      stream: _eventService.getEventStream(), 
      builder: (context, snapshot){
        //errors
          if (snapshot.hasError) {
            return const Text('Error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          //eventsList
          List<Map<String, dynamic>> eventsData = List<Map<String, dynamic>>.from(snapshot.data as Iterable);

          return ListView(
            children: eventsData.map<Widget>((eventData) {
            return FutureBuilder<Widget>(
              future: _buildEventsListItem(eventData, context),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.hasError) {
                  return const Text('Error loading item');
                } else {
                  return futureSnapshot.data ?? Container();
                }
              },
            );
          }).toList(),
        );
      }
    );
  }

  Future<Widget> _buildEventsListItem(Map<String, dynamic> eventData, BuildContext context) async{
    String username = "";
    DocumentSnapshot userDoc = await _store.collection("Users").doc(_auth.getUser()!.uid).get();
    if(userDoc.exists){
      Map<String,dynamic> userData = userDoc.data() as Map<String,dynamic>;
      username = userData['username'];
    }
    if(eventData['host'] == username){
      return MyEventTile(
        eventName: eventData['title'], 
        onTap: () async{
          String username =  await _auth.getUsername();
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => EventDetails(title: eventData['title'], description: eventData['description'], host: eventData['host'], time: eventData['time'], date: eventData['date'], venue: eventData['venue'], username: username,),));
      },);
    }else{
      return Container();
    }

  }
}