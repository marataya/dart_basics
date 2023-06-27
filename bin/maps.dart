void main() {
Map<String, int> map = {'one': 1, 'two': 2, 'three': 3};
  Map<String, String> newMap = map.map((key, value) {
    return MapEntry<String, String>(key, '$key!');
  });
  print(newMap);
}