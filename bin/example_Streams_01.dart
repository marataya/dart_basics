Stream<int> firstStream() {
  return Stream.fromIterable([1, 2, 3]);
}

Stream<int> secondStream() {
  return Stream.fromIterable([4, 5, 6]);
}


void main() async {
  firstStream().listen(print, onDone: () => secondStream().listen(print));
}