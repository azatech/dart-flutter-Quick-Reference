## Design patterns

are established, reusable solutions for frequent programming challenges.
They came about from the realization that many issues developers encounter are recurrent and can be
addressed with tried-and-true techniques.
These patterns are generally divided into three main types:

- Creational, which handles object creation;
- Structural, which pertains to the composition of classes or objects;
- Behavioral, which deals with the interaction and responsibilities of objects.
  Each type targets specific areas of software design, helping to structure code in a more reliable
  and scalable way.

#### Behavioral Patterns

Behavioral Patterns focus on communication and interaction between objects, unlike structural
patterns that deal with object composition.
They define how objects and classes interact and manage control flow, suitable for managing
algorithms, relationships, and state-dependent behavior. These patterns encapsulate complex control
logic, making it easier to understand, maintain, and extend.

### Command

The Command Design Pattern in Flutter encapsulates actions or requests as objects, enabling flexible
operations like executing and undoing commands.
This pattern is ideal for applications with complex user interactions and features such as undo
functionality.

**Action Encapsulation**: Wraps each action or request into an object, enabling dynamic handling of
operations.
**Decoupling**: Separates the command issuers from the executors, improving modularity.
**Undo and Redo**: Facilitates undo and redo functionalities by maintaining a history of commands,
essential for user interfaces.
**Flexibility and Scalability**: Allows for easy extension and addition of new commands without
modifying existing code.

```
abstract interface class Command {
  void execute();
  String getTitle();
  void undo();
}

class CommandHistory {
  final _commandList = ListQueue<Command>();

  bool get isEmpty => _commandList.isEmpty;
  List<String> get commandHistoryList =>
      _commandList.map((c) => c.getTitle()).toList();

  void add(Command command) => _commandList.add(command);

  void undo() {
    if (_commandList.isEmpty) return;

    _commandList.removeLast().undo();
  }
}

class ChangeColorCommand implements Command {
  ChangeColorCommand(this.shape) : previousColor = shape.color;

  final Color previousColor;
  Shape shape;

  @override
  String getTitle() => 'Change color';

  @override
  void execute() => shape.color = Color.fromRGBO(
        random.integer(255),
        random.integer(255),
        random.integer(255),
        1.0,
      );

  @override
  void undo() => shape.color = previousColor;
}

class CommandManager {
  final _commandList = ListQueue<Command>();
  bool get hasHistory => commandHistoryList.isNotEmpty;
  List<String> get commandHistoryList =>
      _commandList.map((c) => c.name).toList();
  void executeCommand(Command command) =>
      _commandList.add(command);
  void undo() {
    if (_commandList.isEmpty) return;
    _commandList.removeLast().undo();
  }
}
```

#### Pitfalls

**Complexity**: Tracking a history of commands can be intricate, particularly in large applications
with numerous actions.
**Resource Management**: Keeping a command history may use substantial memory, depending on the
commands' nature.
**State Consistency**: Maintaining a consistent application state during undo and redo operations
can be difficult.

### Observer

The Observer Design Pattern creates a one-to-many relationship between objects.
This allows a subject to inform multiple observers about its state changes.
This pattern is especially common in reactive programming in Flutter, where it is used to handle
streams and dynamic data updates.

**Reactive Programming**: This pattern is fundamental to reactive programming, allowing systems to
respond dynamically to environmental or state changes.
**Subject-Observer Decoupling**: By separating the subject from its observers, the pattern promotes
a modular and adaptable architecture.
**Dynamic Subscriptions**: Observers can subscribe or unsubscribe from the subject dynamically,
enabling flexible interaction models.
**Broadcast Updates**: When the subject's state changes, it notifies all observers, ensuring they
receive synchronized updates.

```
class Notification {
  String message;
  DateTime timestamp;
  Notification(this.message, this.timestamp);
  Notification.forNow(this.message) {
    timestamp = new DateTime.now();
  }
}

class Observable {
  List<Observer> _observers;

  Observable([List<Observer> observers]) {
    _observers = observers ?? [];
  }

  void registerObserver(Observer observer) {
    _observers.add(observer);
  }

  void notify_observers(Notification notification) {
    for (var observer in _observers) {
      observer.notify(notification);
    }
  }
}

class Observer {
  String name;
  
  Observer(this.name);

  void notify(Notification notification) {
    print("[${notification.timestamp.toIso8601String()}] Hey $name, ${notification.message}!");
  }
}

class CoffeeMaker extends Observable {
  CoffeeMaker([List<Observer> observers]) : super(observers);
  void brew() {
    print("Brewing the coffee...");
    notify_observers(Notification.forNow("coffee's done"));
  }
}
```

```
void main() {
  var me = Observer("Tyler");
  var mrCoffee = CoffeeMaker(List.from([me]));
  var myWife = Observer("Kate");
  mrCoffee.registerObserver(myWife);
  mrCoffee.brew();
  /*
    Brewing the coffee...
    [2019-06-18T07:30:04.397518] Hey Tyler, coffee's done!
    [2019-06-18T07:30:04.397518] Hey Kate, coffee's done!
  */
}
```

