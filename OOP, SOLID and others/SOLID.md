## SOLID Principles

Here, I will describe the SOLID principles, which are very important for every self-respecting
programmer. This document was created purely for my personal needs and practice.
If you notice a bug or have any comments, feel free to reach out to me wherever is convenient.

Useful links:

- [List of software development philosophies](https://en.wikipedia.org/wiki/List_of_software_development_philosophies "List of software development philosophies")

In above link, you'll find many references to various paradigms/approaches in software development.
It's not possible to adhere to all approaches simultaneously. You can take this list as
RECOMMENDATIONS.

The main thing to consider from the list:
It's important to understand the principle chosen for work (its pros and cons).

### KISS (Keep it simple, stupid)

Pros: Keep things simple and straightforward for easy comprehension.
Cons: Simple doesn't always mean good. Adding functionality to base classes and subclasses can lead
to a family of classes that can be reused, making it slightly more complex. However, in this case,
we gain something.

### YAGNI (You ain't gonna need it)

Pros: Don't create code that isn't currently needed. Adding unnecessary code just creates clutter
that needs to be removed later. Code evolves, and what's not needed should be discarded over time.
Cons: Think for yourself :)

### DRY (Don't Repeat Yourself) and SSOT (Single Source of Truth)

Pros: If there's a likelihood that information will change, duplicating code or data means having to
make changes in multiple places. Avoid this by creating a single representation of code in the
system (SSOT). Don't repeat yourself.
Cons: Think for yourself :)


## SOLID

The paradigm cannot always be applied in code due to the language constraints. For example, Swift is
not only an object-oriented language but also a functional one. Using all principles at once is like
choosing between several "water filters" to purify it and deliver the cleanest water at the output.
Achieving absolute purity in water is still impossible. We're just striving for the ideal.

#### S - Single Responsibility Principle - one object is responsible for one responsibility.
Example of violation: If an object is responsible for UI, data, etc., it's better to use three
separate objects that are divided.

#### O - Open Closed Principle - Software entities should be open for extension, but closed for
modification. Use Extensions to add code, inherit, and extend.
Example of violation: Imagine code already in production and working at 100%. Changing the
functionality in already tested objects adds work for testers and increases development costs.

It's better to add additional code to the object, extending its functionality.
When writing, ALWAYS think if the code written will be easily extendable if changes need to be made
in the future. If you need to rewrite code instead of extending it, you haven't adhered to the Open
Closed Principle.

#### L - Liskov Substitution Principle - Objects in a program should be replaceable with instances of
their subtypes without altering the correctness of the program.
Example of violation: If the base class walks on legs and the subclass walks on hands, it's a
mutant. In other words, you shouldn't change the functionality of the base class. You've violated
the Liskov Substitution Principle.
If subclasses override the behavior of the object, they should not break anything but simply add
functionality if needed. Use @Override + super.call().

#### I - Interface Segregation Principle - Use interfaces.
Example of violation: Many interfaces are better than using one interface for all cases. If a class
implements an interface and doesn't implement all the methods from the interface, it's better to
separate the methods into separate interfaces.

#### D - Dependency Inversion Principle - Dependencies in the system should be based on abstractions.
They should not depend on details.
When we add dependency to an object, we should add abstractions instead of details. Thus, the object
will depend on the abstraction.
This way, the code can be easily tested: create a Mock Object that implements the abstraction, and
the object under test (SUT) depends on the abstraction, not the details.

Dependency Inversion
But first, let's understand what Dependency Injection is. There are 3 initialization methods:

- Initializer injection (an object needs another object to function properly)
```
class DataManager { 
    private let serializer

    init(serializer: Serializer) {
        self.serializer = serializer    
    }
}
```

- Property injection (an object can be dependent using a variable...)
```
  class SomeUIController {
      var requestManager: RequestManager? 
  }
  func call() {
    let vc = SomeUIController()
    vc.requestManager = RequestManager() 
  }
```

- Method injection (if it doesn't make sense to add the entire dependency for the entire object, and it's actually only needed for one function, it makes sense to add the dependency through the function's input)
```
  class DataManager {
  func call(dataManager: DataManager) {
    // ...
  }
```
