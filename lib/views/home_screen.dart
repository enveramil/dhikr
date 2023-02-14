import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:zikirmatik_2023/db_handler.dart';
import 'package:zikirmatik_2023/model.dart';
import 'package:zikirmatik_2023/views/add_dhikr_page.dart';
import 'package:zikirmatik_2023/views/new_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DbHelper? dbHelper;
  late Future<List<DhikrModel>> dataList;

  List arrList = ['Esmaül Hüsna', 'La Havle', 'Salavat'];
  bool hey = true;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadData();
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBody(),
                _buildBody2(),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 80,
          width: 80,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => AddDhikrPage())));
              },
              child: Icon(
                FlutterIslamicIcons.tasbihHand,
                size: 55,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'Zikirler',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => MyWidget(
                          title: text(arrList[0]),
                          count: 99,
                        ))));
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  FlutterIslamicIcons.prayer,
                  size: 30,
                ),
                title: text(arrList[0].toString()),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => MyWidget(
                          title: text(arrList[1]),
                          count: 99,
                        ))));
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  FlutterIslamicIcons.prayer,
                  size: 30,
                ),
                title: text(arrList[1]),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => MyWidget(
                          title: text(arrList[2]),
                          count: 99,
                        ))));
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  FlutterIslamicIcons.prayer,
                  size: 30,
                ),
                title: text(arrList[2]),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody2() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Icon(
                    FlutterIslamicIcons.allah,
                    size: 50,
                  )),
              SizedBox(
                width: 25,
              ),
              Expanded(
                flex: 6,
                child: Text(
                  'Zikir Listem',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Icon(
                    FlutterIslamicIcons.allah,
                    size: 50,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: getTasListView(),
        ),
      ],
    );
  }

  Widget text(String title) {
    return Text(
      title,
    );
  }

  Widget getTasListView() {
    return FutureBuilder(
      future: dataList,
      builder: (context, AsyncSnapshot<List<DhikrModel>> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.length == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => AddDhikrPage())));
                },
                child: Column(
                  children: [
                    Lottie.network("https://assets4.lottiefiles.com/packages/lf20_xFhzyuFl2E.json",
                        fit: BoxFit.cover, width: 160, repeat: false),
                    Text(
                      'Zikir bulunamadı',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Zikir eklemek için bu alana tıklayabilirsiniz',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              int dhikrId = snapshot.data![index].id!.toInt();
              String dhikrName = snapshot.data![index].dhikrName.toString();
              String dhikrCount = snapshot.data![index].dhikrCount.toString();
              String dhikrImame = snapshot.data![index].dhikrImame.toString();
              String dhikrPronunication = snapshot.data![index].dhikrPronunication.toString();
              String dhikrMeaning = snapshot.data![index].dhikrMeaning.toString();
              String dhikrDateAndTime = snapshot.data![index].dateAndTime.toString();
              return Dismissible(
                key: ValueKey<int>(dhikrId),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.redAccent,
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    dbHelper!.delete(dhikrId);
                    dataList = dbHelper!.getDataList();
                    snapshot.data!.remove(snapshot.data![index]);
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MyWidget(
                                  title: text(dhikrName),
                                  count: int.parse(dhikrCount),
                                ))));
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(10),
                            leading: Icon(
                              FlutterIslamicIcons.prayer,
                              size: 30,
                            ),
                            title: Text(dhikrName),
                            subtitle: Text('Zikir Adet: ${dhikrCount}'),
                            trailing: Icon(Icons.arrow_forward),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 0.8,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  dhikrDateAndTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
