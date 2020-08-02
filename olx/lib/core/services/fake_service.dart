import 'dart:async';

class FakeSerice<T> {
  Future<T> GetFuture(T value) {
    var completer = new Completer<T>();
    completer.complete(value);
    return completer.future;
  }

  Future<List<T>> GetAllFuture(List<T> value) {
    var completer = new Completer<List<T>>();
    completer.complete(value);
    return completer.future;
  }
}
