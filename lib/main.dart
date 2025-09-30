import 'package:emt7any/core/services/cache_helper.dart';
import 'package:emt7any/core/services/dio_helper.dart';
import 'package:emt7any/core/theme/app_colors.dart';
import 'package:emt7any/core/utils/constants.dart';
import 'package:emt7any/features/auth/data/repositories/auth_repository.dart';
import 'package:emt7any/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:emt7any/features/auth/presentation/cubit/screens/login_screen.dart';
import 'package:emt7any/features/main_layout.dart/main_screen.dart';
import 'package:emt7any/features/students/cubit/student_cubit.dart';
import 'package:emt7any/features/students/data/repositories/student_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة التنسيق المحلي للغة العربية
  await initializeDateFormatting('ar');

  // Optimize performance
  timeDilation = 1.0;

  // Disable unnecessary debugPrint calls in release mode
  debugPrint = (String? message, {int? wrapWidth}) {};

  // Initialize services
  await CacheHelper.init();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRepository())),
        BlocProvider(create: (context) => StudentCubit(StudentRepository())),
      ],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          title: 'emt7any',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              secondary: AppColors.secondary,
              
            ),
            
            useMaterial3: true,
            fontFamily: 'Arial',
          ),
          
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    // انتظر قليلاً لعرض الشاشة التمهيدية
    await Future.delayed(const Duration(seconds: 2));

    // تحقق مباشرة من الـ SharedPreferences
    final isLoggedIn = CacheHelper.getBool(AppConstants.isLoggedInKey) ?? false;

    if (isLoggedIn && mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
    } else if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: Colors.white),
            SizedBox(height: 24),
            Text(
              'نظام الامتحانات',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
