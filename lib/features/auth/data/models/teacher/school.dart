class School {
	int? id;
	String? name;
	String? assignmentType;
	bool? isActive;

	School({this.id, this.name, this.assignmentType, this.isActive});

	factory School.fromJson(Map<String, dynamic> json) => School(
				id: json['id'] as int?,
				name: json['name'] as String?,
				assignmentType: json['assignment_type'] as String?,
				isActive: json['is_active'] as bool?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'assignment_type': assignmentType,
				'is_active': isActive,
			};
}
