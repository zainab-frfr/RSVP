import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  final String title;
  final String description;
  final String host;
  final String time;
  final String date;
  final String venue;

  const EventDetails(
      {super.key,
      required this.title,
      required this.description,
      required this.host,
      required this.time,
      required this.date,
      required this.venue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            tile(context, 'Description', description),
            tile(context, 'Venue', venue),
            tile(context, 'Organizer', host),
            tile(context, 'Date', date),
            tile(context, 'Time', time),

          ],
        ),
      ),
    );
  }

  Container tile(BuildContext context, String heading, String text) {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              heading,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,),
            ),
            Column(
              children: [
                Text(text)
              ],
            )
          ],
        ));
  }
}


  // Container heading(BuildContext context, String text) {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     margin: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).colorScheme.tertiary,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Text(
  //       text,
  //       style: const TextStyle(
  //           fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
  //     ),
  //   );
  // }

  // Container content(BuildContext context, String text) {
  //   return Container(
  //       padding: const EdgeInsets.all(20),
  //       margin: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).colorScheme.secondary,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [Text(text)]));
  // }