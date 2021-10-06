extension DefaultMap<K, V> on Map<K, V> {
  V? getOrElse(K key, V? defaultValue) {
    if (this.containsKey(key)) {
      return ((this[key] == null) ||
              (defaultValue is String
                  ? (this[key] != null && (this[key] as String).isEmpty)
                  : false))
          ? defaultValue
          : this[key];
    } else {
      return defaultValue;
    }
  }
}
