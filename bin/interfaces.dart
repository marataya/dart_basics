abstract class DataRepository {
  double? fetchTemperature(String city);

  factory DataRepository() => FakeWebServer();
}

class FakeWebServer implements DataRepository {
  @override
  double? fetchTemperature(String city) {
    // TODO: implement fetchTemperature
    return 42.0;
  }
}

abstract class Bottle {

  void open();

  factory Bottle() => SodaBottle();
}

class SodaBottle implements Bottle {
  @override
  void open() {
    print('Fizz fizz');
  }

}

void main() {
  final repository = DataRepository();
  print(repository.fetchTemperature("Manila"));

  var sb = SodaBottle();
  sb.open();
}
