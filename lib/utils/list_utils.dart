extension ListUtils<T> on List<T> {
  //  int lengthWhere(bool test(T element)) {
  int lengthWhere(bool Function(T element) test) {
    var count = 0;
    forEach((e) {
      if (test(e)) {
        count++;
      }
    });
    return count;
  }
}
