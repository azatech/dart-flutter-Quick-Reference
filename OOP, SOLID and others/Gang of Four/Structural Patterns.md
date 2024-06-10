## Design patterns
are established, reusable solutions for frequent programming challenges.
They came about from the realization that many issues developers encounter are recurrent and can be addressed with tried-and-true techniques.
These patterns are generally divided into three main types:
- Creational, which handles object creation;
- Structural, which pertains to the composition of classes or objects;
- Behavioral, which deals with the interaction and responsibilities of objects.
Each type targets specific areas of software design, helping to structure code in a more reliable and scalable way.

#### Structural patterns
Structural patterns play a crucial role in software design by offering strategies to streamline the design process through the identification of straightforward methods to establish relationships between entities. 
These patterns concentrate on the composition of classes and objects to construct more extensive structures. 
The primary objective is to ensure that modifications in one area of the system necessitate minimal changes elsewhere, thereby enhancing reusability and adaptability.

The decision to employ structural patterns often revolves around the requirement to assemble extensive object structures from individual components. 
These patterns prove valuable when a system needs an interface that deviates from the interfaces of its individual constituents or when integrating disparate systems with incompatible interfaces.

### Adapter
The Adapter Design Pattern proves its worth in resolving interface inconsistencies. 
Within the Flutter framework, it serves as a pivotal instrument for seamlessly integrating widgets with varying interfaces, ensuring their smooth integration into the application's design and functionality. 
This pattern becomes particularly advantageous when dealing with widgets possessing distinct interfaces or behaviors that necessitate alignment for collaborative functionality.

**Interface Alignment**: In Flutter, the Adapter pattern resolves widget interface disparities, ensuring compatibility.
**Enhanced Flexibility**: This pattern enables UI design flexibility by integrating diverse widgets without altering their core functionalities.
**Client-Centric Design**: The adapter prioritizes the integrating component (client), ensuring a cohesive and functional final UI.

In Flutter, a common scenario might involve adapting a custom widget to fit into a layout or design scheme it wasn’t originally intended for. For example, suppose widgets require a child of type Sliver. 
In that case, adapting with SliverAdapter could serve this purpose.
```
CustomScrollView(
  slivers: [
    const SliverPadding(
      padding: EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter( /// <--- Adapter
        child: ...
      ),
    ),
  ],
);
```

**Adapter Interfaces** and others
```
abstract interface class VideoPlayer {
  void play(String videoType, String fileName);
}

abstract interface class MyAppWavPlayer {
  void playWav(String fileName);
}

abstract interface class MyAppMp4Player {
  void playMp4(String fileName);
}

class MyAppVideoPlayer implements MyAppMp4Player, MyAppWavPlayer {
  @override
  void playMp4(String fileName) { ... }

  @override
  void playWav(String fileName) { ... }
}
```

**Adapter class**
```
class VideoAdapter implements VideoPlayer {
  VideoAdapter(this.myAppMediaPlayer);

  final MyAppVideoPlayer myAppMediaPlayer;

  @override
  void play(String videoType, String fileName) {
    if (videoType.toLowerCase() == 'wav') {
      myAppMediaPlayer.playWav(fileName);
    } else if (videoType.toLowerCase() == 'mp4') {
      myAppMediaPlayer.playMp4(fileName);
    }
  }
}

class AppVideoPlayer implements VideoPlayer {
  @override
  void play(String audioType, String fileName) {
    final mediaAdapter = VideoAdapter(
      MyAppVideoPlayer(),
    );
    mediaAdapter.play(audioType, fileName);
  }
}
```
```
return Column(
    children: [
      CustomWidgetMediaPlayer(
        type: 'wav',
        fileName: 'file.wav',
        adapter: AppVideoPlayer(),
      ),
      CustomWidgetMediaPlayer(
        type: 'mp4',
        fileName: 'file.mp4',
        adapter: AppVideoPlayer(),
      ),
    ],
  );
```
#### Pitfalls
**Excessive Complexity**: Employing adapters for straightforward UI adjustments may overcomplicate the widget tree unnecessarily.
**Performance Concerns**: Though typically marginal, introducing additional layers via adapters can affect performance in intricate UI scenarios.
**Risk of Misapplication**: Adapters shouldn't serve as shortcuts to bypass proper widget design and layout planning. Their principal function is integration, not remedying fundamental design issues.

Testing Adapter:
```
void main() {
  group('VideoAdapter Tests', () {
    test('Should call playWav when Wav is played', () {
      final videoPlayer = MockMyAppVideoPlayer();
      final videoAdapter = VideoAdapter(videoPlayer);
      videoAdapter.play('wav', 'video.wav');
      verify(videoPlayer.playMp3('video.wav')).called(1);
    });
    test('Should call playMp4 when MP4 is played', () {
      final videoPlayer = MockMyAppMediaPlayer();
      final videoAdapter = MediaAdapter(videoPlayer);
      videoAdapter.play('mp4', 'video.mp4');
      verify(videoPlayer.playMp4('video.mp4')).called(1);
    });
  });
}
```

