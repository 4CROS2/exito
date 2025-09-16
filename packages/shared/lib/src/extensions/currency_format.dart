import 'package:intl/intl.dart';

///Extension para formatear precios
///Uso: price.toCurrency()
///String price = '1234.56';
///print(price.toCurrency()); // $1,234.56
extension PriceFormatExtension on String {
  String toCurrency({String locale = 'es_CO', String symbol = '\$'}) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: locale,
      symbol: '',
    );
    final double? value = double.tryParse(this);
    if (value == null) {
      return this;
    }
    return '$symbol${formatter.format(value)}';
  }
}
