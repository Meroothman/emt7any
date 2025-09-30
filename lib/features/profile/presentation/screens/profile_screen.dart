import 'package:emt7any/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:emt7any/features/auth/presentation/cubit/screens/login_screen.dart';
import 'package:emt7any/features/profile/presentation/widgets/account_info_card.dart';
import 'package:emt7any/features/profile/presentation/widgets/info_card.dart';
import 'package:emt7any/features/profile/presentation/widgets/logout_button.dart';
import 'package:emt7any/features/profile/presentation/widgets/permissions_card.dart';
import 'package:emt7any/features/profile/presentation/widgets/personal_info_card.dart';
import 'package:emt7any/features/profile/presentation/widgets/profile_header.dart';
import 'package:emt7any/features/profile/presentation/widgets/schools_card.dart';
import 'package:emt7any/features/profile/presentation/widgets/section_title.dart';
import 'package:emt7any/features/profile/presentation/widgets/teacher_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoggedIn) {
            return ProfileContent(user: state.userData.user);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final dynamic user;

  const ProfileContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            ProfileHeader(user: user),

            // Information Cards
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information
                  const SectionTitle(title: 'المعلومات الشخصية'),
                  const SizedBox(height: 16),
                  PersonalInfoCard(user: user),
                  const SizedBox(height: 16),

                  // Teacher Information
                  const SectionTitle(title: 'معلومات المعلم'),
                  const SizedBox(height: 16),
                  TeacherInfoCard(user: user),
                  const SizedBox(height: 16),

                  // Permissions
                  const SectionTitle(title: 'الصلاحيات'),
                  const SizedBox(height: 16),
                  _buildPermissionsCard(),
                  const SizedBox(height: 16),

                  // Schools
                  if (user?.schools != null && user!.schools!.isNotEmpty) ...[
                    const SectionTitle(title: 'المدارس'),
                    const SizedBox(height: 16),
                    SchoolsCard(schools: user!.schools!),
                    const SizedBox(height: 16),
                  ],

                  // Account Information
                  const SectionTitle(title: 'معلومات الحساب'),
                  const SizedBox(height: 16),
                  AccountInfoCard(user: user),
                  const SizedBox(height: 24),

                  // Logout Button
                  LogoutButton(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsCard() {
    return InfoCard(
      children: [
        PermissionRow(
          icon: Icons.assignment_outlined,
          label: 'إنشاء الامتحانات',
          isGranted: user?.canCreateExams ?? false,
        ),
        const Divider(),
        PermissionRow(
          icon: Icons.edit_outlined,
          label: 'تصحيح المقالات',
          isGranted: user?.canCorrectEssays ?? false,
        ),
        const Divider(),
        PermissionRow(
          icon: Icons.check_circle_outline,
          label: 'الحساب نشط',
          isGranted: user?.isActive ?? false,
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        title: const Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(Icons.logout, color: AppColors.primary, size: 20),
            SizedBox(width: 12),
            Text('تسجيل الخروج'),
          ],
        ),
        content: const Text(
          'هل أنت متأكد من تسجيل الخروج؟',
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
              Navigator.pop(dialogContext);
              context.read<AuthCubit>().logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
            ),
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}