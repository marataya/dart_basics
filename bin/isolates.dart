import 'dart:isolate';

import 'package:compute/compute.dart';

void playHideAndSeek(List<Object> args) {
  final sendPort = args[0] as SendPort;
  final countTo = args[1] as int;
  sendPort.send('Starting counting...');
  var counting = 0;
  for (var i = 1; i < countTo; i++) {
    counting = i;
  }
  sendPort.send('$counting, message from the Isolate');
  sendPort.send(null);
}

Future<String> computeFunction(String msg) {
  // Function doing long running work
  return Future.delayed(const Duration(seconds: 3), () => msg);
}

int fibonacci(int n) {
  if (n <= 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n-1) + fibonacci(n-2);
}


Future<void> main() async {
  final receivePort = ReceivePort();

  final isolate = await Isolate.spawn(playHideAndSeek, [receivePort.sendPort, 1000000000]);

  receivePort.listen((Object? message) {
    if(message is String) {
      print(message);
    } else if (message == null) {
      receivePort.close();
      isolate.kill();
    }
  });



  final message1 = await compute(computeFunction, 'Hello from computeFunction');
  print(message1);

  int resultOfFibo = await compute(fibonacci, 40);
  print('Fibonacci result: $resultOfFibo');
}