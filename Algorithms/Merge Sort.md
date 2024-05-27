## Merge Sort

'Merge Sort Example':
Let's execute the code with the provided example list [7, 2, 6, 3, 9]:

Original List: [7, 2, 6, 3, 9]
Divide the list into two halves: [7, 2] and [6, 3, 9]
Recursively sort both halves:
Left half: [2, 7]
Right half: [3, 6, 9]
Merge the sorted halves: [2, 3, 6, 7, 9]
Sorted List: [2, 3, 6, 7, 9]
That's how the Merge Sort algorithm works, recursively dividing the list, sorting sublists, and then merging them back together to produce the final sorted list.

```
List<E> _merge<E extends Comparable<dynamic>>(
  List<E> listA,
  List<E> listB,
) {
  var indexA = 0;
  var indexB = 0;
  final result = <E>[];

  // 1
  while (indexA < listA.length && indexB < listB.length) {
    final valueA = listA[indexA];
    final valueB = listB[indexB];
    // 2
    if (valueA.compareTo(valueB) < 0) {
      result.add(valueA);
      indexA += 1;
    } else if (valueA.compareTo(valueB) > 0) {
      result.add(valueB);
      indexB += 1;
    } else {
      // 3
      result.add(valueA);
      result.add(valueB);
      indexA += 1;
      indexB += 1;
    }
  }

  if (indexA < listA.length) {
    result.addAll(listA.getRange(indexA, listA.length));
  }
  if (indexB < listB.length) {
    result.addAll(listB.getRange(indexB, listB.length));
  }
}

List<E> mergeSort<E extends Comparable<dynamic>>(List<E> list) {
  // 1
  if (list.length < 2) return list;
  // 2
  final middle = list.length ~/ 2;
  final left = mergeSort(list.sublist(0, middle));
  final right = mergeSort(list.sublist(middle));
  // 3
  return _merge(left, right);
}

void main() {
  final list = [7, 2, 6, 3, 9];
  final sorted = mergeSort(list);
  print('Original: $list');
  print('Merge sorted: $sorted');
}
```

```
void main() {
  final nums = [2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2];
  final solution = Solution().majorityElement(nums);
  print(solution);
  /*
  Original: [7, 2, 6, 3, 9]
  Merge sorted: [2, 3, 3, 6, 7]
   */
}
```

### Code Breakdown:
Let's go through the provided code step by step:

- _merge Function: This function is responsible for merging two sorted lists.
It takes two sorted lists, listA and listB, as input.
It initializes two index pointers, indexA and indexB, at the start of each list.
It then iterates through both lists simultaneously, comparing elements and adding them to the result list in sorted order.
After the loop, it checks if any elements are remaining in either list and adds them to the result list.
Finally, it returns the merged sorted list.

- mergeSort Function: This is the main function that implements the Merge Sort algorithm.
It takes a list list as input.
If the length of the list is less than 2 (i.e., it contains 0 or 1 element), it returns the list as it is already sorted.
Otherwise, it calculates the middle index of the list and recursively calls mergeSort on the left and right halves of the list.
It then merges the sorted left and right halves using the _merge function.
Finally, it returns the merged sorted list.

- main Function: This is the entry point of the program.
It defines an original list list.
It calls mergeSort to sort the list.
It prints both the original and sorted lists.