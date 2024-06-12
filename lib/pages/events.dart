import 'package:flutter/material.dart';
import 'package:rsvp/services/auth_services/auth_services.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthServices _auth =  AuthServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()async{
              await _auth.logout();
            }, 
            icon: const Icon(Icons.logout),
            )
        ],
      ),
    );
  }
}