import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/features/profile/presentation/widgets/info_card.dart';
import 'package:flutter/material.dart';

class SchoolsCard extends StatelessWidget {
  final List<dynamic> schools;

  const SchoolsCard({super.key, required this.schools});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      children: schools
          .map(
            (school) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.school_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          school.name ?? 'غير محدد',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          school.assignmentType ?? '',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (school.isActive == true)
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 20,
                    ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

