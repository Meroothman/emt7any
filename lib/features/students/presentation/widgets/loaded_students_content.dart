import 'package:emt7any/features/students/presentation/widgets/clear_all_button.dart';
import 'package:emt7any/features/students/presentation/widgets/students_listview.dart';
import 'package:emt7any/features/students/presentation/widgets/timer_info.dart';
import 'package:flutter/material.dart';

class LoadedStudentsContent extends StatelessWidget {
  final List<dynamic> students;
  final Duration? remainingTime;
  final String Function(Duration) formatDuration;

  const LoadedStudentsContent({
    super.key,
    required this.students,
    required this.remainingTime,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timer Info
        if (remainingTime != null)
          TimerInfo(remainingTime: remainingTime!, formatDuration: formatDuration),

        // Students List
        Expanded(
          child: StudentsListView(students: students),
        ),

        // Clear All Button
        const ClearAllButton(),
      ],
    );
  }
}