import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:myappoint/core/constants.dart';
import 'package:myappoint/data/dataBase/data_base_handler.dart';
import 'package:myappoint/model/task_model.dart';
import 'package:myappoint/screens/newTask/new_task.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final DB = sl<DatabaseHandler>();

  @override
  void initState() {
    super.initState();
    //Start showcase view after current widget frames are drawn.
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context)!.startShowCase(
        [_one, _two],
      ),
    );

    DB.initializeDB().whenComplete(() async {
      await addTasks();
      setState(() {});
    });
  }

  // insert two tasks manually
  addTasks() async {
    Task firstTask = Task(
        title: "تناول الفيتامين",
        description: "فيتامين سي و اي",
        date: "sunday",
        time: "7.0");
    Task secondTask = Task(
        title: "قراءة الورد اليومي",
        description: " قراءة عالاقل ربع جزء ",
        date: "sunday",
        time: "8.0");
    List<Task> listOfTasks = [firstTask, secondTask];
    return await DB.insertTask(listOfTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Image.asset("assest/images/background.jpg"),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 110, left: 90),
                child: Text(
                  "صباح الخير وردة،",
                  style: textTheme.bodyText1,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 160),
                child: Text(
                  "أضف أعمال اليوم.!",
                  style: textTheme.bodyText2,
                ),
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.all(10),
                child: FutureBuilder(
                  future: DB.retrieveTasks(), // return all data
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Task>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: const Icon(Icons.delete_forever),
                              ),
                              key: ValueKey<int>(snapshot.data![index].id!),
                              onDismissed: (DismissDirection direction) async {
                                await DB.deleteTask(snapshot.data![index].id!);
                                setState(() {
                                  snapshot.data!.remove(snapshot.data![index]);
                                  // to remove a dismissed Dismissible widget from the tree
                                });
                              },
                              child: Showcase(
                                key: _one,
                                description: "إسحب لحذف المهمة",
                                child: Card(
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    title: Text(
                                      snapshot.data![0].title.toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![0].description.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    trailing: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data![0].time.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: const Icon(Icons.delete_forever),
                            ),
                            key: ValueKey<int>(snapshot.data![index].id!),
                            onDismissed: (DismissDirection direction) async {
                              await DB.deleteTask(snapshot.data![index].id!);
                              setState(() {
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            child: Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                title: Text(
                                  snapshot.data![index].title.toString(),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  snapshot.data![index].description.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data![index].time.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Showcase(
                overlayPadding: const EdgeInsets.all(10),
                key: _two,
                title: 'مهمة جديدة ',
                description: 'إضغط لإضافة مهمة جديدة',
                showcaseBackgroundColor: Colors.pink,
                textColor: Colors.white,
                shapeBorder: const CircleBorder(),
                child: Container(
                  width: 110,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewTask()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Center(
                          child: Text(
                            "أضف مهمة",
                            style: TextStyle(
                              color: Colors.white,
                              //  fontSize: 15,
                              // decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
