class Failure implements Exception {
  final message;
  final _prefix;
  
  Failure([this.message, this._prefix]);

  @override
  String toString() {
    return '$message:$_prefix';
  }
}