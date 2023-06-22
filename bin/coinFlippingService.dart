//Create a coin flipping service that provides a stream of 10 random coin flips, each
// 188 Dart Apprentice: Beyond the Basics Chapter 13: Streams
// separated by 500 milliseconds. You use the service like so:
// final coinFlipper = CoinFlippingService();
// coinFlipper.onFlip.listen((coin) {
// print(coin);
// });
// coinFlipper.start();
// onFlip is the name of the stream.

import 'dart:async';
import 'dart:math';

class CoinFlippingService {
  final _coinStreamController = StreamController<String>();

  Stream<String> get onFlip => _coinStreamController.stream;

  Future<void> start() async {
    for (int i = 0; i < 10; i++) {
      _coinStreamController.add(await flipCoin());
    }
    _coinStreamController.close();

    // Future.delayed(Duration(milliseconds: 10*500), () => _coinStreamController.close());
  }

  Future<String> flipCoin() async {
    await Future<void>.delayed(Duration(milliseconds: 200));
    Random random = Random();
    bool isHeads = random.nextBool();
    return isHeads ? 'Heads' : 'Tails';
  }
}

Future<void> main() async {
  final coinFlippingService = CoinFlippingService();
  coinFlippingService.onFlip.listen((coin) {
    print(coin);
  }, onDone: () {
    print('Done');
  });
  coinFlippingService.start();
}
