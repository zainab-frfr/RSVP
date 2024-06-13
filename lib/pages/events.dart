import 'package:flutter/material.dart';
import 'package:rsvp/components/drawer.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 2.0,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
