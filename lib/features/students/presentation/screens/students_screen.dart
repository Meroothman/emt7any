import 'package:emt7any/features/students/presentation/widgets/students_header.dart';
import 'package:emt7any/features/students/presentation/widgets/students_list_content.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';


class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const StudentsHeader(),

            // Students List
            Expanded(child: StudentsListContent()),
          ],
        ),
      ),
    );
  }
}

