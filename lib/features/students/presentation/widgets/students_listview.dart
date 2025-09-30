import 'package:emt7any/core/utils/constants.dart';
import 'package:emt7any/features/students/presentation/widgets/student_card.dart';
import 'package:flutter/material.dart';

class StudentsListView extends StatelessWidget {
  final List<dynamic> students;

  const StudentsListView({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: students.length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: false,
      cacheExtent: 120,
      itemBuilder: (context, index) {
        final student = students[index];
        return StudentCard(student: student);
      },
    );
  }
}