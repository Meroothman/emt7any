import 'package:emt7any/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeDescription extends StatelessWidget {
  const HomeDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'اضغط على الزر أدناه لبدء مسح رمز QR الخاص بالطالب',
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
    );
  }
}
