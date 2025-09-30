import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/utils/constants.dart';
import 'package:emt7any/features/home/presentation/widgets/info_row.dart';
import 'package:flutter/material.dart';

class HomeInfoContainer extends StatelessWidget {
  const HomeInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        children: [
          InfoRow(
            icon: Icons.check_circle_outline,
            color: AppColors.success,
            text: 'سيتم حفظ الطلاب تلقائياً بعد المسح',
          ),
          SizedBox(height: 12),
          InfoRow(
            icon: Icons.timer_outlined,
            color: AppColors.warning,
            text: 'سيتم حذف البيانات تلقائياً بعد 5 ساعات',
          ),
        ],
      ),
    );
  }
}