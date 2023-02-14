import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:zikirmatik_2023/circle_progress.dart';
import 'package:zikirmatik_2023/views/home_screen.dart';

import '../db_handler.dart';
import '../model.dart';

class MyWidget extends StatefulWidget {
  Widget title;
  int count;
  MyWidget({super.key, required this.title, required this.count});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

SharedPreferences? pref;
int dhikrCountPref = pref?.getInt('dhikrCount') ?? 0;
bool isClick = false;

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  DbHelper? dbHelper;
  late Future<List<DhikrModel>> dataList;

  getValues() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      int count = widget.count;
      dhikrCountPref = pref?.getInt('dhikrCount') ?? count;
    });
  }

  @override
  void initState() {
    super.initState();
    getValues();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.title,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            )),
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
          child: Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.count != 0) {
                    widget.count = dhikrCountPref--;
                    isClick = true;
                    pref?.setInt('dhikrCount', dhikrCountPref);
                    pref?.setBool('isClick', isClick);
                  }
                });
              },
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      style: BorderStyle.solid,
                    )),
                child: Center(
                  child: Center(
                    child: Text(
                      isClick == false ? widget.count.toString() : dhikrCountPref.toString(),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