- Implementation in Flutter

```
class CounterObserver with ChangeNotifier { 
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners(); //<---
  }
}
```

#### Pitfalls

**Excessive Notifications**: The subject may alert observers more frequently than needed,
potentially causing performance problems.
**Complexity**: Handling numerous observers or complex update logic can become challenging.
**Debugging Difficulties**: The indirect communication makes troubleshooting notification-related
issues difficult.

### Strategy

The Strategy Design Pattern is beneficial for dynamically choosing algorithms or processes at
runtime.
It removes the need for conditional statements by encapsulating algorithm strategies in separate
classes, resulting in more flexible and maintainable code.

**Runtime Algorithm Selection**: The Strategy pattern allows for the selection of different
algorithms or strategies during runtime, minimizing the use of conditional logic.
**Separation of Strategy and Context**: It separates the implementation details of an algorithm from
the code that uses it, making the system easier to extend and maintain.
**Interface or Abstract Class Design**: Strategies follow a common interface or abstract class,
ensuring all concrete implementations have a consistent structure.
**Client Knowledge**: Clients are aware of the available strategies and can choose the appropriate
one, enabling dynamic strategy switching.

```
abstract class CoffeeStrategy {
  String announce(String roast);
}

class AmericanoStrategy implements CoffeeStrategy {
  String announce(String roast) => "an Americano with $roast beans";
}

class DripStrategy implements CoffeeStrategy {
  String announce(String roast) => "a drip coffee with $roast beans";
}

class MochaFrappuccinoStrategy implements CoffeeStrategy {
  String announce(String roast) =>
      "a delicious mocha frappuccion with $roast beans";
}

class CoffeeDrinker {
  CoffeeStrategy preferredDrink;
  String name;

  CoffeeDrinker(this.name, this.preferredDrink);
}
```

```
void main() {
var americano = AmericanoStrategy();
var drip = DripStrategy();
var mocha = MochaFrappuccinoStrategy();

var me = CoffeeDrinker("Tyler", drip);
var europeanBuddy = CoffeeDrinker("Pieter", americano);
var myDaughter = CoffeeDrinker("Joanie", mocha);

final String roastOfTheDay = "Italian";

for (var person in [me, europeanBuddy, myDaughter]) {
  print("Hey ${person.name}, whatcha drinkin' over there?");
  print("I'm enjoying ${person.preferredDrink.announce(roastOfTheDay)}!\r\n");
}

/*
  Hey Tyler, whatcha drinkin' over there?
  I'm enjoying a drip coffee with Italian beans!

  Hey Pieter, whatcha drinkin' over there?
  I'm enjoying an Americano with Italian beans!

  Hey Joanie, whatcha drinkin' over there?
  I'm enjoying a delicious mocha frappuccion with Italian beans!
*/
}
```

#### Pitfalls

**More Classes**: Each strategy requires a separate class, which can increase the total number of
classes in the application.
**Client Knowledge**: Clients must be aware of and understand the various strategies to select the
correct one.
**Management Challenges**: Managing and coordinating multiple strategies can become complicated in
larger applications.

## Template Method

The Template Method Design Pattern is great for promoting code reuse in frameworks and libraries.
This pattern is vital in object-oriented programming, especially in Inversion of Control (IoC)
frameworks.
It defines an algorithm's structure in an abstract class, letting subclasses implement specific
steps without altering the overall algorithm.

**Algorithm Structure**: The template method pattern revolves around an abstract base class that
outlines the algorithm's steps, which subclasses can then customize.
**Hooks and Operations**: Optional steps, called hooks, can be overridden, while essential steps,
known as operations, must be implemented by subclasses.
**Class-Based Approach**: This pattern operates on a class hierarchy, where the base class controls
the algorithm's flow and concrete classes implement specific parts of it.
**Compile-Time Algorithm Selection**: The template method defines the algorithm at compile time,
making it suitable for situations where the algorithm's structure is fixed and only certain parts
vary in execution.

```
abstract class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle())),
      body: buildBody(context),
    );
  }
  String appBarTitle();
  Widget buildBody(BuildContext context);
}

class ConcreteWidget extends BaseWidget {
  const ConcreteWidget({super.key});
  @override
  String appBarTitle() => 'Concrete Widget';
  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text('Concrete implementation of buildBody.'),
    );
  }
}
```

#### Pitfalls

**Complex Class Hierarchy**: Using the template method can result in a complex class hierarchy that
may be difficult to understand.
**Limited Flexibility**: The algorithm's structure is predetermined in the base class, which can
restrict flexibility in certain scenarios.
**Design Overhead**: Implementing the template method requires careful planning to identify which
parts of the algorithm should be customizable, adding design complexity.

