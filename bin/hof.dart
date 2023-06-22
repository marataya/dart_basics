final animals = {
  'sheep': 99,
  'goats': 32,
  'snakes': 7,
  'lions': 80,
  'seals': 18,
};


void main() {
  final a = <int>[1, 2, 3, 7, 8, 55];
  var count = 0;
  animals.forEach((key, value) {
    if(key.startsWith('s')) count+=value;
  });

  print(count);

}