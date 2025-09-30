
part of 'student_cubit.dart';

@immutable
abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentIdExtracted extends StudentState {
  final String studentId;

  const StudentIdExtracted(this.studentId);

  @override
  List<Object?> get props => [studentId];
}

class StudentScanSuccess extends StudentState {
  final Student studentResponse;

  const StudentScanSuccess(this.studentResponse);

  @override
  List<Object?> get props => [studentResponse];
}

class StudentScanError extends StudentState {
  final String message;

  const StudentScanError(this.message);

  @override
  List<Object?> get props => [message];
}

class StudentListLoaded extends StudentState {
  final List<Data> students;
  final Duration? remainingTime;

  const StudentListLoaded(this.students, this.remainingTime);

  @override
  List<Object?> get props => [students, remainingTime];
}

class StudentListEmpty extends StudentState {}