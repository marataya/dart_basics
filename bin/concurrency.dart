void main() {
  print('1 sync');
  Future(() => print('2 EQ')).then((value) => print('3 sync'));
  Future.microtask(() => print('4 MTQ'));
  Future.microtask(() => print('5 MTQ'));
  Future.delayed(Duration(seconds: 1),() => print('6 EQ'));
  Future(() => print('7 EQ')).then((value) => Future(() => print('8 EQ')));
  Future(() => print('9 EQ')).then((value) => Future.microtask(() => print('10 MTQ')));
  print('11 sync');
}