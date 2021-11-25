import 'dart:math';

const int N = 100000000; // 100 millions number.
const int MAX = 100000000;

void main() {
  // Generate a random int list.
  List l = [];
  Random rng = Random();
  for (int i = 0; i < N; i++) {
    l.add(rng.nextInt(MAX));
  }

  // Start quick sort and measure the performance.
  int start = DateTime.now().microsecondsSinceEpoch;
  quickSortIncrease(l, 0, l.length - 1);
  int end = DateTime.now().microsecondsSinceEpoch;
  double durationInSecond = (end - start) / 1000000;
  print("Sorting $N numbers took $durationInSecond seconds.");
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
