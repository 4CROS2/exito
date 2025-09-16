import 'package:intl/intl.dart';

/// Extension para formatear números como precios en moneda local.
/// Por defecto, usa el formato colombiano (COP) con el símbolo '$'.
/// Ejemplo de uso:
/// ```dart
/// double price = 1234.56;
/// String formatted = price.toCurrency(); // "$1,234.56"
/// ```
/// También se pueden personalizar el locale y el símbolo:
/// ```dart
/// String formatted = price.toCurrency(locale: 'en_US', symbol: '\$'); //
/// "$1,234.56"
/// String formatted = price.toCurrency(locale: 'de_DE', symbol: '€'); //
///   "1.234,56 €"
/// ```
extension PriceFormatExtension on num {
  String toCurrency({String locale = 'es_CO', String symbol = '\$'}) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: locale,
      symbol: '',
    );
    return '$symbol ${formatter.format(this)}';
  }
}
