import 'user.dart';

class Data {
	User? user;
	String? accessToken;
	String? tokenType;
	DateTime? expiresAt;

	Data({this.user, this.accessToken, this.tokenType, this.expiresAt});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
				accessToken: json['access_token'] as String?,
				tokenType: json['token_type'] as String?,
				expiresAt: json['expires_at'] == null
						? null
						: DateTime.parse(json['expires_at'] as String),
			);

	Map<String, dynamic> toJson() => {
				'user': user?.toJson(),
				'access_token': accessToken,
				'token_type': tokenType,
				'expires_at': expiresAt?.toIso8601String(),
			};
}
