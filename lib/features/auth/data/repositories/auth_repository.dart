import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:emt7any/features/auth/data/models/teacher/data.dart';
import 'package:emt7any/features/auth/data/models/teacher/teacher.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/dio_helper.dart';
import '../../../../core/utils/constants.dart';


class AuthRepository {
  // Login
  Future<Either<Failure, Teacher>> login({
    required String nationalId,
    required String password,
  }) async {
    try {
      final response = await DioHelper.post(
        endpoint: AppConstants.loginEndpoint,
        data: {
          'national_id': nationalId,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final teacherResponse = Teacher.fromJson(response.data);
        
        if (teacherResponse.status == true && teacherResponse.data != null) {
          // Save token
          await CacheHelper.saveString(
            AppConstants.tokenKey,
            teacherResponse.data!.accessToken ?? '',
          );
          
          // Save user data
          await CacheHelper.saveJson(
            AppConstants.userDataKey,
            teacherResponse.data!.toJson(),
          );
          
          // Set logged in status
          await CacheHelper.saveBool(AppConstants.isLoggedInKey, true);
          
          return Right(teacherResponse);
        } else {
          return Left(ServerFailure(teacherResponse.message ?? 'فشل تسجيل الدخول'));
        }
      } else {
        return Left(ServerFailure('خطأ في الاتصال بالخادم'));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(UnauthorizedFailure('بيانات الدخول غير صحيحة'));
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure('انتهت مهلة الاتصال'));
      } else if (e.type == DioExceptionType.unknown) {
        return const Left(NetworkFailure('تحقق من اتصالك بالإنترنت'));
      } else {
        return Left(ServerFailure(e.response?.data['message'] ?? 'حدث خطأ ما'));
      }
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return CacheHelper.getBool(AppConstants.isLoggedInKey) ?? false;
  }

  // Get saved user data
  Data? getSavedUserData() {
    final json = CacheHelper.getJson(AppConstants.userDataKey);
    if (json != null) {
      return Data.fromJson(json);
    }
    return null;
  }

  // Logout
  Future<void> logout() async {
    await CacheHelper.remove(AppConstants.tokenKey);
    await CacheHelper.remove(AppConstants.userDataKey);
    await CacheHelper.saveBool(AppConstants.isLoggedInKey, false);
  }
}