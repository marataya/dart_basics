enum TrafficLight {
  green('Go!'),
  yellow('Slow down!'),
  red('Stop!');

  const TrafficLight(this.message);

  final String message;
}

class Point {
  const Point(this.x, this.y);

  final double x;
  final double y;

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }
}

enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  Day operator +(int days) {
    return Day.values[(this.index + days) % Day.values.length];
  }

  String get displayName => name[0].toUpperCase() + name.substring(1);
}

abstract class Serializable {
  String serialize();
}

enum Weather implements Serializable {
  sunny,
  cloudy,
  rainy;

  @override
  String serialize() => name;

  static Weather deserialize(String value) {
    return values.firstWhere((element) => element.name == value,
        orElse: () => Weather.sunny);
  }
}

enum Fruit with Describer {
  cherry,
  peach,
  banana,
}

enum Vegetable with Describer {
  carrot,
  broccoli,
  spinach,
}

mixin Describer on Enum {
  void describe() {
    print('This $runtimeType is a $name.');
  }
}

enum Default<T> {
  font<String>('roboto'),
  size<double>(17.0),
  weight<int>(400);


  const Default(this.value);
  final T value;
}

void main() {
  final color = TrafficLight.green;
  print(color.message);

  const pointA = Point(1, 4);
  const pointB = Point(3, 2);

  print(pointA + pointB);

  final restDay = Day.saturday;
  print(restDay + 1);

  final weather = Weather.cloudy;
  print(weather.serialize());

  final fruit = Fruit.banana;
  fruit.describe();
  final vegetable = Vegetable.broccoli;
  vegetable.describe();

  print(Day.sunday.displayName);
}
