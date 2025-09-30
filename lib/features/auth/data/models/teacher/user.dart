import 'school.dart';

class User {
	int? id;
	String? name;
	String? email;
	String? phone;
	String? nationalId;
	String? userType;
	bool? isActive;
	dynamic emailVerifiedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	int? teacherId;
	String? teacherCode;
	int? subjectId;
	String? teacherType;
	bool? canCreateExams;
	bool? canCorrectEssays;
	List<School>? schools;

	User({
		this.id, 
		this.name, 
		this.email, 
		this.phone, 
		this.nationalId, 
		this.userType, 
		this.isActive, 
		this.emailVerifiedAt, 
		this.createdAt, 
		this.updatedAt, 
		this.teacherId, 
		this.teacherCode, 
		this.subjectId, 
		this.teacherType, 
		this.canCreateExams, 
		this.canCorrectEssays, 
		this.schools, 
	});

	factory User.fromJson(Map<String, dynamic> json) => User(
				id: json['id'] as int?,
				name: json['name'] as String?,
				email: json['email'] as String?,
				phone: json['phone'] as String?,
				nationalId: json['national_id'] as String?,
				userType: json['user_type'] as String?,
				isActive: json['is_active'] as bool?,
				emailVerifiedAt: json['email_verified_at'] as dynamic,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
				teacherId: json['teacher_id'] as int?,
				teacherCode: json['teacher_code'] as String?,
				subjectId: json['subject_id'] as int?,
				teacherType: json['teacher_type'] as String?,
				canCreateExams: json['can_create_exams'] as bool?,
				canCorrectEssays: json['can_correct_essays'] as bool?,
				schools: (json['schools'] as List<dynamic>?)
						?.map((e) => School.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'email': email,
				'phone': phone,
				'national_id': nationalId,
				'user_type': userType,
				'is_active': isActive,
				'email_verified_at': emailVerifiedAt,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'teacher_id': teacherId,
				'teacher_code': teacherCode,
				'subject_id': subjectId,
				'teacher_type': teacherType,
				'can_create_exams': canCreateExams,
				'can_correct_essays': canCorrectEssays,
				'schools': schools?.map((e) => e.toJson()).toList(),
			};
}
