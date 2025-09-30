import 'package:emt7any/features/profile/presentation/widgets/info_card.dart';
import 'package:flutter/material.dart';

class TeacherInfoCard extends StatelessWidget {
  final dynamic user;

  const TeacherInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      children: [
        InfoRow(
          icon: Icons.code_outlined,
          label: 'كود المعلم',
          value: user?.teacherCode ?? 'غير محدد',
        ),
        const Divider(),
        InfoRow(
          icon: Icons.category_outlined,
          label: 'نوع المعلم',
          value: user?.teacherType ?? 'غير محدد',
        ),
      ],
    );
  }
}
