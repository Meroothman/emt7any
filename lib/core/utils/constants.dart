class AppConstants {
  // API Base URL
  static const String baseUrl = 'https://exam-api.koyeb.app/api/v1';

  // Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String scanQrEndpoint = '/teacher/scan-qr-create-session';

  // Shared Preferences Keys
  static const String tokenKey = 'access_token';
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String studentsKey = 'students_data';
  static const String studentsTimestampKey = 'students_timestamp';

  // Storage Duration (5 hours in milliseconds)
  static const int storageDuration = 5 * 60 * 60 * 1000;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
}
