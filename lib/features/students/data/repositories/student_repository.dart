// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:emt7any/features/students/data/model/student/data.dart';
// import 'package:emt7any/features/students/data/model/student/student.dart';
// import '../../../../core/error/failures.dart';
// import '../../../../core/services/cache_helper.dart';
// import '../../../../core/services/dio_helper.dart';
// import '../../../../core/utils/constants.dart';

// class StudentRepository {
//   // Extract student ID from QR code
//   String? extractStudentIdFromQr(String qrData) {
//     // print('🔍 QR Data received: $qrData');

//     try {

//       final jsonData = jsonDecode(qrData) as Map<String, dynamic>;

//       final studentId =
//           jsonData['student_id'] ??
//           jsonData['id'] ??
//           jsonData['studentId'] ??
//           jsonData['studentID'];

//       if (studentId != null) {
//         return studentId.toString();
//       }
//     } catch (e) {
//       // print('📄 QR is not JSON: $e');
//     }

//     if (RegExp(r'^\d+$').hasMatch(qrData)) {
//       return qrData;
//     }

//     final idMatch = RegExp(
//       r'id[:\s]*(\d+)',
//       caseSensitive: false,
//     ).firstMatch(qrData);
//     if (idMatch != null) {
//       return idMatch.group(1);
//     }

//     // المحاولة 4: إذا كان يحتوي على student_id في نص
//     final studentIdMatch = RegExp(
//       r'student[_\s]?id[:\s]*(\d+)',
//       caseSensitive: false,
//     ).firstMatch(qrData);
//     if (studentIdMatch != null) {
//       return studentIdMatch.group(1);
//     }

//     return null;
//   }

//   // Scan QR and create session
//   Future<Either<Failure, Student>> scanQrCode({
//     required String studentId,
//   }) async {
//     try {

//       final response = await DioHelper.post(
//         endpoint: AppConstants.scanQrEndpoint,
//         data: {'student_id': studentId},
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final studentResponse = Student.fromJson(response.data);

