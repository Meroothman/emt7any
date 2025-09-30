import 'package:bloc/bloc.dart';
import 'package:emt7any/features/students/data/model/student/data.dart';
import 'package:emt7any/features/students/data/model/student/student.dart';
import 'package:emt7any/features/students/data/repositories/student_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentRepository studentRepository;

  StudentCubit(this.studentRepository) : super(StudentInitial());

  // Extract student ID from QR code (دالة جديدة)
  String? extractStudentId(String qrData) {
    return studentRepository.extractStudentIdFromQr(qrData);
  }

  // Scan QR Code after confirmation
  Future<void> confirmAndScanQrCode(String studentId) async {
    emit(StudentLoading());

    final result = await studentRepository.scanQrCode(studentId: studentId);

    result.fold(
      (failure) => emit(StudentScanError(failure.message)),
      (response) {
        emit(StudentScanSuccess(response));
        loadStudents();
      },
    );
  }

  // Load stored students
  void loadStudents() {
    final students = studentRepository.getStoredStudents();
    final remainingTime = studentRepository.getRemainingTime();

    if (students.isEmpty) {
      emit(StudentListEmpty());
    } else {
      emit(StudentListLoaded(students, remainingTime));
    }
  }

  // Clear all students
  Future<void> clearAllStudents() async {
    await studentRepository.clearStudents();
    emit(StudentListEmpty());
  }

  // Refresh students list
  void refreshStudents() {
    loadStudents();
  }
}