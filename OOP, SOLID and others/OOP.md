### OOP - Princilpes

"Object-oriented programming" is important because it offers a structured approach to software
development, promotes code reuse, and enhances code organization.

## Inheritance

Inheritance is a foundational concept in object-oriented programming that Dart utilizes to promote
code reuse, readability, and the establishment of hierarchical structures within software systems.
In Dart, inheritance is facilitated using the 'extends' keyword, allowing subclasses to derive
properties and methods from superclasses.
Dart supports single inheritance but also permits multilevel inheritance, enabling classes to
inherit from superclasses that are themselves subclasses.

This creates a chain of inheritance leading back to the Object class, the root of all Dart classes.

```
abstract class RenderObject {..}
abstract class RenderBox extends RenderObject {..}
class RenderFlex extends RenderBox {..}
```

'covariant' keyword:

```
class Flex extends MultiChildRenderObjectWidget {
  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderFlex renderObject, <--
    ) {
       ...
    }
}
```

In this context, the covariant keyword is utilized to specify a more specific parameter type in the
overridden method.
In Dart, the covariant keyword empowers a subclass to declare a parameter type that offers greater
precision than that of its superclass.
This feature significantly enhances the accuracy and type safety of overridden methods.

Let's explore how Flutter handles inheritance and the 'covariant' keyword in widget gestures,
focusing on DraggableWidget and TapWidget as examples.

```
abstract class Animal {
  void chase(Animal x);
}

class Mouse extends Animal {
  @override
  void chase(Animal x) { ... }
}

class Cat extends Animal {
  @override
  void chase(covariant Mouse x) {
    /// chase only [Mouse] <--
  }
}
```

Let's dive into another simple example of covariant below:

```
abstract class AudioPlayable {}

class AudioMp3Playable extends AudioPlayable {}

class AudioWavPlayable extends AudioPlayable {}

abstract class PlayableInterface {
  void play(covariant AudioPlayable audio);
}

class PlayableMp3Impl extends PlayableInterface {
  @override
  void play(covariant AudioMp3Playable audio) {..}
}

class PlayableWavImpl extends PlayableInterface {
  @override
  void play(covariant AudioWavPlayable audio) {..}
}
```

By using the "covariant" keyword, you disable the type-check and take responsibility for ensuring
that you do not violate the contract in practice.

## Polymorphism

Polymorphism in object-oriented programming enables objects from various classes to be handled using
a standardized interface.
This allows methods to execute differently based on the object's class.
In Dart, polymorphism is realized by defining subclass methods with identical names and signatures
as those in the base class but with distinct implementations.
They must be marked with the "@override" annotation for clarity. Thus, we focus on an abstraction
rather than the specifics of a particular class, providing flexibility to our code.

```
abstract class Employee {
  String name;
  int salary;

  Employee(this.name, this.salary);

  void work();
}

class Developer extends Employee {
  Developer(String name, int salary) : super(name, salary);

  @override
  void work() {
    print('$name is developing code.');
  }
}

class Manager extends Employee {
  Manager(String name, int salary) : super(name, salary);

  @override
  void work() {
    print('$name is managing projects.');
  }
}

void main() {
  final List<Employee> employees = [Developer(..), Manager(..)];
  for (final employee in employees) {
    employees.work(); // Polymorphism in action
  }
}
```

## Encapsulation

Encapsulation is a fundamental concept in object-oriented programming (OOP) that involves bundling
data (attributes) and methods (behaviors) that operate on that data into a single unit called a
class.
The key idea behind encapsulation is to hide the internal state of an object and only expose the
necessary functionality through well-defined interfaces.
This helps to achieve data hiding, abstraction, and modularity in software design, enhancing code
readability, maintainability, and security.

```
class BankAccount {
  double _balance; // Encapsulated private variable
  double _interestRate;

  BankAccount(this._balance, this._interestRate);

  double get balance => _balance;
  double get interestRate => _interestRate;
  double get interestEarned => _balance * _interestRate / 100;

  /// Method to deposit money into the account
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited $amount. New balance: $_balance');
    } else {
      print('Invalid deposit amount.');
    }
  }

  /// Method to withdraw money from the account
  void withdraw(double amount) {
    if (_balance >= amount && amount > 0) {
      _balance -= amount;
      print('Withdrawn $amount. New balance: $_balance');
    } else {
      print('Insufficient funds or invalid withdrawal amount.');
    }
  }
}
```

