While time complexity helps forecast an algorithm's scalability, it's not the only important factor.
Space complexity measures the amount of memory needed for an algorithm to execute.

Consider the following code:

```
int multiply(int a, int b) {
  return a * b;
}
```

To execute this straightforward algorithm in Dart, the system allocates memory for two input
parameters, \( a \) and \( b \), as well as for the return value. The specific amount of space
allocated internally by Dart depends on implementation details and execution environment. However,
this allocation remains fixed regardless of input size. Even with exceptionally large input values,
only the return value's storage is affected, leading to overflow rather than increased space usage.
Consequently, the space complexity of this algorithm is **constant**, denoted by Big O notation
as \( O(1) \).

Another example:

```
List<String> fillList(int length) {
  return List.filled(length, 'a');
}
```

This algorithm generates a list filled with the string 'a'. As the length increases, so does the
size of the list in memory, directly proportional to the input value. Hence, the space complexity of
this algorithm is linear, denoted by Big O notation as O(n).

To modify the algorithm to have quadratic space complexity:

```
List<String> stuffList(int length) {
  return List.filled(length, 'a' * length);
}
```

In this modified algorithm, the length of each string element in the list grows quadratically with
its index 𝑖 i. Therefore, as 𝑛 n increases, the total space required grows quadratically, resulting
in a space complexity of O(n^2).

As the length parameter increases in this algorithm, not only does the list grow longer, but each
element in the list also expands in size proportionally. For instance, setting the length parameter
to 5 results in a list containing elements like 'aaaaa'. Similar to quadratic time complexity, where
operations grow quadratically with input size, the space complexity in this case also scales
quadratically. Therefore, the Big O notation for quadratic space complexity is O(n²).

#### Other Notations
Up to now, you've assessed algorithms using Big O notation, which indicates the worst-case
runtime—an essential metric for programmers. However, there are other notations to consider:

- **Big Omega notation** evaluates the best-case runtime of an algorithm. While theoretically
  useful, it's less practical because achieving the best-case scenario consistently can be
  challenging.

- **Big Theta notation** provides a measure of the runtime that lies between the best and worst-case
  scenarios. It describes algorithms where the best-case and worst-case complexities are the same,
  offering a more precise characterization of their performance.