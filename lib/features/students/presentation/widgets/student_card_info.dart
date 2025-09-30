import 'package:emt7any/features/students/presentation/widgets/student_info_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class StudentCardInfo extends StatelessWidget {
  final dynamic student;

  const StudentCardInfo({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: StudentInfoItem(
                icon: Icons.assignment_outlined,
                label: 'الامتحان',
                value: student.examTitle ?? 'غير محدد',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StudentInfoItem(
                icon: Icons.access_time,
                label: 'المدة',
                value: '${student.examDuration ?? 0} دقيقة',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        StudentInfoItem(
          icon: Icons.calendar_today,
          label: 'التاريخ',
          value: student.createdAt != null
              ? intl.DateFormat(
                  'yyyy-MM-dd HH:mm',
                  'ar',
                ).format(student.createdAt!)
              : 'غير محدد',
        ),
      ],
    );
  }
}

