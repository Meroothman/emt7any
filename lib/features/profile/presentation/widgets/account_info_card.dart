import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'info_card.dart';

class AccountInfoCard extends StatelessWidget {
  final dynamic user;

  const AccountInfoCard({super.key, required this.user});

  String _formatDate(DateTime date) {
    try {
      return intl.DateFormat('yyyy-MM-dd', 'ar').format(date);
    } catch (e) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      children: [
        InfoRow(
          icon: Icons.calendar_today_outlined,
          label: 'تاريخ الإنشاء',
          value: user?.createdAt != null
              ? _formatDate(user!.createdAt!)
              : 'غير محدد',
        ),
        const Divider(),
        InfoRow(
          icon: Icons.update_outlined,
          label: 'آخر تحديث',
          value: user?.updatedAt != null
              ? _formatDate(user!.updatedAt!)
              : 'غير محدد',
        ),
      ],
    );
  }
}
