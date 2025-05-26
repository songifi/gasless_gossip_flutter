class AppConstants {
  // App Info
  static const String appName = 'Gasless Gossip';
  static const String appVersion = '1.0.0';
  
  // API Constants
  static const int apiTimeout = 30000; // 30 seconds
  static const String baseUrl = 'https://api.example.com'; // Replace with your actual API URL
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
} 