import 'package:flutter/material.dart';
import 'package:zikirmatik_2023/main_screen.dart';
import 'package:zikirmatik_2023/views/add_dhikr_page.dart';
import 'package:zikirmatik_2023/views/dhikr_detail_screen.dart';
import 'package:zikirmatik_2023/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: "/",
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == "/add") {
          return MaterialPageRoute(builder: (context) {
            return const AddDhikrPage();
          });
        }   if (settings.name == "/detail") {
          return MaterialPageRoute(builder: (context) {
            final args = settings.arguments as DhikrDetailScreenArguments;
            return   DhikrDetailScreen(args:args);
          });
        }
      },
      home: const MainScreen(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
