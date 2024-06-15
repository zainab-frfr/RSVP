import 'package:flutter/material.dart';
import 'package:rsvp/services/auth_services/auth_services.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    AuthServices auth = AuthServices();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 5.0,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding:  const EdgeInsets.only(left: 25, top: 80),
                child: ListTile(
                  title:const Text('Events'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, '/events');
                  },
                ),
              ),
              Padding(
                padding:  const EdgeInsets.only(left: 25),
                child: ListTile(
                  title:const Text('My Events'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, '/myEvents');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text('Settings'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, '/settings');
                  },
                ),
              ),
            ],
          ), 
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: const Text('Logout'),
              onTap: (){
                auth.logout();
                Navigator.popAndPushNamed(context, '/authGate');
              },
            ),
          ),
        ],
      ),
    );
  }
}