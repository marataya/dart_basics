void main() async {
  final result = await getNames().asyncMap((name) => extractCharacters(name))
      .fold('', (prev, curr) => '$prev ${curr.join(' ')}');
  print(result.substring(1));
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Steve';

}

Future<List<String>> extractCharacters(String from) async {
  final characters = <String>[];
  for(final character in from.split('')){
    await Future.delayed(Duration(milliseconds: 100));
    characters.add(character);
  }
  return characters;
}