import 'dart:math';

/// Example of running in parallel functions using the [Future.wait] syntax,
/// returning output once all tasks finish

void main() {
  runMe();
}

void runMe() async {
  final operation1 = getRandomIntAsync(2);
  final operation2 = getRandomIntAsync(4);

  final List<int> results = await Future.wait([
    operation1,
    operation2,
  ]);

  print('completed: ${results[0]}');
  print('completed: ${results[1]}');
}

final rng = Random();

Future<int> getRandomIntAsync([int? exact]) async {
  final number = exact ?? rng.nextInt(5);
  print('start func -> number: $number');
  await Future.delayed(Duration(seconds: number));
  return number;
}
