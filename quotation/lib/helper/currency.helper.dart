class CurrencyHelper {
  static toDouble(String value) {
    return value == null ? 0.0 : double.tryParse(value.replaceAll(',', '.'));
  }

  static toText(double value) {
    return value == null ? '0' : value.toString().replaceAll('.', ',');
  }
}
