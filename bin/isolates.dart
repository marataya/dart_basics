import 'dart:isolate';

import 'package:compute/compute.dart';

void playHideAndSeek(SendPort sendPort) {
  var counting = 0;
  for (var i = 1; i < 1000000000; i++) {
    counting = i;
  }
  final message = '$counting, message from the Isolate';
  Isolate.exit(sendPort, message);
}

Future<void> main() async {
  final receivePort = ReceivePort();

  Isolate.spawn(playHideAndSeek, receivePort.sendPort);
  final message = await receivePort.first;
  print(message);

  Future<String> computeFunction() {
    // Function doing long running work
    return Future.delayed(const Duration(seconds: 3), () => 'Hello from computeFunction');
  }

  final message1 = await compute(computeFunction);

}