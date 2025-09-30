class Data {
	int? sessionId;
	String? studentName;
	String? examTitle;
	int? examDuration;
	DateTime? createdAt;

	Data({
		this.sessionId, 
		this.studentName, 
		this.examTitle, 
		this.examDuration, 
		this.createdAt, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				sessionId: json['session_id'] as int?,
				studentName: json['student_name'] as String?,
				examTitle: json['exam_title'] as String?,
				examDuration: json['exam_duration'] as int?,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
			);

	Map<String, dynamic> toJson() => {
				'session_id': sessionId,
				'student_name': studentName,
				'exam_title': examTitle,
				'exam_duration': examDuration,
				'created_at': createdAt?.toIso8601String(),
			};
}