## Abstraction

Abstraction is a core principle in programming that involves simplifying complex systems by focusing
on essential characteristics while hiding unnecessary details.
It allows developers to create models that represent real-world entities or concepts in a simplified
manner.
Abstractions provide a level of separation between the implementation details and the higher-level
functionality, promoting modularity, flexibility, and ease of maintenance in software development.

One common way to achieve abstraction in object-oriented programming is through interfaces.
An interface defines a contract specifying a set of methods that a class must implement.
By defining interfaces, developers can establish a common behavior that different classes can adhere
to, without specifying the implementation details.
This allows for polymorphism, where objects of different classes can be treated uniformly based on
their shared interface.

```
abstract class House {
  void openDoor();
  void closeDoor();
}

class WoodenHouse implements House {
  @override
  void openDoor() { ... }
  void closeDoor() { ... }
}

class BrickHouse implements House {
  @override
  void openDoor() { ... }
  void closeDoor() { ... }
}

void main() {
  var woodenHouse = WoodenHouse();
  var brickHouse = BrickHouse();

  visitHouse(woodenHouse);
  visitHouse(brickHouse);
}

// Function to visit a house and interact with its door
void visitHouse(House house) {
  house.openDoor();
  // Perform other interactions with the house...
  house.closeDoor();
}
```

The "visitHouse()" function is a clear indication that it operates based on abstraction rather than
relying on specific concrete classes.
It accepts any object that implements the "House" interface as its parameter.
By doing so, it allows for polymorphic behavior, enabling different types of houses (e.g.,
WoodenHouse, BrickHouse) to be passed into the function without needing to know their specific
types.
This demonstrates the power of abstraction, where the function can interact with objects based on
their common interface (House), regardless of their specific implementations.

### 'implements' and 'extends' are modifiers used to establish relationships between classes

'extends': It is used to create a subclass (child class) that inherits properties and methods from a
superclass (parent class).
The subclass can override methods or define new ones, but it inherits the structure and behavior of
the superclass.

'implements': It is used to declare that a class will provide specific functionality defined in an
interface.
It requires the implementing class to define all methods declared in the interface.

### 'abstract' and 'interface' modifiers

An 'abstract' class cannot be directly instantiated and typically contains abstract methods, lacking
implementation.
It acts as a blueprint for other classes, requiring them to implement the abstract methods and
follow a designated structure.
This approach enforces a contract between different classes, ensuring they offer specific
functionalities outlined by the abstract class.

```
abstract class Worker {
  void work();

  void baseWork() {
    print('base work');
  }
}
```

Let's instantiate the 'Worker'

```
class Designer extends Worker {
  @override
  void work() {
    print('work');
  }
}

void main() {
  final designer = Designer();
  designer.baseWork();
  designer.work();
}
```

What if we incorporate interface modifiers instead of abstract classes?

```
interface class Worker {
  void work(); // <-- Compile Error: 'work' must have a method body because 'Worker' isn't abstract

  void baseWork() {
    print('base work');
  }
}

class Designer extends Worker { ... } // <-- Compile Error: The class 'Worker' can't be extended outside of its library because it's an interface class
```

Let's do another modifications:

```
abstract interface class Worker { ... } // Everything is good here
```

Even with that
approach, [Compile Error: The class 'Worker' can't be extended outside of its library because it's an interface class]
persists.
However, Dart does offer the capability to create 'abstract interface' classes using

- 'part of'
- or by defining multiple classes in a single file

Combining the:

- 'abstract' modifier, which prevents class instantiation,
- with the 'interface' modifier, which prevents inheritance,
  yields a comprehensive contract. Thus, contracts in Dart code will appear exactly like this:

```
abstract interface class Contract {
 abstract final String name;
 void foo();
}
```

### 'final' modifier

Adding the final modifier resolves the "fragile base class" issue in Dart.
This provides architecture designers with more tools to safeguard their implementations against
unintended breakage due to incorrect inheritance.

```
final class Vehicle {}
// ERROR: Can't be inherited.
class Car extends Vehicle {}
```

### 'base' modifier prevents implementation

```
base class Vehicle {}
base class Car extends Vehicle {}

// ERROR: Can't be implemented.
base class MockVehicle implements Vehicle {}
```

### 'sealed' modifier

To create a known, enumerable set of subtypes, use the sealed modifier.
This allows you to create a switch over those subtypes that is statically ensured to be exhaustive.

