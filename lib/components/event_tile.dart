import 'package:flutter/material.dart';

class MyEventTile extends StatelessWidget {
  final String eventName;
  final void Function()? onTap;
  const MyEventTile({super.key, required this.eventName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container( 
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary, 
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(left: 25, right: 25,top: 10, bottom: 10),
        padding: const EdgeInsets.all(15),
        child: Text(eventName),
        
      ),
    );
  }
}