import 'package:flutter/material.dart';
import 'package:rsvp/components/button.dart';
import 'package:rsvp/services/events_services/event_services.dart';

class EventDetails extends StatefulWidget {
  final String title;
  final String description;
  final String host;
  final String time;
  final String date;
  final String venue;
  final String username;

  const EventDetails(
      {super.key,
      required this.title,
      required this.description,
      required this.host,
      required this.time,
      required this.date,
      required this.venue,
      required this.username});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  EventServices eventService = EventServices();

  Future<bool> _isAttending() async {
    return await eventService.isAttending(widget.title, widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: FloatingActionButton(
                elevation: 0.0,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: const Text('RSVP'),
                onPressed: () {
                  eventService.addAttendee(widget.title, widget.username);
                  setState(() {});
                }),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              tile(context, 'Description', widget.description),
              tile(context, 'Venue', widget.venue),
              tile(context, 'Organizer', widget.host),
              tile(context, 'Date', widget.date),
              tile(context, 'Time', widget.time),
            ],
          ),
          FutureBuilder<bool>(
            future: _isAttending(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error checking RSVP status'));
              } else if (snapshot.hasData && snapshot.data == true) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: MyButton(
                    text: 'Event Chat',
                    onTap: () {},
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
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
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3, // Adjust the maxLines as needed
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
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