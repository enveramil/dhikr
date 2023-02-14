import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db_handler.dart';
import '../model.dart';

class DhikrDetailScreenArguments{
  DhikrModel dhikrModel;
  int count;
  DhikrDetailScreenArguments(this.dhikrModel,this.count);
}

class DhikrDetailScreen extends StatefulWidget {
  DhikrDetailScreenArguments args;

  DhikrDetailScreen({super.key, required this.args});

  @override
  State<DhikrDetailScreen> createState() => _DhikrDetailScreenState();
}

class _DhikrDetailScreenState extends State<DhikrDetailScreen>
    with TickerProviderStateMixin {
  DbHelper dbHelper = DbHelper();
  late Future<List<DhikrModel>> dataList;

  SharedPreferences? pref;
  int dhikrCountPref = 0;
  bool isClick = false;

  @override
  void initState() {
    dhikrCountPref = pref?.getInt('dhikrCount') ?? 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.args.dhikrModel.dhikrName ?? ""),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
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
          decoration: const BoxDecoration(
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
              onTap: () async {
                int count = --widget.args.count;
                if (widget.args.count >= 0) {
                  setState(() {});
                  await dbHelper.update(widget.args.dhikrModel.id ?? 0, count);
                }
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
                      "${widget.args.count}",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
