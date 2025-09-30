import 'package:emt7any/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PermissionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isGranted;

  const PermissionRow({
    super.key,
    required this.icon,
    required this.label,
    required this.isGranted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(icon, size: 22, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(
            label,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isGranted
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isGranted ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: isGranted ? AppColors.success : AppColors.error,
                ),
                const SizedBox(width: 10),
                Text(
                  isGranted ? 'مفعل' : 'معطل',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isGranted ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
