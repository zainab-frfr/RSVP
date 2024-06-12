import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rsvp/firebase_options.dart';
import 'package:rsvp/services/auth_services/auth_gate.dart';
import 'package:rsvp/themes/themeprovider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  await Hive.openBox('myBox');
  
  runApp(
    ChangeNotifierProvider(
      create: (context)=>ThemeProvider(), 
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).loadTheme(),
      initialRoute: '/authGate',
      routes: {
        '/authGate': (context) => const MyAuthGate(),
      }
    );
  }
}

// using Hive box (local storage) to store the theme because we don't need that to sync across multiple devices.