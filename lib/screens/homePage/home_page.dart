import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 110, left: 90),
            child: const Text(
              "صباح الخير وردة،",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 160),
            child: const Text(
              "أضف أعمال اليوم.!",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: 600,
            height: 300,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const Card(
                    child: ListTile(
                      leading: Icon(Icons.access_alarm_outlined),
                      title: Text('المهمة الأولى'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  );
                }),
          ),
          Container(
            width: 110,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.brown,
            ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}