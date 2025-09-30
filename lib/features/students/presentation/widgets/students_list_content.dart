import 'package:emt7any/features/students/cubit/student_cubit.dart';
import 'package:emt7any/features/students/presentation/widgets/empty_students_content.dart';
import 'package:emt7any/features/students/presentation/widgets/loaded_students_content.dart';
import 'package:emt7any/features/students/presentation/widgets/loadeding_students_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsListContent extends StatelessWidget {
  const StudentsListContent({super.key});

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '$hours ساعة و $minutes دقيقة';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      buildWhen: (previous, current) {
        return current is StudentListLoaded ||
            current is StudentListEmpty ||
            current is StudentLoading || // أضف هذه الحالة
            current is StudentInitial;
      },
      builder: (context, state) {
        // تحميل الطلاب مرة واحدة فقط
        if (state is StudentInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<StudentCubit>().loadStudents();
          });
        }

        if (state is StudentLoading) {
          return const LoadingStudentsContent();
        } else if (state is StudentListLoaded) {
          return LoadedStudentsContent(
            students: state.students,
            remainingTime: state.remainingTime,
            formatDuration: _formatDuration,
          );
        } else if (state is StudentListEmpty) {
          return const EmptyStudentsContent();
        }

        return const LoadingStudentsContent();
      },
    );
  }
}




