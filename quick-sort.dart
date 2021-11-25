import 'dart:math';
import 'dart:io';

const int N_DEFAULT = 10; // 10 numbers by default.
const int N_MAX_PRINT = 100; // If the list size is larger than 100, we don't
// print it anymore.
const int MAX = 10;

/// Execution example:
/// 1. dart run quick-sort.dart
/// 2. dart run quick-sort.dart 100
/// 3. dart run quick-sort.dart 100000000
void main(List<String> arguments) {
  // Initialize arguments.
  int n = N_DEFAULT;
  if (arguments.isNotEmpty) {
    try {
      n = int.parse(arguments[0]);
    } on FormatException {
      stderr.write("[ERROR] Invalid integer argument ${arguments[0]}.");
      exit(1);
    }
  }

  // Generate a random int list.
  List l = [];
  Random rng = Random();
  for (int i = 0; i < n; i++) {
    l.add(rng.nextInt(MAX));
  }
  if (n <= N_MAX_PRINT) {
    print("Initial list: $l");
  }

  // Start quick sort and measure the performance.
  int start = DateTime.now().microsecondsSinceEpoch;
  quickSortIncrease(l, 0, l.length - 1);
  int end = DateTime.now().microsecondsSinceEpoch;
  double durationInSecond = (end - start) / 1000000;
  if (n <= N_MAX_PRINT) {
    print("List after sorting: $l");
  }
  print("Sorting $n numbers took $durationInSecond seconds.");
}

/// Perform an increase quick sort. The parameter l will be sorted in-place.
/// Parameters lowerBoundaryIndex and upperBoundaryIndex are inclusive indices.
/// Example:
/// var l = [2, 3, 1];
/// quickSortIncrease(l, 0, 2);
void quickSortIncrease(List l, int lowerBoundaryIndex, int upperBoundaryIndex) {
  final int pivotIndex = lowerBoundaryIndex;
  int replaceIndex = pivotIndex + 1;
  for (int i = lowerBoundaryIndex + 1; i <= upperBoundaryIndex; i++) {
    if (l[i] < l[pivotIndex]) {
      swap(l, replaceIndex, i);
      replaceIndex++;
    }
  }
  swap(l, pivotIndex, replaceIndex - 1);
  if (replaceIndex - 2 > lowerBoundaryIndex) {
    quickSortIncrease(l, lowerBoundaryIndex, replaceIndex - 2);
  }
  if (upperBoundaryIndex > replaceIndex) {
    quickSortIncrease(l, replaceIndex, upperBoundaryIndex);
  }
}

/// Swap two elements in a list according to their indices. The change will be
/// in-place.
/// Example:
/// var l = [1, 2, 3];
/// swap(l, 0, 2);
void swap(List l, int index1, int index2) {
  var temp = l[index1];
  l[index1] = l[index2];
  l[index2] = temp;
}
