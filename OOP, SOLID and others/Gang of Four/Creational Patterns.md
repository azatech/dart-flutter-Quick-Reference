## Design patterns 
are established, reusable solutions for frequent programming challenges. 
They came about from the realization that many issues developers encounter are recurrent and can be addressed with tried-and-true techniques. 
These patterns are generally divided into three main types: 
- Creational, which handles object creation; 
- Structural, which pertains to the composition of classes or objects; 
- Behavioral, which deals with the interaction and responsibilities of objects.
Each type targets specific areas of software design, helping to structure code in a more reliable and scalable way.
  
### Singleton 
Singletons are useful for controlling access to a single resource. Common examples include:

**Configuration Management**: Global settings for the application.
**Database Connection Pools**: Centralized management of database connections.
**Logging**: A universally accessible logging service.
**State Management**: Maintaining application-wide states, like user sessions.
```
class GlobalSettings {
  static GlobalSettings _singleton = GlobalSettings._privateConstructor();
  GlobalSettings._privateConstructor();
  factory GlobalSettings() => _singleton;

  String applicationName = 'My Flutter Application';
  String applicationVersion = '1.0.0';
  // Additional settings...
}
```

#### Pitfalls
**Excessive Utilization**: There's a risk of overusing the Singleton pattern, as it might seem convenient to designate numerous components as singletons unnecessarily.
**Obstacles in Unit Testing**: Singleton instances can pose challenges in unit testing because of their inherent nature, making it tough to mock them effectively. This can result in difficulties when testing components that rely on singletons.
**Potential Misinterpretation**: There's a possibility of misinterpreting a singleton as a factory pattern, particularly when adjustments are made to accommodate parameters in the getInstance method.

Testing Singleton:
Testing a Singleton in Flutter poses challenges due to its global state, often making it impractical to reset between tests. 
Nonetheless, enhancing the testability of the Singleton pattern is feasible by designing it with testing considerations in mind, such as permitting dependency injection or employing a resettable singleton specifically for testing purposes. 
```
  // Method to reset the singleton, beneficial for tests
  @visibleForTesting
  static void reset() => _singleton = GlobalSettings._privateConstructor();
 
  // Testing process 
  void main() {
  // This setup runs before each test to reset the singleton
  setUp(() {
    AppConfig.reset();
  });
  // ...
}
```

### Factory Method
Factory Method provides valuable approach to object creation, especially when the exact type of object to be created is determined dynamically at runtime or by subclasses. This pattern proves advantageous in situations where the creation of various objects depends on specific conditions, such as the platform on which the application operates.
When to Use
The Factory Method pattern is particularly suitable for the following scenarios:

**Platform-Specific Implementations**: Generating different objects tailored to distinct platforms like iOS, Android, or Web.
**Dynamic Creation**: When the type of object needs to be determined dynamically at runtime based on specific conditions.
**Decoupling Object Creation**: Separating the logic of object creation from its usage, thereby fostering modular and maintainable code.
```
abstract class ButtonFactory {
  Widget createButton();
}

class IOSButtonFactory extends ButtonFactory {
  @override
  Widget createButton() {
    return CupertinoButton(
      child: Text('iOS Button'),
      onPressed: () {},
    );
  }
}

class AndroidButtonFactory extends ButtonFactory {
  @override
  Widget createButton() {
    return ElevatedButton(
      child: Text('Android Button'),
      onPressed: () {},
    );
  }
}

class WebButtonFactory extends ButtonFactory {
  @override
  Widget createButton() {
    return TextButton(
      child: Text('Web Button'),
      onPressed: () {},
    );
  }
}
```
#### Pitfalls
**Complexity**: Introducing a Factory Method might add unnecessary complexity to the codebase, especially in cases where a simpler solution suffices.
**Misapplication**: Incorrect implementation of this pattern is common, particularly when determining where the creation logic should reside, especially in subclasses.
**Design Inflexibility**: It necessitates careful upfront design and must seamlessly integrate into an existing codebase to avoid introducing rigidity.

Testing Factory Method:
```
void main() {
  test('IOSButtonFactory should create a CupertinoButton', () {
    ButtonFactory factory = IOSButtonFactory();
    final widget = factory.createButton();
    expect(widget, isA<CupertinoButton>());
  });

  test('AndroidButtonFactory should create an ElevatedButton', () {
    ButtonFactory factory = AndroidButtonFactory();
    final widget = factory.createButton();
    expect(widget, isA<ElevatedButton>());
  });

  test('WebButtonFactory should create a TextButton', () {
    ButtonFactory factory = WebButtonFactory();
    final widget = factory.createButton();
    expect(widget, isA<TextButton>());
  });
}
```