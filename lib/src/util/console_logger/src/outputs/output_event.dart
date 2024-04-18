part of console_logger;

class OutputEvent {
  final List<String> lines;
  final LogEvent origin;

  LogLevel get level => origin.level;

  OutputEvent(this.origin, this.lines);
}
