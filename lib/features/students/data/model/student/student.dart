import 'data.dart';

class Student {
	bool? status;
	String? message;
	Data? data;
  final List<String>? reasons;

	Student( {this.reasons,this.status, this.message, this.data});

	factory Student.fromJson(Map<String, dynamic> json) => Student(
				status: json['status'] as bool?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
        reasons: json['reasons'] != null
          ? List<String>.from(json['reasons'])
          : null, // ✅ تحويل الـ List    
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data?.toJson(),
        'reasons': reasons,
			};
}
