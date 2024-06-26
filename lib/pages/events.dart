import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsvp/components/button.dart';
import 'package:rsvp/components/drawer.dart';
import 'package:rsvp/components/event_tile.dart';
import 'package:rsvp/components/textfield.dart';
import 'package:rsvp/pages/event_details.dart';
import 'package:rsvp/services/auth_services/auth_services.dart';
import 'package:rsvp/services/events_services/event_services.dart';
import 'package:rsvp/themes/themeprovider.dart';

class MyEventsPage extends StatelessWidget {
  MyEventsPage({super.key});

  final EventServices _eventService = EventServices();
  final AuthServices _auth = AuthServices();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _venue = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();

  Future<void> _showDatePicker(BuildContext context) async {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode();

    ColorScheme colScme = isDarkMode
        ? ColorScheme.dark(
            primary:
                Theme.of(context).colorScheme.tertiary, // Selected date color
          )
        : ColorScheme.light(
            primary:
                Theme.of(context).colorScheme.tertiary, // Selected date color
          );

    TextButtonThemeData textButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context)
            .colorScheme
            .tertiary, // Cancel and OK button text color
      ),
    );

    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: colScme,
            textButtonTheme: textButtonTheme,
            dialogBackgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _date.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode();

    ColorScheme colScme = isDarkMode
        ? ColorScheme.dark(
            primary:
                Theme.of(context).colorScheme.tertiary, // Selected date color
          )
        : ColorScheme.light(
            primary:
                Theme.of(context).colorScheme.tertiary, // Selected date color
          );

    TextButtonThemeData textButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context)
            .colorScheme
            .tertiary, // Cancel and OK button text color
      ),
    );

    TimePickerThemeData timePickerTheme = TimePickerThemeData(
      dayPeriodColor: Theme.of(context).colorScheme.tertiary,
    );

    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: colScme,
            textButtonTheme: textButtonTheme,
            timePickerTheme: timePickerTheme,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _time.text = "${picked.hour}:${picked.minute}";
    }
  }
  
  void clearControllers(){
    _title.clear();
    _description.clear();
    _venue.clear();
    _date.clear();
    _time.clear();
  }
  void okOnPressed()async{
    String username = await _auth.getUsername();
    if (username.isNotEmpty && _title.text.isNotEmpty && _description.text.isNotEmpty && _venue.text.isNotEmpty && _date.text.isNotEmpty && _time.text.isNotEmpty){
      _eventService.addEvent(_title.text, _description.text, _date.text, _time.text, username, _venue.text);
      print("Event added");
    }else{
      print("Event not added");
      // print(username.isNotEmpty);
      // print(_title.text.isNotEmpty);
      // print(_description.text.isNotEmpty);
      // print(_venue.text.isNotEmpty);
      // print(_date.text.isNotEmpty);
      // print(_time.text.isNotEmpty);
    }
    clearControllers();
  }
  void addEvent(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create Event'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Container(
                height: 400,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                          hintText: 'title',
                          obscureText: false,
                          controller: _title),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          hintText: 'description',
                          obscureText: false,
                          controller: _description),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          hintText: 'venue',
                          obscureText: false,
                          controller: _venue),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                              text: 'Date',
                              onTap: () => _showDatePicker(context)),
                          MyButton(
                              text: 'Time',
                              onTap: () => _showTimePicker(context)),
                        ],
                      )
                    ],
                  ),
                )),
            actions: [
              TextButton(
                onPressed: () {
                  okOnPressed();
                  Navigator.pop(context);
                },
                child: Text('Ok', style: TextStyle(color: isDarkMode? Colors.white : Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  clearControllers();
                  Navigator.pop(context);
                }, 
                child: Text('Cancel', style: TextStyle(color: isDarkMode? Colors.white : Colors.black),),
              ),
            ],
          );
        });
  }

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
      // button to create an event
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          onPressed: () => addEvent(context),
          elevation: 2.0,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _eventsList(context),
    );
  }

  Widget _eventsList(BuildContext context){
    return StreamBuilder(
      stream: _eventService.getEventStream(), 
      builder: (context, snapshot){
        //errors
          if (snapshot.hasError) {
            return const Text('Error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          //eventsList
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (eventData) => _buildEventsListItem(eventData, context))
                .toList(),
          );
      }
    );
  }

  Widget _buildEventsListItem(Map<String, dynamic> eventData, BuildContext context){
    return MyEventTile(
      eventName: eventData['title'], 
      onTap: () async{
          String username =  await _auth.getUsername();
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => EventDetails(title: eventData['title'], description: eventData['description'], host: eventData['host'], time: eventData['time'], date: eventData['date'], venue: eventData['venue'], username: username,),));
      },
    );
  }
}
