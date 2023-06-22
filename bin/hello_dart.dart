import 'dart:math';

class Bicycle {
  int cadence;
  int _speed = 0;

  int get speed => _speed;
  int gear;

  Bicycle(this.cadence, this._speed, this.gear);

  @override
  String toString() => 'Bicycle $speed mph';

  void applyBreaks(int decrement) {
    _speed -= decrement;
  }

  void speedUp(int increment) {
    _speed += increment;
  }
}

class Rectangle {
  int? width;
  int? height;
  Point origin;

  Rectangle({this.origin = const Point(0, 0), this.width = 0, this.height = 0});

  @override
  String toString() {
    return 'Origin: (${origin.x}, ${origin.y}) width: $width, height: $height';
  }
}

abstract class Shape {
  num get area;
}

class Circle implements Shape {
  final num radius;

  Circle(this.radius);

  num get area => pi * pow(radius, 2);
}

class Square implements Shape {
  final num side;
  Square(this.side);
  num get area => pow(side, 2);

}

Shape shapeFactory(String type) {
  if (type == 'circle') return Circle(2);
  if (type == 'square') return Square(2);
  throw 'Can\'t create ${type}';
}

class circleMock implements Circle {
  num area = 0;
  num radius = 0;
}

String fullName(String first, String last, [String? title]) {
  if (title == null) {
    return '$first $last';
  } else {
    return '$title $first $last';
  }
}


bool withinTolerance({required int value, int min=0, int max=10}) {
  return min <= value && value <= max;
}

void main() {
  final circle = shapeFactory('circle');
  final square = shapeFactory('square');
  print(circle.area);
  print(square.area);
  print((1/3).toStringAsFixed(3));
  print('I love \u{1F3AE}');

  final random = Random();
  while (random.nextInt(6) + 1 != 6) {
    print('Not a 6');
  }
  print('Finally a 6');

  print(fullName('Albert', 'Einstein', 'Professor'));

  print(withinTolerance(value: 45));
}
