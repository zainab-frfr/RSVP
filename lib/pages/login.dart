import 'package:flutter/material.dart';
import 'package:rsvp/components/button.dart';
import 'package:rsvp/components/textfield.dart';

class MyLoginPage extends StatefulWidget {

  final void Function()? onTap;
  
  const MyLoginPage({super.key, this.onTap});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              hintText: 'email',
              obscureText: false,
              controller: _emailController),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              hintText: 'password',
              obscureText: true,
              controller: _passController),
          const SizedBox(
            height: 60,
          ),
          MyButton(
            text: 'Login',
            onTap: () {},
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account? ',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Register now.',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.black),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
