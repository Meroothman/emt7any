import 'package:emt7any/features/home/presentation/widgets/home_description.dart';
import 'package:emt7any/features/home/presentation/widgets/home_icon.dart';
import 'package:emt7any/features/home/presentation/widgets/home_info_container.dart';
import 'package:emt7any/features/home/presentation/widgets/home_title.dart';
import 'package:emt7any/features/home/presentation/widgets/start_scan_button.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              const HomeIcon(),
              const SizedBox(height: 32),

              // Title
              const HomeTitle(),
              const SizedBox(height: 12),

              // Description
              const HomeDescription(),
              const SizedBox(height: 48),

              // Start Scan Button
              StartScanButton(),
              const SizedBox(height: 16),

              // Info Container
              const HomeInfoContainer(),
            ],
          ),
        ),
      ),
    );
  }
}








