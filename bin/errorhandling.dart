void main() {
  final numbers = ['3', '1E+8', '1.25', 'four', '-0.01', 'NaN', 'Infinity'];
  try {
    print(numbers.map((e) => double.parse(e)));
  } on FormatException {
    print('Format Exception');
  }
}

void functionOne() {
  functionTwo();
}

void functionTwo() {
  functionThree();
}

void functionThree() {
  int.parse('asdf');
}
