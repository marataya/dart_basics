import 'dart:io';
import 'dart:isolate';

Future<void> _entryPoint(SendPort sendPortOnMars) async {
  final receiveOnMarsPort = ReceivePort();
  sendPortOnMars.send(receiveOnMarsPort.sendPort);

  final work = Work();

  receiveOnMarsPort.listen((messageFromEarth) async {
    await Future.delayed(const Duration(seconds: 1));
    print('Message from Earth: $messageFromEarth');
    if(messageFromEarth == 'Hey from Earth') {
      sendPortOnMars.send('Hey from Mars');
    } else if (messageFromEarth == 'Can you help?') {
      sendPortOnMars.send('Sure');
    } else if (messageFromEarth == 'doSomething') {
      final result = await work.doSomething();
      sendPortOnMars.send({
        'method': 'doSemothing',
        'result': result,
      });
    } else if (messageFromEarth == 'doSomethingElse') {
      final result = await work.doSomethingElse();
      sendPortOnMars.send({
        'method': 'doSemothingElse',
        'result': result,
      });
      sendPortOnMars.send('done');
    }
  });
}

class Earth {
  final _receiveOnEarthPort = ReceivePort();
  SendPort? _sendPortOnEarth;
  Isolate? _marsIsolate;

  Future<void> contactMars() async {
    if(_marsIsolate != null) return;
    _marsIsolate = await Isolate.spawn(_entryPoint, _receiveOnEarthPort.sendPort);

    _receiveOnEarthPort.listen((messageFromMars) async {
      await Future.delayed(const Duration(seconds: 1));
      print('Message from Mars: $messageFromMars');
      if(messageFromMars is SendPort) {
        _sendPortOnEarth = messageFromMars;
        _sendPortOnEarth?.send('Hey from Earth');
      } else if (messageFromMars == 'Hey from Mars') {
        _sendPortOnEarth?.send('Can you help?');
      } else if (messageFromMars == 'Sure') {
        _sendPortOnEarth?.send('doSomething');
        _sendPortOnEarth?.send('doSomethingElse');
      } else if (messageFromMars is Map) {
        final method = messageFromMars['method'];
        final result = messageFromMars['result'];
        print('The result of $method is $result');
      } else if(messageFromMars == 'done') {
        print('shutting down');
        dispose();
      }
    });
  }


  void dispose() {
    _receiveOnEarthPort.close();
    _marsIsolate?.kill();
    _marsIsolate = null;
  }
}

class Work {
  Future<int> doSomething() async {
    print('doing some work...');
    sleep(Duration(seconds: 1));
    return 42;
  }

  Future<int> doSomethingElse() async {
    print('doing some other work...');
    sleep(Duration(seconds: 1));
    return 24;
  }
}

Future<void> twoWayCommunication() async {
  final earth = Earth();
  await earth.contactMars();
}


void main() async {
  await twoWayCommunication();
}
