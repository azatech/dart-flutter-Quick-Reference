## Quick Sort

'Quick Sort Example':

```
void quickSort(List<int> list, int low, int high) {
  if (low < high) {
    int pivotIndex = partition(list, low, high);

    // Recursively sort elements before and after the pivot
    quickSort(list, low, pivotIndex - 1);
    quickSort(list, pivotIndex + 1, high);
  }
}

int partition(List<int> list, int low, int high) {
  int pivot = list[high];
  int i = low - 1; // Index of smaller element

  for (int j = low; j < high; j++) {
    // If current element is smaller than the pivot
    if (list[j] < pivot) {
      i++;
      // Swap list[i] and list[j]
      int temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }
  // Swap list[i+1] and list[high] (or pivot)
  int temp = list[i + 1];
  list[i + 1] = list[high];
  list[high] = temp;

  return i + 1;
}

void main() {
  List<int> list = [7, 2, 6, 3, 9];
  print('Original list: $list');
  quickSort(list, 0, list.length - 1);
  print('Sorted list: $list');
}
```