### Decorator
The Decorator Design Pattern in Flutter dynamically enhances functionalities without altering their structure. 
It's ideal for adding behavior in a flexible manner, following the single responsibility principle.

Key Points:
**Enhancing Functionality**: Decorator adds behavior to objects individually, without affecting others.
**Beyond Simple Inheritance**: It uses composition alongside inheritance, complementing existing behaviors.
**Single Responsibility Principle**: Each class focuses on a specific functionality.
**Combining Inheritance and Composition**: It involves a core component with added functionalities through a mix of inheritance and composition.

```
abstract class TextEditor {
  const TextEditor();

  abstract final String text;
}

class SimpleTextEditor implements TextEditor {
  const SimpleTextEditor(this.text);

  @override
  final String text;
}

abstract class TextEditorDecorator implements TextEditor {
  const TextEditorDecorator(this.textEditor);

  final TextEditor textEditor;
}

class BoldTextDecorator extends TextEditorDecorator {
  const BoldTextDecorator(super.textEditor);

  @override
  String get text => '<b>${textEditor.text}</b>';
}

class ItalicTextDecorator extends TextEditorDecorator {
  const ItalicTextDecorator(super.textEditor);

  @override
  String get text => '<i>${textEditor.text}</i>';
}
```
```
void main() {
  TextEditor editor = const SimpleTextEditor('Hello world!');
  print(editor.text); // Output: 'Hello, World!'

  editor = BoldTextDecorator(editor);
  print(editor.text); // Output: '<b>Hello, World!</b>'

  editor = ItalicTextDecorator(editor);
  print(editor.text); // Output: '<i><b>Hello, World!</b></i>'
}
```
#### Pitfalls
**Class Proliferation**: A risk involves generating multiple small classes for each additional feature, resulting in a more intricate class hierarchy.
**Increased Complexity**: Excessive reliance on the Decorator pattern can result in a convoluted codebase, potentially challenging to manage.
**Potential Inheritance Confusion**: It's vital to differentiate between utilizing decorators for functional enhancements and straightforward inheritance. Decorators should dynamically append functionality without modifying the concrete class directly.


### Composite
Composite Design Pattern in Flutter is a structural pattern that arranges objects into tree structures to represent part-whole hierarchies. 
This pattern allows individual objects and compositions of objects to be treated uniformly, which is particularly useful in Flutter's widget-centric design.

Key Concepts:
**Uniform Component Treatment**: The Composite pattern's core idea is to handle individual objects and their compositions in the same way, using a tree structure.
**Tree-Structured Design**: Components are organized into a tree hierarchy where each node is either a 'Leaf' (individual object) or a 'Composite' (group of objects).
**Simplification with Flexibility**: The pattern simplifies structure by treating all objects uniformly, though it may lead to runtime checks for compatibility.
**Component Interface**: Both leaf and composite objects follow a common component interface, allowing consistent operations on individual elements or groups.

```
abstract class Item {
  abstract String name;

  void describe(int shift);
}

class SimpleItem implements Item {
  @override
  String name;

  SimpleItem(this.name);

  @override
  void describe(int shift) {
    print(name.padLeft(name.length + shift, '-'));
  }
}

class ItemContainer implements Item {
  @override
  String name;

  ItemContainer(this.name);

  final _items = [];

  void addItem(Item item) => _items.add(item);

  void removeItem(Item item) => _items.remove(item);

  void clear() => _items.clear();

  @override
  void describe(int shift) {
    print(name.padLeft(name.length + shift, '-'));
    for (final item in _items) {
      item.describe(shift + 2);
    }
  }
}
```
```
void main() {
  final boxes = ItemContainer('Products');
  final red = ItemContainer('Red');
  red.addItem(SimpleItem('Apple'));
  red.addItem(SimpleItem('Tomato'));
  boxes.addItem(red);
  final yellow = ItemContainer('Yellow');
  yellow.addItem(SimpleItem('Yellow'));
  yellow.addItem(SimpleItem('Banana'));
  boxes.addItem(yellow);
  boxes.describe(0);
}

Products
--Red
----Apple
----Tomato
--Yellow
----Yellow
----Banana
```

### Proxy
The main concept of this pattern involves using a proxy object to provide additional functionality when accessing an existing object. 
For example, it can validate a user's rights before granting access to the object, or defer the creation of an expensive object until it is actually needed. Additionally, if you need to execute tasks before or after the primary logic of a class, the proxy allows you to do so without modifying the original class. Since the proxy implements the same interface as the original class, it can be used by any client that expects the real service object.

