import "package:flutter/material.dart";

class MyChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String sender;

  const MyChatBubble({super.key, required this.message, required this.isCurrentUser, required this.sender});

  

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sender, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          Text(message, style: const TextStyle(fontSize: 12),)
        ],
        ),
    );
  }
}