import 'package:flutter/material.dart';
import 'package:rsvp/components/button.dart';
import 'package:rsvp/components/textfield.dart';
import 'package:rsvp/services/auth_services/auth_services.dart';

class MyRegisterPage extends StatefulWidget {

  final void Function()? onTap;
  
  const MyRegisterPage({super.key, this.onTap});

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final AuthServices _authService = AuthServices();

  bool error = false;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();

  void register() async{
    if (_passController.text == _passConfirmController.text){
      try{
        await _authService.register(_emailController.text, _passController.text, _usernameController.text);
        error = false;
      } catch (e){
        error = true;
      }

    }else{
      error = true;
    }
    setState(() {});
  }

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
              hintText: 'username',
              obscureText: false,
              controller: _usernameController),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              hintText: 'password',
              obscureText: true,
              controller: _passController),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              hintText: 'confirm password',
              obscureText: true,
              controller: _passConfirmController),
          const SizedBox(
            height: 60,
          ),
          MyButton(
            text: 'Register',
            onTap: register,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account? ',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Login.',
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
