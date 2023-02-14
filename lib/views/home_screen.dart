import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:zikirmatik_2023/db_handler.dart';
import 'package:zikirmatik_2023/model.dart';
import 'package:zikirmatik_2023/views/add_dhikr_page.dart';
import 'package:zikirmatik_2023/views/dhikr_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DbHelper dbHelper = DbHelper();
  List<DhikrModel> arrList = [];
  bool hey = true;

  @override
  initState() {
    super.initState();
    loadData();
  }

  Future<List<DhikrModel>> loadData() async {
    arrList = await dbHelper.getDataList();
    setState(() {});
    return dbHelper.getDataList();
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
                if(arrList.isNotEmpty)
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AddDhikrPage())));
              },
              child: const Icon(
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
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Zikirler',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: arrList.length,
            itemBuilder: (context, index) {
              final item = arrList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DhikrDetailScreen(
                                dhikrModel: item,
                                count: item.dhikrCount,
                              ))));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      leading: const Icon(
                        FlutterIslamicIcons.prayer,
                        size: 30,
                      ),
                      title: Text(item.dhikrName ?? ""),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget _buildBody2() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
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

  Widget getTasListView() {
    return FutureBuilder(
      future: loadData(),
      builder: (context, AsyncSnapshot<List<DhikrModel>> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AddDhikrPage())));
                },
                child: Column(
                  children: [
                    Lottie.network(
                        "https://assets4.lottiefiles.com/packages/lf20_xFhzyuFl2E.json",
                        fit: BoxFit.cover,
                        width: 160,
                        repeat: false),
                    const Text(
                      'Zikir bulunamadı',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const Text(
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
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              int dhikrId = snapshot.data![index].id!.toInt();
              var data = snapshot.data![index];
              return Dismissible(
                key: ValueKey<int>(dhikrId),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.redAccent,
                  child: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    dbHelper.delete(dhikrId);
                    snapshot.data!.remove(snapshot.data![index]);
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DhikrDetailScreen(
                                  dhikrModel: data,
                                  count: data.dhikrCount,
                                ))));
                  },
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: const Icon(
                            FlutterIslamicIcons.prayer,
                            size: 30,
                          ),
                          title: Text(data.dhikrName ?? ""),
                          subtitle: Text('Zikir Adet: ${data.dhikrCount}'),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 0.8,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                data.dateAndTime,
                                style: const TextStyle(
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
              );
            },
          );
        }
      },
    );
  }
}
