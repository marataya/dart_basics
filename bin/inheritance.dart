enum Grade {A, B, C, D, E, F}

class Person {

  Person(this.givenName, this.surname);

  String givenName;
  String surname;

  String get fullName => '$givenName $surname';

  @override
  String toString() => fullName;
}

class Student extends Person {


  Student(super.givenName, super.surname);

  var grades = <Grade>[];

  @override
  String toString() {
    return 'Student $fullName: {grades: $grades}';
  }
}


void main() {
  final jon = Person('Jon', 'Snow');
  final jane = Student('Jane', 'Snow');
  print(jon);
  print(jane);
  print(jane.grades);
  final historyGrade = Grade.B;
  jane.grades.add(historyGrade);
  print(jane.grades);
  var list = [1, 2, 3, 4, 5];
  list.forEach((element) => print(element+1));
}
