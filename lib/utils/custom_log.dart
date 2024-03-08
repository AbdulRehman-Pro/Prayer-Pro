import 'dart:developer' as developer;

class CustomLog {
  // Blue text
  static void info(String msg) {
    developer.log('\x1B[34m$msg\x1B[0m');
  }

  // Green text
  static void success(String msg) {
    developer.log('\x1B[32m$msg\x1B[0m');
  }

  // Yellow text
  static void warning(String msg) {
    developer.log('\x1B[33m$msg\x1B[0m');
  }

  // Red text
  static void error(String msg) {
    developer.log('\x1B[31m$msg\x1B[0m');
  }


//   Custom colors
//   Reset:   \x1B[0m
//   Black:   \x1B[30m
//   White:   \x1B[37m
//   Red:     \x1B[31m
//   Green:   \x1B[32m
//   Yellow:  \x1B[33m
//   Blue:    \x1B[34m
//   Cyan:    \x1B[36m


}