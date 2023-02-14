import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'package:zikirmatik_2023/views/home_screen.dart';

import '../db_handler.dart';
import '../model.dart';

class AddDhikrPage extends StatefulWidget {
  const AddDhikrPage({super.key});

  @override
  State<AddDhikrPage> createState() => _AddDhikrPageState();
}

TextEditingController dhikrNameController = TextEditingController();
TextEditingController dhikrCountController = TextEditingController();
TextEditingController dhikrImameController = TextEditingController();
TextEditingController dhikrPronunciationController = TextEditingController();
TextEditingController dhikrMeaningController = TextEditingController();

class _AddDhikrPageState extends State<AddDhikrPage> {
  DbHelper? dbHelper;
  late Future<List<DhikrModel>> dataList;

  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zikir Ekle'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                heightSpacer(10),
                _buildTextFormField('Zikir Adı', TextInputAction.next, dhikrNameController, TextInputType.name),
                heightSpacer(30),
                _buildTextFormField('Zikir Adet', TextInputAction.next, dhikrCountController, TextInputType.number),
                heightSpacer(30),
                _buildTextFormField('Zikir İmame', TextInputAction.next, dhikrImameController, TextInputType.number),
                heightSpacer(30),
                _buildTextFormField(
                    'Zikir Okunuşu', TextInputAction.next, dhikrPronunciationController, TextInputType.text),
                heightSpacer(30),
                _buildTextFormField('Zikir Anlamı', TextInputAction.done, dhikrMeaningController, TextInputType.text),
                heightSpacer(30),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText, TextInputAction textInputAction,
          TextEditingController textEditingController, TextInputType inputType) =>
      TextFormField(
        keyboardType: inputType,
        controller: textEditingController,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            //borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          filled: true,
          //fillColor: Colors.red[50],
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Bir şeyler yazmanız gerekli...';
          }
          return null;
        },
      );

  Widget _buildSaveButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            print('Zikir Adı: ${dhikrNameController.text}');
            if (_fromKey.currentState!.validate()) {
              dbHelper!.insert(DhikrModel(
                  dhikrName: dhikrNameController.text,
                  dhikrCount: dhikrCountController.text,
                  dhikrImame: dhikrImameController.text,
                  dhikrPronunication: dhikrPronunciationController.text,
                  dhikrMeaning: dhikrMeaningController.text,
                  dateAndTime: DateFormat('yMd').add_jm().format(DateTime.now()).toString()));

              Navigator.push(context, MaterialPageRoute(builder: ((context) => HomeScreen())));
              //Navigator.pop(context);
              dhikrNameController.clear();
              dhikrCountController.clear();
              dhikrImameController.clear();
              dhikrPronunciationController.clear();
              dhikrMeaningController.clear();
            }
          });
        },
        child: Text('Zikir Ekle'),
      ),
    );
  }

  Widget heightSpacer(double myHeight) => SizedBox(height: myHeight);
}
