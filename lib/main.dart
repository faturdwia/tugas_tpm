import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/detail_page.dart';
import 'screens/create_page.dart';
import 'screens/edit_page.dart';
import 'models/smartphone.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TPM Responsi',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/home',
      routes: {
        '/home': (_) => const HomePage(),
        '/create': (_) => const CreatePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final sp = settings.arguments as Smartphone;
          return MaterialPageRoute(
            builder: (_) => DetailPage(smartphone: sp),
          );
        } else if (settings.name == '/edit') {
          final sp = settings.arguments as Smartphone;
          return MaterialPageRoute(
            builder: (_) => EditPage(smartphone: sp), 
          );
        }
      }
    );
  }
}