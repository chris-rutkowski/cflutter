extension ListUtils<T> on List<T> {
  int lengthWhere(bool test(T element)) {
    var count = 0;
    forEach((e) {
      if (test(e)) {
        count++;
      }
    });
    return count;
  }
}