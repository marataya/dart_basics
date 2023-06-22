import 'dart:async';

Stream<R> pipe<T, R>(Stream<T> sourceStream, StreamTransformer<T, R> transformer) {
  StreamController<R> controller = StreamController<R>();

  sourceStream.transform(transformer).listen(
        (event) {
      controller.add(event);
    },
    onError: (error) {
      controller.addError(error);
    },
    onDone: () {
      controller.close();
    },
  );

  return controller.stream;
}

// Example usage
void main() {
  Stream<int> sourceStream = Stream.periodic(Duration(milliseconds: 500), (value) => value).take(10);
  StreamTransformer<int, String> transformer = StreamTransformer.fromHandlers(
    handleData: (int value, EventSink<String> sink) {
      sink.add('Transformed: $value');
    },
  );

  Stream<String> transformedStream = pipe(sourceStream, transformer);

  transformedStream.listen((value) {
    print(value);
  });
}
