### Flutter Trees

[Flutter Trees](https://www.flutteris.com/blog/en/flutter-internals?ref=plugfox.dev) by Flutteris
[Widget, State and Context](https://www.flutteris.com/blog/en/widget-state-context-inheritedwidget?ref=plugfox.dev) by Flutteris

Every widget represents an unchangeable declaration of a portion of the user interface.

Flutter developers commonly use **StatelessWidget** and **StatefulWidget** to construct their layouts.
However, Flutter also offers a range of foundational widgets beyond these, termed **RenderObjectWidgets**.
These unique widgets serve as a connection between the higher-level widgets and the lower-level rendering layer.
RenderObjectWidgets ultimately translate into nodes within the underlying render tree, responsible for managing the UI's layout and geometry.
Although developers primarily work with higher-level widgets, these widgets are closely intertwined with the render tree, ensuring that the user interface remains adaptable in design and effective in layout and visual presentation.

## Widget Tree
The Widget Tree is the primary point of interaction for Flutter developers. 
It's a hierarchical arrangement of widgets that delineates the structure and characteristics of the user interface. 
Widgets are designed to be immutable, meaning that whenever there's a modification in their parameters or state, they are reconstructed with updated values.

When developers utilize **StatelessWidget** or **StatefulWidget** classes to generate additional widgets, they implicitly inherit from the **Widget** class.
```
// Flutter source code
// packages/flutter/lib/src/widgets/framework.dart
abstract class StatelessWidget extends Widget {}
abstract class StatefulWidget extends Widget {}
```

The Widget class in Flutter is immutable:
```
@immutable
abstract class Widget extends DiagnosticableTree {}
```
Now, there are two questions at hand: 
- How does a widget identify its position within the tree? 
- How does it manage to render and respond to state updates despite being immutable?

## Element Tree
Widgets themselves do not retain information about their position in the tree. 
Instead, another mechanism comes into play to provide this information: **Elements**.
**Elements** hold crucial details about widgets' relationships, including their parents, children, size, RenderObject, and more.
```
@immutable
abstract class Widget extends DiagnosticableTree {
  ...
  @protected
  @factory
  Element createElement();
  ...
}
```
Indeed, when you create a widget in Flutter, the framework invokes the **createElement()** method, which returns an object of type **Element**. 
The Element class implements the **BuildContext** interface, establishing a connection between widgets and their context within the widget tree.
```
abstract class Element extends DiagnosticableTree implements BuildContext {}
```
BuildContext should indeed ring a bell! 
It's the parameter passed to the build() method within widgets. 
Consequently, widgets receive their corresponding elements as parameters of the build method, granting them access to essential information about their position within the UI tree.

Absolutely, the elements tree plays a pivotal role in upholding the stability of the widget tree. Each element represents a widget at a specific location within the tree, responsible for orchestrating the lifecycle of the widgets and their underlying render objects. Unlike widgets, elements are enduring and mutable, persisting and managing updates even as widgets evolve.

Delving deeper into Flutter's widget structure, we encounter intriguing distinctions in the construction of different widgets, especially when analyzing their elements. 
For instance, **StatelessWidget** and **StatefulWidget**, as prime examples, extend from **ComponentElement**.
```
// Flutter source code
// packages/flutter/lib/src/widgets/framework.dart
abstract class StatelessWidget extends Widget {
  @override
  StatelessElement createElement() => StatelessElement(this);
}

class StatelessElement extends ComponentElement {}
```
Certainly, when we consider widgets like StatelessWidget and StatefulWidget, the corresponding elements created are of type **StatelessElement** and **StatefulElement**, respectively, both of which extend from **ComponentElement**. 
However, this paradigm shifts when examining other widgets in the Flutter framework. 

For example, widgets like **SizedBox**, which extend **SingleChildRenderObjectWidget**, employ a distinct type of element - **RenderObjectElement**.
```
// Flutter source code
// packages/flutter/lib/src/widgets/basic.dart
class SizedBox extends SingleChildRenderObjectWidget {}
// packages/flutter/lib/src/widgets/framework.dart
abstract class SingleChildRenderObjectWidget extends RenderObjectWidget {
  @override
  createElement() => SingleChildRenderObjectElement(this);
}
// packages/flutter/lib/src/widgets/framework.dart
class SingleChildRenderObjectElement extends RenderObjectElement {}
```
Exactly, **ComponentElement** serves as the root of its subtree, hosting other elements within it. 
Unlike **RenderObjectElement**, it doesn't possess an associated **RenderObject** directly. 
Instead, it indirectly generates **RenderObjects** by creating other **Elements**.

In contrast, **RenderObjectElement** nodes in the element tree play an active role in the layout and painting phases of rendering. 
They are directly linked to corresponding **RenderObject** nodes in the render tree.
**RenderObjects** handle more complex operations such as sizing, positioning, hit-testing, and painting, carrying out the majority of the work involved in rendering the UI.

## RenderObject Tree
**RenderObject Tree** is responsible for the concrete layout and rendering of the UI. 
As a developer, you're well aware that aspects like sizing, layout, painting, and schematics are pivotal for your application's performance. 
With RenderObject, you can efficiently manage all these tasks across frames, optimizing time and ensuring your app operates seamlessly. 
This tree is where Flutter executes layout calculations and renders the UI on the screen.
**RenderObjects, being mutable**, take charge of the size, position, and rendering of UI elements.


### Anatomy of a Widget
Delving into the inner workings of a Flutter widget, particularly **SizedBox**, provides an intriguing insight into Flutter's architecture. 
The **SizedBox** widget, which is a tangible representation of **SingleChildRenderObjectWidget**, showcases the multi-layered design approach inherent in Flutter. 
As seen in Flutter's source code, SizedBox inherits from **SingleChildRenderObjectWidget**, an abstract class that further extends **RenderObjectWidget**.
```
// packages/flutter/lib/src/widgets/basic.dart
class SizedBox extends SingleChildRenderObjectWidget {}
// packages/flutter/lib/src/widgets/framework.dart
abstract class SingleChildRenderObjectWidget extends RenderObjectWidget { ... }
```

**SingleChildRenderObjectWidget** inherits from **RenderObjectWidget**:
```
abstract class RenderObjectWidget extends Widget {}
```





