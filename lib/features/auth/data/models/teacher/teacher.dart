import 'data.dart';

class Teacher {
	bool? status;
	String? message;
	Data? data;

	Teacher({this.status, this.message, this.data});

	factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
				status: json['status'] as bool?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data?.toJson(),
			};
}
