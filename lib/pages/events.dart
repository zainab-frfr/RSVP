import 'package:flutter/material.dart';
import 'package:rsvp/components/button.dart';
import 'package:rsvp/components/drawer.dart';
import 'package:rsvp/components/textfield.dart';

class MyEventsPage extends StatelessWidget {
  MyEventsPage({super.key});

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _venue = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();

  Future<void> _showDatePicker(BuildContext context ) async{
    DateTime? picked = await showDatePicker(
      context: context, 
      firstDate: DateTime(2024), 
      lastDate: DateTime(2030),
    );
    if (picked != null){
      _date.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  Future<void> _showTimePicker(BuildContext context ) async{
    TimeOfDay? picked = await showTimePicker(
    
      context: context, 
      initialTime: TimeOfDay.now(), 
    );
    if (picked != null){
      _time.text = "${picked.hour}:${picked.minute}";
    }
  }

  void addEvent(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create Event'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Container(
              height: 400,
              width: 300,
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  MyTextField(hintText: 'title', obscureText: false, controller: _title),
                  const SizedBox(height: 20,),
                  MyTextField(hintText: 'description', obscureText: false, controller: _description),
                  const SizedBox(height: 20,),
                  MyTextField(hintText: 'venue', obscureText: false, controller: _venue),
                  const SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(text: 'Date', onTap: () => _showDatePicker(context)),
                      MyButton(text: 'Time', onTap: () => _showTimePicker(context)),
                    ],
                  )
                  
              ],
            )),
            actions: const [],
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
    );
  }
}
