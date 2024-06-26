## Time Complexity

**Time complexity is a measure of the time required to run an algorithm as the input size increases.
**

### Constant Time

A constant-time algorithm executes in the same amount of time regardless of the input size.

For example, whether the input consists of 10 items or 10 million items, a constant-time function
would only perform an operation that accesses or manipulates a single element, such as printing the
first element of a list.

```
void checkFirst(List<String> names) {
  if (names.isNotEmpty) {
    print(names.first);
  } else {
    print('no names');
  }
}
```

### Linear Time

Linear time complexity is straightforward to grasp: as the input size grows, the running time
increases proportionally. This is depicted by a straight, linear graph, and it's represented in Big
O notation as **O(n)**.

For example, a function that prints all the names in a list exhibits linear time complexity. As the
size of the input list increases, the number of iterations performed by the for loop also increases
in direct proportion.

```
void printNames(List<String> names) {
  for (final name in names) {
    print(name);
  }
}
```

### Note

- How about considering a function that iterates twice over all the data and invokes six methods,
  each with constant time complexity \( O(1) \)? Does it result in a time complexity of \( O(2n +
    6) \)? Time complexity provides a general overview of performance, so loops that iterate a fixed
       number of times do not significantly impact the calculation. In Big O notation, we disregard
       constants, resulting in \( O(2n + 6) \) being equivalent to \( O(n) \).

### Quadratic Time

More commonly known as \( n^2 \), this time complexity describes an algorithm that requires time
proportional to the square of the input size.

- This time, the function prints all the names in the list for each name in the list itself. For
  instance, if the list contains ten items, it will print the entire list of ten names ten times,
  totaling 100 print statements. With each increment in input size, such as adding one more item to
  the list, it will print the entire list of eleven names eleven times, resulting in 121 print
  statements. Unlike linear time complexity, where operations scale linearly with input size, the \(
  n^2 \) algorithm can rapidly become impractical as the dataset grows.

The Big O notation for quadratic time complexity is **O(n²)**.

```
void printMoreNames(List<String> names) {
  for (final _ in names) {
    for (final name in names) {
      print(name);
    }
  }
}
```

### Logarithmic Time

Consider this scenario: if you had a sorted list of integers, what's the most efficient method to
determine if a specific value exists? A straightforward approach would involve examining each
element of the list sequentially until reaching a determination.

```
const numbers = [1, 3, 56, 66, 68, 80, 99, 105, 450];

bool naiveContains(int value, List<int> list) {
  for (final element in list) {
    if (element == value) return true;
  }
  return false;
}
```

#### Note

Big O notation consistently illustrates the **worst-case scenario**. While the algorithm mentioned
could potentially conclude immediately, it's also plausible that every element needs inspection.
While viewing the worst-case scenario might seem pessimistic, it's highly beneficial because it
establishes the upper limit of performance. Once identified, you can then endeavor to enhance the
algorithm.

For example, when verifying the presence of the number 451 in the list, the naive approach would
iterate through all nine values sequentially. However, because the list is sorted, you can initially
reduce the number of comparisons by half simply by checking the middle value:

```
bool betterNaiveContains(int value, List<int> list) {
  if (list.isEmpty) return false;
  final middleIndex = list.length ~/ 2;
  if (value > list[middleIndex]) {
    for (var i = middleIndex; i < list.length; i++) {
      if (list[i] == value) return true;
    }
  } else {
    for (var i = middleIndex; i >= 0; i--) {
      if (list[i] == value) return true;
    }
  }
  return false;
}
```

The algorithm initially examines the middle value to compare it with the target value. If the middle
value exceeds the target, the algorithm disregards the right half of the list because, in a sorted
list, values to the right can only be larger. Conversely, if the middle value is smaller, the
algorithm ignores the left side. This optimization effectively reduces the number of comparisons by
half.

An algorithm that consistently halves the required comparisons exhibits **logarithmic time
complexity**.

As the input size increases, the algorithm's execution time increases at a slow rate. Observing
closely, you'll notice the graph tends toward asymptotic behavior. This is due to the significant
impact of halving the number of comparisons. For instance, with an input size of 100, halving saves
50 comparisons; with 100,000, it saves 50,000 comparisons. This scaling effect becomes more
pronounced with larger datasets, resulting in the graph approaching a horizontal line. Algorithms in
this category are rare but exceptionally potent in suitable scenarios. The Big O notation for
logarithmic time complexity is **O(log n)**.

### Quasilinear Time

Another frequently encountered time complexity is **quasilinear time**. Quasilinear time algorithms
perform worse than linear time but significantly better than quadratic time. You can conceptualize
quasilinear time as being somewhat akin to linear time for large datasets. An example of a
quasilinear time algorithm is Dart's sort method.

The Big-O notation for quasilinear time complexity is **O(n log n)**, which combines linear and
logarithmic time complexities. Quasilinear time complexity exhibits a near-linear growth pattern as
input size increases, making it particularly effective for handling large datasets.

#### Other Time Complexities

The five time complexities you’ve encountered so far are the ones you’ll deal with in
this book. Other time complexities do exist but are far less common and tackle more
complex problems that are not covered in this book. These time complexities
include:
• **O(nᵏ)**: polynomial time.
• **O(2ⁿ)**: exponential time.
• **O(n!)**: factorial time.
And there are many more.
