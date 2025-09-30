import 'package:emt7any/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyStudentsContent extends StatelessWidget {
  const EmptyStudentsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: AppColors.textDisabled),
          const SizedBox(height: 16),
          const Text(
            'لا يوجد طلاب',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'قم بمسح رمز QR لإضافة طلاب',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

