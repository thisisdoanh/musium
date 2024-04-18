part of console_logger;

abstract class LogPrinter {
  Future<void> init() async {}

  List<String> log(LogEvent event);

  Future<void> destroy() async {}
}
