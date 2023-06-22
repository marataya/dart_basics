import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

Stream<List<int>> outputLargeFile() {
  final file = File('assets/long_text.txt');
  final stream = file.openRead();
  return stream;
}

void write1000LinesOfLorem() {
  final file = File('assets/long_text.txt');
  final stream = file.openWrite();
  for (int i = 0; i < 1000; i++) {
    stream.write(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n');
  }
}

Future<void> streamFromFutures() async {
  final first = Future(() => 'Row');
  final second = Future(() => 'row');
  final third = Future(() => 'row');
  final fourth = Future.delayed(
    Duration(milliseconds: 300),
    () => 'your boat',
  );
  final stream = Stream<String>.fromFutures([
    first,
    second,
    third,
    fourth,
  ]);
  stream.listen((data) {
    print(data);
  });
}

Stream<String> consciousness() async* {
  final data = ['con', 'scious', 'ness'];
  for (final part in data) {
    await Future<void>.delayed(Duration(milliseconds: 500));
    yield part;
  }
}

Stream<int> numbers() async* {
  int counter = 0;
  while (true) {
    int number = Random().nextInt(100);
    await Future<void>.delayed(Duration(milliseconds: 100));
    yield number;
    counter++;
    if (counter == 10) break;
  }
}

Stream<int> numbers1() {
  return Stream.fromIterable([5, 56, 56, 56, 56, 7,8, 9, 11, 5, 5, 7, 8, 9, 11]);
}

Future<void> main() async {
  // write1000LinesOfLorem();
  // print('A');
  // final stream = outputLargeFile();
  // stream.transform(utf8.decoder).listen((data) {
  //   print(data);
  // },
  // onDone: () => print('Done'));

  await streamFromFutures();

  // consciousness().listen((data) {
  //   print(data);
  // },
  // );

  // numbers().listen((data) {
  //   print(data);
  // });
  numbers1().distinct().listen((data) {
    print(data);
  });
}
