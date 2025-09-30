import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'تسجيل الخروج',
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      icon: Icons.logout,
    );
  }
}