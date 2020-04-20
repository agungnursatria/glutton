class GluttonUtils {
  /// Return true if the value is null or empty
  bool isNullOrEmpty(dynamic value) {
    if (value == null) return true;
    if (value is String) return value.trim().isEmpty;
    if (value is List || value is Set || value is Map) return value.isEmpty;
    return value.toString().trim().isEmpty;
  }
}
