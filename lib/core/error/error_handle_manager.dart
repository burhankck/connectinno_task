import 'package:connectinno_task/core/error/error_handler.dart';

class ErrorHandlerManager {
  final List<ErrorHandler> _handlers;

  ErrorHandlerManager(this._handlers);

  Future<void> handle(Object error, StackTrace stackTrace) async {
    for (var handler in _handlers) {
      await handler.handleError(error, stackTrace);
    }
  }
}
