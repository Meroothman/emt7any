

import 'package:emt7any/features/profile/presentation/widgets/info_card.dart';
import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  final dynamic user;

  const PersonalInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      children: [
        InfoRow(
          icon: Icons.email_outlined,
          label: 'البريد الإلكتروني',
          value: user?.email ?? 'غير محدد',
        ),
        const Divider(),
        InfoRow(
          icon: Icons.phone_android,
          label: 'رقم الهاتف',
          value: user?.phone ?? 'غير محدد',
        ),
        const Divider(),
        InfoRow(
          icon: Icons.badge_outlined,
          label: 'الرقم القومي',
          value: user?.nationalId ?? 'غير محدد',
        ),
      ],
    );
  }
}