Key Concepts:
**Intermediary Object**: The Proxy pattern introduces an intermediary to interact with the real object, controlling access, lifecycle, and additional functionalities.
**Types of Proxies**: Proxies handle various tasks such as remote service calls (Remote Proxy), resource management (Virtual Proxy), or security (Protection Proxy).
**Interface-Based Design**: The proxy and the real object share the same interface for seamless interaction.
**Simplification and Control**: Proxies simplify access to complex or remote objects and control when and how the underlying object is accessed or modified.

```
abstract class Subject {
  void someMethod();
}

class ExpensiveClass implements Subject {
  String name;

  ExpensiveClass(this.name);

  void someMethod() {
    print("someMethod of $name (an ExpensiveClass) is being called");
  }
}

class Proxy implements Subject {
  String _name;
  ExpensiveClass _sub;

  Proxy(this._name);

  void someMethod() {
    print("someMethod of $_name (a Proxy) is being called");
    _subject().someMethod();
  }

  ExpensiveClass _subject() {
    if (_sub != null) return _sub;
    print("Creating an instance of ExpensiveClass for the proxy...");
    _sub = ExpensiveClass(_name);
    return _sub;
  }
}
```

```
void main() {
  var proxy = Proxy("yay");
  print("With our handy proxy, we call someMethod...\r\n");
  proxy.someMethod();
  print("\r\nNotice that the proxy did not have an instance of ExpensiveClass, so it made one when required.");
  print("Now if we call someMethod again...\r\n");
  proxy.someMethod();
  print("\r\nWe reuse the instance we made above!");
}
```

#### Pitfalls
**Single Proxy Limitation**: Typically, only one proxy is used per object, which can be limiting when multiple functionalities like security and auditing are needed.
**Overhead**: Introducing a proxy adds complexity and may cause unexpected behaviors, especially with remote proxies.
**Confusion with Similar Patterns**: The Proxy pattern can be easily confused with Decorator or Adapter patterns when distinctions are unclear.


### Facade
The Facade Design Pattern in Flutter provides a simplified interface to a complex system, such as libraries, frameworks, or interrelated classes, reducing complexity and enhancing usability.

Key Concepts:
**Simplifying Complex Interactions**: The Facade pattern offers a straightforward interface to a complex subsystem, useful when client code interacts with intricate libraries or class systems.
**Refactoring Aid**: Used in refactoring, it wraps a complex or poorly designed API to make it more accessible and understandable.
**Composition Over Inheritance**: Facades use composition by containing instances of various subsystem classes instead of extending them.
**Lifecycle Management**: While facades can manage the lifecycle of objects they interact with, their primary focus is on simplifying the interface.

```
class Grinder {
  String _type;

  Grinder(this._type);

  void grind() {
    print("Grinding $_type!");
  }
}

class Maker {
  String _type;

  Maker(this._type);

  void fill() {
    print("Filling the $_type maker!");
  }

  void retrieve() {
    print("Retrieving the $_type!");
  }

  void start() {
    print("Starting the $_type maker!");
  }
}

class Imbiber {
  String _beverage;

  Imbiber(this._beverage);

  void drink() {
    print("Mmmmm...drinking $_beverage!");
  }
}

class MorningFacade {
  final _coffeeDrinker = Imbiber("coffee");
  final _coffeeGrinder = Grinder("coffee beans");
  final _coffeeMaker = Maker("coffee");

  void prepareCoffee() {
    print("\r\nPreparing the coffee...");
    _coffeeGrinder.grind();
    _coffeeMaker
        ..fill()
        ..start();
    print("Coffee is brewing!\r\n");
  }

  void drinkCoffee() {
    print("\r\nMust...have...coffee...");
    _coffeeMaker.retrieve();
    _coffeeDrinker.drink();
    print("This is damn fine coffee!");
  }
}
```
```
void main() {
  var typicalMorning = MorningFacade();

  print("Wake up! Grab a brush and put on a little makeup...");
  print("\r\nStumble to the kitchen...");

  typicalMorning.prepareCoffee();

  print("Oh my...that smells good...");

  typicalMorning.drinkCoffee();

  print("\r\nI'm ready to attack the day!");
}
```

#### Pitfalls
**Over-Simplification**: A facade can oversimplify a system, potentially limiting clients who need deeper access or control.
**Misuse**: Implementing a facade in a new system may indicate design flaws; it's best used for simplifying existing complex systems.
**Single Responsibility**: Facades can become "god objects" if they aggregate too many functionalities, violating the Single Responsibility Principle.

