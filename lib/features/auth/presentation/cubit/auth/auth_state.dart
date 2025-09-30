part of 'auth_cubit.dart';

@immutable


abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Teacher teacherResponse;

  const AuthSuccess(this.teacherResponse);

  @override
  List<Object?> get props => [teacherResponse];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoggedIn extends AuthState {
  final Data userData;

  const AuthLoggedIn(this.userData);

  @override
  List<Object?> get props => [userData];
}

class AuthLoggedOut extends AuthState {}


