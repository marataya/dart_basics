import 'dart:async';
import 'dart:io';

void main() async {
  var a = <int>[1, 2, 3];
  var b = <int>[4, 5, 6];
  var c = a;
  await for (final el in streamA().transform(Transformer())) {
    print(el);
  }
  ;
}

Stream<int> streamA() {
  return Stream.fromIterable(Iterable.generate(100, (value) => value * 2));
}

class Transformer extends StreamTransformerBase<int, int> {
  @override
  Stream<int> bind(Stream<int> stream) async* {
    await for(final data in stream) {
      await Future.delayed(Duration(milliseconds: 500));
      yield data;
    }
  }
}
