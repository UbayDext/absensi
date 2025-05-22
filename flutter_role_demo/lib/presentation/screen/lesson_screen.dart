import 'package:flutter/material.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              onDateChanged: (date) {},
              selectableDayPredicate: (day) {
                return day.weekday != 6 && day.weekday != 7;
              },
            ),
          ),
        ],
      ),
    );
  }
}
