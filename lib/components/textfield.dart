import 'package:flutter/material.dart'; 

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  
  const MyTextField({super.key, required this.hintText, required this.obscureText, required this.controller, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color:   Color.fromARGB(255, 177, 176, 176),
          ), 
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:  Colors.grey),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:  Colors.black),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30)),
          ),
      
        ),
      ),
    );
  }
}