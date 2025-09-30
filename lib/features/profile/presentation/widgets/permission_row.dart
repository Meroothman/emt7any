import 'package:emt7any/features/profile/presentation/widgets/info_card.dart';
import 'package:emt7any/features/profile/presentation/widgets/permissions_card.dart';
import 'package:flutter/material.dart';

class PermissionsCard extends StatelessWidget {
  final dynamic user;

  const PermissionsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      children: [
        PermissionRow(
          icon: Icons.assignment_outlined,
          label: 'إنشاء الامتحانات',
          isGranted: user?.canCreateExams ?? false,
        ),
        const Divider(),
        PermissionRow(
          icon: Icons.edit_outlined,
          label: 'تصحيح المقالات',
          isGranted: user?.canCorrectEssays ?? false,
        ),
        const Divider(),
        PermissionRow(
          icon: Icons.check_circle_outline,
          label: 'الحساب نشط',
          isGranted: user?.isActive ?? false,
        ),
      ],
    );
  }
}