```
sealed class Vehicle {}

class Car extends Vehicle {}

class Truck implements Vehicle {}

class Bicycle extends Vehicle {}

// ERROR: Can't be instantiated.
Vehicle myVehicle = Vehicle();

// Subclasses can be instantiated.
Vehicle myCar = Car();

String getVehicleSound(Vehicle vehicle) {
  // ERROR: The switch is missing the Bicycle subtype or a default case.
  return switch (vehicle) {
    Car() => 'vroom',
    Truck() => 'VROOOOMM',
  };
}
```

### 'mixin' modifier on classes

Mixins are a way of defining code that can be reused in multiple class hierarchies. They are
intended to provide member implementations en masse.
To use a mixin, use the with keyword followed by one or more mixin names. The following example
shows two classes that use mixins:

```
class Musician extends Performer with Musical { ... }

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```

During development, there may arise situations where the functionality of a mixin should not be
publicly accessible for inclusion by all classes.
However, there's a mechanism available that allows us to impose such restrictions.
It's the "on" keyword in the mixin declaration, together with the class name.
This way, we limit the usage of the mixin only to classes that implement or inherit from the
specified class.

```
class A {}

abstract class B {}

mixin M1 on A {}
mixin M2 on A {}
```

- Then we can declare classes like this:

```
class C extends A with M1 {}
class D extends A with M2 {}
```

- But you'll get an error if you try to declare something like this.

```
class E with M1, M2 {} // <--- Compile Error: 'M1' can't be mixed onto 'Object' because 'Object' doesn't implement 'A'
```

Fixed: In short, to use a mixin, you need to inherit functionality that the mixin subscribes to
using the "on" keyword.

```
class E extends A with M1, M2 {} // Good
```

### Dart 3.0 introduces specific mixin constraints to foster cleaner, more predictable code:

Mixin classes and mixins are both governed by identical restrictions:

- They cannot feature 'extends' or 'with' clauses.

```
mixin Mixin {}
mixin AnotherMixin on Mixin {}

mixin class MixinClass with Mixin {} // <--- Compile Error
mixin class MixinClass2 extends AnotherMixin {} // <--- Compile Error
```

- Neither classes nor mixin classes are permitted to have an 'on' clause

```
mixin class MixinClassOn on AnotherMixin {} // <--- Compile Error
```

### Main thoughts

- 'abstract' modifier prevents class instantiation

```
abstract class Vehicle {}
// Error: Can't be constructed.
Vehicle myVehicle = Vehicle();
```

- 'interface' modifier prevents class inheritance
  Use interface to prevent users from reusing your class's code while allowing them to re-implement
  its interface.

```
interface class Vehicle {}

// ERROR: Can't be inherited.
class Car extends Vehicle {
  int passengers = 4;
  // ...
}
```

- 'final' modifier prevents classes from being subclassed
  Use final to completely prevent a class from being extended.

```
final class Vehicle {}
// ERROR: Can't be inherited.
class Car extends Vehicle {}
```

- 'base' modifier prevents implementation
  Use base to require users to reuse your class's code and ensure every instance of your class's
  type is an instance of that actual class or a subclass.

```
base class Vehicle {}
base class Car extends Vehicle {}

// ERROR: Can't be implemented.
base class MockVehicle implements Vehicle {}
```

- 'sealed' allows to create a switch over those subtypes.
  Use sealed to opt in to exhaustiveness checking on a family of subtypes

```
switch (result) {
     case Result.success:
       print('success');
       break;
     case Result.loading:
       print('loading');
       break;
     case Result.error:
       print('error');
       break;
   }
```

- 'mixin' modifier
  Within Dart, mixins function as a tool for recycling code, providing greater adaptability compared
  to conventional inheritance.
  They facilitate the addition of functionalities to a class without requiring inheritance, which is
  particularly advantageous within Dart's single inheritance framework.

```
abstract class AnalyticsCollector {
  void collect(String message);
}

mixin ServiceAnalyticsCollectorMixin implements AnalyticsCollector {
  @override
  void collect(String message) { ... }
}

abstract interface class DataInterface {}

class LocalDataImpl with ServiceAnalyticsCollectorMixin implements DataInterface {
  void insert() {
    collect("insert method");
  }
}

class NetworkDataImpl with ServiceAnalyticsCollectorMixin implements DataInterface {
  void insert() {
    collect("insert method");
  }
}
```