//         if (studentResponse.status == true && studentResponse.data != null) {
//           await _saveStudent(studentResponse.data!);
//           return Right(studentResponse);
//         } else {
//           return Left(
//             ServerFailure(studentResponse.message ?? 'فشل في إضافة الطالب'),
//           );
//         }
//       } else {
//         return Left(ServerFailure('خطأ في الاتصال بالخادم'));
//       }
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 401) {
//         return const Left(
//           UnauthorizedFailure(
//             'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى',
//           ),
//         );
//       } else if (e.response?.statusCode == 422) {

//         final responseData = e.response?.data;
//         String errorMessage = 'بيانات غير صالحة';

//         if (responseData is Map<String, dynamic>) {
//           errorMessage =
//               responseData['message']?.toString() ?? 'بيانات غير صالحة';
//         } else if (responseData is String) {
//           errorMessage = responseData;
//         }

//         return Left(ServerFailure(errorMessage));
//       } else if (e.type == DioExceptionType.connectionTimeout ||
//           e.type == DioExceptionType.receiveTimeout) {
//         return const Left(NetworkFailure('انتهت مهلة الاتصال'));
//       } else if (e.type == DioExceptionType.unknown) {
//         return const Left(NetworkFailure('تحقق من اتصالك بالإنترنت'));
//       } else {
//         // التصحيح هنا أيضاً - تحقق من نوع البيانات
//         final responseData = e.response?.data;
//         String errorMessage = 'حدث خطأ ما';

//         if (responseData is Map<String, dynamic>) {
//           errorMessage = responseData['message']?.toString() ?? 'حدث خطأ ما';
//         } else if (responseData is String) {
//           errorMessage = responseData;
//         }

//         return Left(ServerFailure(errorMessage));
//       }
//     } catch (e) {
//       return Left(ServerFailure('حدث خطأ غير متوقع: ${e.toString()}'));
//     }
//   }

//   // Save student to local storage
//   Future<void> _saveStudent(Data student) async {
//     final students = getStoredStudents();
//     students.add(student);

//     final studentsJson = students.map((s) => s.toJson()).toList();
//     await CacheHelper.saveJsonList(AppConstants.studentsKey, studentsJson);

//     await CacheHelper.saveInt(
//       AppConstants.studentsTimestampKey,
//       DateTime.now().millisecondsSinceEpoch,
//     );
//   }

//   // Get stored students
//   List<Data> getStoredStudents() {
//     // Check if data is expired (5 hours)
//     final timestamp = CacheHelper.getInt(AppConstants.studentsTimestampKey);
//     if (timestamp != null) {
//       final difference = DateTime.now().millisecondsSinceEpoch - timestamp;
//       if (difference > AppConstants.storageDuration) {
//         // Data expired, clear it
//         clearStudents();
//         return [];
//       }
//     }

//     final studentsJson = CacheHelper.getJsonList(AppConstants.studentsKey);
//     if (studentsJson != null) {
//       return studentsJson
//           .map((json) => Data.fromJson(json as Map<String, dynamic>))
//           .toList();
//     }
//     return [];
//   }

//   // Clear all students
//   Future<void> clearStudents() async {
//     await CacheHelper.remove(AppConstants.studentsKey);
//     await CacheHelper.remove(AppConstants.studentsTimestampKey);
//   }

//   // Get remaining time before auto-clear
//   Duration? getRemainingTime() {
//     final timestamp = CacheHelper.getInt(AppConstants.studentsTimestampKey);
//     if (timestamp != null) {
//       final difference = DateTime.now().millisecondsSinceEpoch - timestamp;
//       final remaining = AppConstants.storageDuration - difference;
//       if (remaining > 0) {
//         return Duration(milliseconds: remaining);
//       }
//     }
//     return null;
//   }
// }

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:emt7any/features/students/data/model/student/data.dart';
import 'package:emt7any/features/students/data/model/student/student.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/dio_helper.dart';
import '../../../../core/utils/constants.dart';

class StudentRepository {
  // Extract student ID from QR code
  String? extractStudentIdFromQr(String qrData) {
    try {
      final jsonData = jsonDecode(qrData) as Map<String, dynamic>;

      final studentId =
          jsonData['student_id'] ??
          jsonData['id'] ??
          jsonData['studentId'] ??
          jsonData['studentID'];

      if (studentId != null) {
        return studentId.toString();
      }
    } catch (e) {
      // QR is not JSON
    }

    if (RegExp(r'^\d+$').hasMatch(qrData)) {
      return qrData;
    }

    final idMatch = RegExp(
      r'id[:\s]*(\d+)',
      caseSensitive: false,
    ).firstMatch(qrData);
    if (idMatch != null) {
      return idMatch.group(1);
    }

    final studentIdMatch = RegExp(
      r'student[_\s]?id[:\s]*(\d+)',
      caseSensitive: false,
    ).firstMatch(qrData);
    if (studentIdMatch != null) {
      return studentIdMatch.group(1);
    }

    return null;
  }

  // Scan QR and create session
  Future<Either<Failure, Student>> scanQrCode({
    required String studentId,
  }) async {
    try {
      final response = await DioHelper.post(
        endpoint: AppConstants.scanQrEndpoint,
        data: {'student_id': studentId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final studentResponse = Student.fromJson(response.data);

        // ✅ تعديل هنا: نجاح سواء فيه data أو لا
        if (studentResponse.status == true) {
          if (studentResponse.data != null) {
            await _saveStudent(studentResponse.data!);
          }
          return Right(studentResponse);
        } else {
          return Left(
            ServerFailure(studentResponse.message ?? 'فشل في إضافة الطالب'),
          );
        }
      } else {
        return Left(ServerFailure('خطأ في الاتصال بالخادم'));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(
          UnauthorizedFailure(
            'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى',
          ),
        );
      } else if (e.response?.statusCode == 422) {
        final responseData = e.response?.data;
        String errorMessage = 'بيانات غير صالحة';

        if (responseData is Map<String, dynamic>) {
          errorMessage =
              responseData['message']?.toString() ?? 'بيانات غير صالحة';
        } else if (responseData is String) {
          errorMessage = responseData;
        }

        return Left(ServerFailure(errorMessage));
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure('انتهت مهلة الاتصال'));
      } else if (e.type == DioExceptionType.unknown) {
        return const Left(NetworkFailure('تحقق من اتصالك بالإنترنت'));
      } else {
        final responseData = e.response?.data;
        String errorMessage = 'حدث خطأ ما';

        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['message']?.toString() ?? 'حدث خطأ ما';
        } else if (responseData is String) {
          errorMessage = responseData;
        }

        return Left(ServerFailure(errorMessage));
      }
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  // Save student to local storage
  Future<void> _saveStudent(Data student) async {
    final students = getStoredStudents();
    students.add(student);

    final studentsJson = students.map((s) => s.toJson()).toList();
    await CacheHelper.saveJsonList(AppConstants.studentsKey, studentsJson);

    await CacheHelper.saveInt(
      AppConstants.studentsTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // Get stored students
  List<Data> getStoredStudents() {
    final timestamp = CacheHelper.getInt(AppConstants.studentsTimestampKey);
    if (timestamp != null) {
      final difference = DateTime.now().millisecondsSinceEpoch - timestamp;
      if (difference > AppConstants.storageDuration) {
        clearStudents();
        return [];
      }
    }

    final studentsJson = CacheHelper.getJsonList(AppConstants.studentsKey);
    if (studentsJson != null) {
      return studentsJson
          .map((json) => Data.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  // Clear all students
  Future<void> clearStudents() async {
    await CacheHelper.remove(AppConstants.studentsKey);
    await CacheHelper.remove(AppConstants.studentsTimestampKey);
  }

  // Get remaining time before auto-clear
  Duration? getRemainingTime() {
    final timestamp = CacheHelper.getInt(AppConstants.studentsTimestampKey);
    if (timestamp != null) {
      final difference = DateTime.now().millisecondsSinceEpoch - timestamp;
      final remaining = AppConstants.storageDuration - difference;
      if (remaining > 0) {
        return Duration(milliseconds: remaining);
      }
    }
    return null;
  }
}
