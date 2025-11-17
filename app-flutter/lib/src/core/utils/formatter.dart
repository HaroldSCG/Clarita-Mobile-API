class Formatter {
  static String currency(num value) {
    return "Q${value.toStringAsFixed(2)}";
  }

  static String shortDate(String date) {
    if (date.isEmpty) return "-";
    final d = DateTime.tryParse(date);
    if (d == null) return date;
    return "${d.day}/${d.month}/${d.year}";
  }
}