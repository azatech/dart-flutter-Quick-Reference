import 'dart:async';
import 'dart:math';

/// Example of running in parallel functions using the [Completer] syntax,
/// returning as each operation completes

void main() {
  runMe();
}

/// TODO: Return from func [runMe] one by one events

void runMe() async {
  final operation1 = getRandomIntAsync(2);
  final operation2 = getRandomIntAsync(4);

  /// Use Completer to handle results as they complete
  final completer1 = Completer<int>();
  final completer2 = Completer<int>();

  /// Listen for completion of each operation
  operation1.then((value) {
    print('completed: $value');
    completer1.complete(value);
  });

  operation2.then((value) {
    print('completed: $value');
    completer2.complete(value);
  });

  /// Wait for both operations to complete
  await Future.wait([completer1.future, completer2.future]);
}

final rng = Random();

Future<int> getRandomIntAsync([int? exact]) async {
  final number = exact ?? rng.nextInt(5);
  print('start func -> number: $number');
  await Future.delayed(Duration(seconds: number));
  return number;
}
