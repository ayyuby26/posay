import 'dart:developer';

class Print {
  static Print? _instance;

  factory Print() {
    _instance ??= Print._();
    return _instance!;
  }

  Print._();
  static void toska(n) => log('\x1B[36m$n\x1B[0m');
  static void orange(n) => log('\x1B[33m$n\x1B[0m');
  static void red(n) => log('\x1B[31m$n\x1B[0m');
  static void green(n) => log('\x1B[32m$n\x1B[0m');
  static void purple(n) => log('\x1B[35m$n\x1B[0m');
  static void white(n) => log('\x1B[37m$n\x1B[0m');
  static void orangeBG(n) => log('\x1B[40m$n\x1B[0m');
  static void orangeItalic(n) => log('\x1B[3m$n\x1B[0m');
  static void orangeUnderLine(n) => log('\x1B[4m$n\x1B[0m');
  static void orangeBlink(n) => log('\x1B[5m$n\x1B[0m');
  static void orangeBlinkFast(n) => log('\x1B[6m$n\x1B[0m');
}
