/// Extension para capitalizar la primera letra de un String
/// Uso: 'example'.capitalize() => 'Example'
/// Ejemplo:
/// String text = 'hello world';
///
extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
