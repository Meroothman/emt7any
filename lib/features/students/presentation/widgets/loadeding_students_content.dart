import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/utils/constants.dart';
import 'package:emt7any/features/students/presentation/widgets/shimmer_student_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingStudentsContent extends StatelessWidget {
  const LoadingStudentsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timer Info Shimmer
        Container(
          margin: const EdgeInsets.all(AppConstants.defaultPadding),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            border: Border.all(color: AppColors.border),
          ),
          child: Shimmer.fromColors(
            baseColor: AppColors.textDisabled.withOpacity(0.3),
            highlightColor: AppColors.surface,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Students List Shimmer
        Expanded(child: ShimmerStudentList(itemCount: 5)),

        // Clear Button Shimmer
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Shimmer.fromColors(
            baseColor: AppColors.textDisabled.withOpacity(0.3),
            highlightColor: AppColors.surface,
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
