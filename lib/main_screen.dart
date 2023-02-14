import 'package:flutter/material.dart';
import 'package:zikirmatik_2023/views/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        color: Colors.blue,
        child: const Center(
          child: Text(
            "Buraya reklam gelicek",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(children: const [
          HomeScreen(),
        ]),
      ),
    );
  }
}
