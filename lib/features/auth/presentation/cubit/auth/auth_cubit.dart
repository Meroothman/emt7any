import 'package:bloc/bloc.dart';
import 'package:emt7any/features/auth/data/models/teacher/data.dart';
import 'package:emt7any/features/auth/data/models/teacher/teacher.dart';
import 'package:emt7any/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
    bool _hasCheckedInitialStatus = false;

  AuthCubit(this.authRepository) : super(AuthInitial()) {
    checkLoginStatus();
  }

  // Check if user is already logged in
  void checkLoginStatus() {
    if (_hasCheckedInitialStatus) return;
    _hasCheckedInitialStatus = true;
    
    print('=== CHECKING LOGIN STATUS ===');
    
    if (authRepository.isLoggedIn()) {
      final userData = authRepository.getSavedUserData();
      if (userData != null) {
        print('✅ User is logged in');
        emit(AuthLoggedIn(userData));
      } else {
        print('❌ User data is null');
        emit(AuthLoggedOut());
      }
    } else {
      print('❌ User is not logged in');
      emit(AuthLoggedOut());
    }
    
  }


  // Login
  Future<void> login({
    required String nationalId,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.login(
      nationalId: nationalId,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (response) {
        if (response.data != null) {
          emit(AuthSuccess(response));
          emit(AuthLoggedIn(response.data!));
        } else {
          emit(const AuthError('فشل تسجيل الدخول'));
        }
      },
    );
  }

  // Logout
  Future<void> logout() async {
    await authRepository.logout();
    emit(AuthLoggedOut());
  }

  // Get current user data
  Data? getCurrentUser() {
    return authRepository.getSavedUserData();
  }
  }