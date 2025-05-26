import 'package:flutter/foundation.dart';

class Logger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('DEBUG: $message');
      if (error != null) {
        print('ERROR: $error');
      }
      if (stackTrace != null) {
        print('STACK TRACE: $stackTrace');
      }
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      print('INFO: $message');
    }
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('WARNING: $message');
      if (error != null) {
        print('ERROR: $error');
      }
      if (stackTrace != null) {
        print('STACK TRACE: $stackTrace');
      }
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('ERROR: $message');
      if (error != null) {
        print('ERROR DETAILS: $error');
      }
      if (stackTrace != null) {
        print('STACK TRACE: $stackTrace');
      }
    }
    // In production, you might want to send this to a logging service
    // like Firebase Crashlytics or Sentry
  }
} 