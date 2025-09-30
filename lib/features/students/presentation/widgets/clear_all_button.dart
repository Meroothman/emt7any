import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/utils/constants.dart';
import 'package:emt7any/core/widgets/custom_button.dart';
import 'package:emt7any/features/students/cubit/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClearAllButton extends StatelessWidget {
  const ClearAllButton({super.key});

  void _showClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        title: const Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 30),
            SizedBox(width: 12),
            Text('تأكيد الحذف'),
          ],
        ),
        content: const Text(
          'هل أنت متأكد من حذف جميع الطلاب؟ لا يمكن التراجع عن هذا الإجراء.',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),

          ElevatedButton(
            onPressed: () {
              context.read<StudentCubit>().clearAllStudents();
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم حذف جميع الطلاب'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
            ),
            child: const Text('حذف', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: CustomButton(
        text: 'حذف جميع الطلاب',
        onPressed: () {
          _showClearConfirmationDialog(context);
        },
        backgroundColor: AppColors.primary,
        icon: Icons.delete_outline,
      ),
    );
  }
}
