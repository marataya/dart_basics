abstract class Animal {
  bool isAlive = true;

  void eat();

  void move();

  @override
  String toString() {
    return "I'm $runtimeType";
  }
}

abstract class Bird {
  void fly();

  void layEggs();
}

class Platypus extends Animal with EggLayer, Flyer {
  double weight;

  @override
  void eat() {
    print('munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }

  @override
  int compareTo(other) {
    // TODO: implement compareTo
    var diff = this.weight - other.weight;
    int result;
    if (diff < 0) {
      result = -1;
    } else if (diff == 0) {
      result = 0;
    } else {
      result = 1;
    }
    return result;
  }

  Platypus(this.weight);

}

class Robin extends Bird with EggLayer, Flyer {}

mixin EggLayer {
  void layEggs() {
    print('plop plop');
  }
}

mixin Flyer {
  void fly() {
    print('Swoosh swoosh');
  }
}

class Calculator with Adder {}

mixin Adder {
  void sum(int a, int b) {
    print(a + b);
  }
}

void main() {
  final platypus1 = Platypus(15.0);
  final platypus2 = Platypus(17.0);
  var list = <Platypus>[];
  list.add(platypus1);
  list.add(platypus2);
  print(list);
  final robin = Robin();
  platypus1.eat();
  platypus1.layEggs();
  platypus1.fly();
  robin.fly();
  robin.layEggs();

  final calc = Calculator();
  calc.sum(4, 7);
}
