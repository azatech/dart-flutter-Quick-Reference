## Bubble Sort

'Bubble Sort Example':

Consider the list of cards: [9, 4, 10, 3]

Iteration 1:
Compare 9 and 4. Since 9 > 4, swap them: [4, 9, 10, 3]
Compare 9 and 10. Since 9 < 10, no swap needed: [4, 9, 10, 3]
Compare 10 and 3. Since 10 > 3, swap them: [4, 9, 3, 10]

Iteration 2:
Compare 4 and 9. Since 4 < 9, no swap needed: [4, 9, 3, 10]
Compare 9 and 3. Since 9 > 3, swap them: [4, 3, 9, 10]
Compare 9 and 10. Since 9 < 10, no swap needed: [4, 3, 9, 10]

Iteration 3:
Compare 4 and 3. Since 4 > 3, swap them: [3, 4, 9, 10]
Compare 4 and 9. Since 4 < 9, no swap needed: [3, 4, 9, 10]
Compare 9 and 10. Since 9 < 10, no swap needed: [3, 4, 9, 10]

Result:
The final sorted list is [3, 4, 9, 10]
In each iteration, Bubble Sort compares adjacent elements and swaps them if they are in the wrong order. After each iteration, the largest unsorted element bubbles up to its correct position. This process repeats until the entire list is sorted.

```
extension SwappableList<E> on List<E> {
  void swap(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }
}
```
```
import 'swap.dart';
void bubbleSort<E extends Comparable<dynamic>>(List<E> list) {
  // 1
  for (var end = list.length - 1; end > 0; end--) {
    var swapped = false;
  // 2
    for (var current = 0; current < end; current++) {
      if (list[current].compareTo(list[current + 1]) > 0) {
        list.swap(current, current + 1);
        swapped = true;
      }
    }
  // 3
    if (!swapped) return;
  }
}
```

## Selection Sort

'Selection Sort Example':
Consider the list of cards: [9, 4, 10, 3]

Iteration 1:
Find the smallest element in the list [9, 4, 10, 3]. It's 3.
Swap 3 with the first element: [3, 4, 10, 9]

Iteration 2:
Find the smallest element in the sublist [4, 10, 9]. It's 4.
Swap 4 with the second element (no change): [3, 4, 10, 9]

Iteration 3:
Find the smallest element in the sublist [10, 9]. It's 9.
Swap 9 with the third element: [3, 4, 9, 10]

Iteration 4:
The remaining element is 10, which is already in the correct position.
Result:
The final sorted list is [3, 4, 9, 10].

In each iteration, Selection Sort finds the smallest element in the unsorted portion of the list and swaps it with the first unsorted element. This process repeats until the entire list is sorted.

```
import 'swap.dart';

void selectionSort<E extends Comparable<dynamic>>(List<E> list) {
  // 1
  for (var start = 0; start < list.length - 1; start++) {
    var lowest = start;
    // 2
    for (var next = start + 1; next < list.length; next++) {
      if (list[next].compareTo(list[lowest]) < 0) {
        lowest = next;
      }
    }
    // 3
    if (lowest != start) {
      list.swap(lowest, start);
    }
  }
}
```

## Insertion Sort

'Insertion Sort Example':

Consider the list of cards: [9, 4, 10, 3]

Iteration 1:
Start with the second element (4). Compare it with the first element (9). Since 4 < 9, move 9 to the right and insert 4 in the first position: [4, 9, 10, 3]

Iteration 2:
Move to the third element (10). Compare it with the elements before it. Since 10 > 9, no movement is needed: [4, 9, 10, 3]

Iteration 3:
Move to the fourth element (3). Compare it with the elements before it. Since 3 < 10, move 10 to the right. Since 3 < 9, move 9 to the right. Since 3 < 4, move 4 to the right. Insert 3 at the beginning: [3, 4, 9, 10]

Result:
The final sorted list is [3, 4, 9, 10].

In each iteration, Insertion Sort takes the next element and places it in its correct position among the previously sorted elements.
```
import 'swap.dart';

void insertionSort<E extends Comparable<dynamic>>(List<E> list) {
    // 1
  for (var current = 1; current < list.length; current++) {
    // 2
    for (var shifting = current; shifting > 0; shifting--) {
    // 3
      if (list[shifting].compareTo(list[shifting - 1]) < 0) {
        list.swap(shifting, shifting - 1);
      } else {
        break;
      }
    }
  }
}
```
