extension IsNullOrEmpty on String? {
  bool get isNullOrEmpty => this == null || '' == this;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension IsNotNullAndTrue on Map<String, dynamic> {
  bool isNotNullAndTrue(String key) => this[key] != null && this[key] as bool;
}
