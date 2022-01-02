// import 'dart:ui';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myappoint/core/constants.dart';
import 'package:myappoint/data/dataBase/data_base_handler.dart';
import 'package:myappoint/model/task_model.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  late DateTime _date = DateTime.now();
  DatabaseHandler handler = DatabaseHandler();
  void onTimeChanged(TimeOfDay newTime) => setState(() => _time = newTime);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Image.asset("assest/images/background.jpg"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 90, left: 110),
                  child: Text(
                    " أضف مهمة جديدة !",
                    style: textTheme.bodyText1,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  child: TextField(
                    controller: titleController,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffe3f0f4),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide(width: 1, color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide(width: 1, color: Colors.teal),
                      ),
                      hintText: 'آضف عنوان مهمتك الان',
                      labelText: 'عنوان المهمة',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: TextField(
                    controller: descriptionController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffe3f0f4),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide(width: 1, color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide(width: 1, color: Colors.teal),
                      ),
                      hintText: 'آضف وصف مهمتك الان',
                      labelText: 'وصف المهمة',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2021, 7, 18),
                        maxTime: DateTime(2028, 7, 18),
                        theme: const DatePickerTheme(
                            headerColor: Color(0xffd6297b),
                            backgroundColor: Color(0xff5a80a5),
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onConfirm: (date) {
                      setState(() {
                        _date = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.ar);
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffe3f0f4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "يوم المهمة",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            "${_date.day}-${_date.month}-${_date.year}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //
                InkWell(
                  onTap: () async {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _time,
                        onChange: onTimeChanged,
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffe3f0f4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "تاريخ المهمة",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            _time.format(context),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    List<Task> newTasks = [
                      Task(
                          title: titleController.text,
                          description: descriptionController.text,
                          time: _time.toString(),
                          date: _date.toString())
                    ];
                    await handler.insertTask(newTasks);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 90),
                    width: 110,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "إضافة",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
