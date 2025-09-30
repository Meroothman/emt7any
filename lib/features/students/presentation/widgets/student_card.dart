import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/utils/constants.dart';
import 'package:emt7any/features/students/presentation/widgets/student_card_header.dart';
import 'package:emt7any/features/students/presentation/widgets/student_card_info.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final dynamic student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            // Student Header
            StudentCardHeader(student: student),
            const Divider(height: 24),

            // Student Info
            StudentCardInfo(student: student),
          ],
        ),
      ),
    );
  }
}


