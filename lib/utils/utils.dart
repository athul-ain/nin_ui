import 'dart:developer';

void errorLog(String message, {String? name}) {
  log(
    redString(message),
    name: redString(name ?? 'errorLog'),
    time: DateTime.now(),
  );
}

// magenta string
String magentaString(String name) {
  return '\x1B[35m$name\x1B[0m';
}

// red string
String redString(String name) {
  return '\x1B[31m$name\x1B[0m';
}

// green string
String greenString(String name) {
  return '\x1B[32m$name\x1B[0m';
}

// blue string
String blueString(String name) {
  return '\x1B[34m$name\x1B[0m';
}

// cyan string
String cyanString(String name) {
  return '\x1B[36m$name\x1B[0m';
}

// white string
String whiteString(String name) {
  return '\x1B[37m$name\x1B[0m';
}

// black string
String blackString(String name) {
  return '\x1B[30m$name\x1B[0m';
}
