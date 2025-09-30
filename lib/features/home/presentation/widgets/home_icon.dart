import 'package:emt7any/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.qr_code_scanner,
        size: 70,
        color: AppColors.primary,
      ),
    );
  }
}
