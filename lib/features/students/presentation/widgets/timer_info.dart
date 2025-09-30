import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/utils/constants.dart';
import 'package:flutter/material.dart';

class TimerInfo extends StatelessWidget {
  final Duration remainingTime;
  final String Function(Duration) formatDuration;

  const TimerInfo({
    super.key,
    required this.remainingTime,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const Icon(Icons.timer, color: AppColors.warning, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'سيتم حذف البيانات بعد: ${formatDuration(remainingTime)}',
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.warning,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



