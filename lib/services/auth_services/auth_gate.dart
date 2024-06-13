import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rsvp/pages/events.dart';
import 'package:rsvp/services/auth_services/login_or_register.dart'; 

class MyAuthGate extends StatelessWidget {
  const MyAuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return MyEventsPage();
          }else{
            return const LoginOrRegister();
          }
        }
      ),
    );
  }
}