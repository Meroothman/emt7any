import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/utils/constants.dart';
import 'package:emt7any/core/widgets/custom_button.dart';
import 'package:emt7any/core/widgets/custom_text_field.dart';
import 'package:emt7any/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:emt7any/features/main_layout.dart/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _nationalIdController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _nationalIdController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.teacherResponse.message ?? 'تم تسجيل الدخول بنجاح'),
                backgroundColor: AppColors.success,
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo
                      const _LogoWidget(),
                      const SizedBox(height: 32),

                      // Title
                      const _TitleWidget(),
                      const SizedBox(height: 48),

                      // National ID Field
                      CustomTextField(
                        controller: _nationalIdController,
                        label: 'الرقم القومي',
                        hint: 'أدخل الرقم القومي',
                        prefixIcon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                        validator: _validateNationalId,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        label: 'كلمة المرور',
                        hint: 'أدخل كلمة المرور',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: _validatePassword,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 32),

                      // Login Button
                      CustomButton(
                        text: 'تسجيل الدخول',
                        onPressed: _handleLogin,
                        isLoading: isLoading,
                        icon: Icons.login,
                      ),
                      const SizedBox(height: 24),

                      // Info Container
                      const _InfoWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String? _validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال الرقم القومي';
    }
    if (value.length < 14) {
      return 'الرقم القومي يجب أن يكون 14 رقم';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
            nationalId: _nationalIdController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.school,
        size: 60,
        color: AppColors.primary,
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'تسجيل الدخول',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'مرحباً بك في نظام الامتحانات',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        border: Border.all(
          color: AppColors.info.withOpacity(0.3),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.info,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'استخدم الرقم القومي وكلمة المرور الخاصة بك',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.info,
              ),
            ),
          ),
        ],
      ),
    );
  }
}