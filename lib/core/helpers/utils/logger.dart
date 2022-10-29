import 'dart:developer' as dev;

enum Logger {
  Black("30"),
  Red("31"),
  Green("32"),
  Yellow("33"),
  Blue("34"),
  Magenta("35"),
  Cyan("36"),
  White("37");

  final String code;
  const Logger(this.code);

  void log(
    dynamic text, {
    String name = '',
    Object? error,
  }) =>
      dev.log(
        '\x1B[${code}m$text\x1B[0m',
        name: name,
        error: error,
      );
}



// class Logger {
//   final Object obj;
//   final String? heading;
//   final dynamic data;

//   final String message;

//   Logger(this.obj, this.heading, this.data)
//       : message = heading != null ? "($heading) $data" : data;

//   void warning() {
//     log(
//       message,
//       name: obj.runtimeType.toString(),
//     );
//   }

//   void error() {
//     log(
//       "",
//       error: message,
//       name: obj.runtimeType.toString(),
//     );
//   }
// }
