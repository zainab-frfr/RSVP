import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsvp/components/drawer.dart';
import 'package:rsvp/themes/themeprovider.dart';

class MySettingsPage extends StatelessWidget {
  const MySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), 
          color: Theme.of(context).colorScheme.primary
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark Mode"),

            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode(), 
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}