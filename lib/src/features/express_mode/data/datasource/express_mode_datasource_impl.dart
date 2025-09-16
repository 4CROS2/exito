import 'package:exito/src/features/express_mode/domain/datasource/express_mode_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IExpressModeDatasource implements ExpressModeDatasource {
  ///shared preferences or local storage can be used here

  static const String _cartKey = 'express_mode';

  /// Obtiene la instancia de SharedPreferences
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<void> toggleExpressMode({required bool isEnabled}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(_cartKey, isEnabled);
  }

  @override
  Future<bool> isExpressModeEnabled() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(_cartKey) ?? false;
    });
  }
}
