import 'package:flutter/foundation.dart'; // For debug checks
import 'package:logger/logger.dart';
import 'package:quitt/utils/enum.dart';

class LogUtil {
  static final LogUtil _instance = LogUtil._internal();

  factory LogUtil() => _instance;

  late final Logger _logger;

  LogUtil._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        // Number of stacktrace levels to print
        errorMethodCount: 3,
        // Number of method levels if there's an error
        lineLength: 120,
        // Adjust line length for readability
        colors: true,
        // Enable colors
        printEmojis: true,
        // Enable emojis
        printTime: false, // Disable timestamps for simplicity
      ),
    );
  }

  void _log(LogLevel level, String message) {
    if (kDebugMode) {
      final trace = StackTrace.current.toString().split('\n')[2];
      final matches = RegExp(r'#\d+\s+(.*?)\s+\(').firstMatch(trace);

      final location = matches != null ? matches.group(1) : "Unknown";
      final formattedMessage = "[$location] $message";

      switch (level) {
        case LogLevel.debug:
          _logger.d(formattedMessage);
          break;
        case LogLevel.info:
          _logger.i(formattedMessage);
          break;
        case LogLevel.warning:
          _logger.w(formattedMessage);
          break;
        case LogLevel.error:
          _logger.e(formattedMessage);
          break;
      }
    }
  }

  // Public logging methods

  void d(String message) => _log(LogLevel.debug, message);

  void i(String message) => _log(LogLevel.info, message);

  void w(String message) => _log(LogLevel.warning, message);

  void e(String message) => _log(LogLevel.error, message);
}
