import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  //login

  Future<UserCredential> login(String email, password) async{
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("successful login");
      return user;
    }on FirebaseException catch (e){
      throw Exception(e.code);
    }
  }

  //register

  Future<UserCredential> register(String email, password, username) async{

    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await _store.collection("Users").doc(user.user!.uid).set({
        'uid': user.user!.uid, 
        'email': email,
        'username': username,
      });

      return user;

    }on FirebaseException catch (e){
      throw Exception(e.code);
    }
  }

  //logout 
  Future<void> logout() async{
    return await _auth.signOut();
  }

  User? getUser(){
    return _auth.currentUser;
  }

  Future<String> getUsername()async {
    String username = "";
    DocumentSnapshot userDoc = await _store.collection("Users").doc(_auth.currentUser!.uid).get();
    if(userDoc.exists){
      Map<String,dynamic> userData = userDoc.data() as Map<String,dynamic>;
      username = userData['username'];
    }
    return username;
  } 
}