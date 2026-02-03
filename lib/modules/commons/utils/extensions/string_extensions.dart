extension StringExtensions on String {
  String returnValueIfEmpty(String value) {
    return trim().isEmpty ? value : trim();
  }
}
