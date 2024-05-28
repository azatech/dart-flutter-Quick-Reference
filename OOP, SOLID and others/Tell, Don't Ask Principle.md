
#### The "Tell, Don't Ask" 
- principle is a guiding philosophy in software design and object-oriented programming. It suggests that instead of querying the state of an object and then making decisions based on that state, objects should be told what to do.


The below code snippet exhibits a violation of the "Tell, Don't Ask" principle, where the UI component queries whether data is available before fetching it.

```
import 'package:flutter/material.dart';

class LocalDataService {
  bool isDataAvailable() {
    return true; // fake result
  }

  Future<String?> fetchLocalData() async {
    // ...
  }
}

class SimpleWidget extends StatefulWidget {
  @override
  _SimpleWidgetState createState() => _SimpleWidgetState();
}

class _SimpleWidgetState extends State<SimpleWidget> {
  // ...

  Future<void> _fetchData() async {
    if (localDataService.isDataAvailable()) {
      final String? fetchedData = await localDataService.fetchLocalData();
      if (fetchedData != null) {
        internalData = fetchedData;
      }
    }
  }
}
```

In the "Tell, Don't Ask" principle, the UI should not be responsible for querying whether data is available. It should simply inform the service to perform an action, leaving the decision-making process to the service itself. Let's refine the code to adhere to this principle:

```
class LocalDataService {
  bool _isDataAvailable() {
    return true; // fake result
  }

  Future<String?> fetchLocalData() async {
    /// Check here first - if data available - provide result
    // ...
  }
}

Future<void> _fetchData() async {
    final String? fetchedData = await localDataService.fetchLocalData();
    // ...
  }
```