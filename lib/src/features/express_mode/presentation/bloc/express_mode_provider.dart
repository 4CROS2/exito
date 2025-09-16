import 'dart:async';

import 'package:exito/src/features/express_mode/domain/usecase/express_mode_usecase.dart';
import 'package:flutter/material.dart';

class ExpressModeProvider extends ChangeNotifier {
  ExpressModeProvider({required ExpressModeUsecase usecase})
    : _usecase = usecase {
    _startCheckingAvailability();
  }

  /// Tiempo personalizado para iniciar el modo exprés (variable de entorno)
  /// por defecto es 10 (10 AM)
  /// para cambiarlo, usar --dart-define=CUSTOM_TIME=9 (9 AM) al compilar
  /// o --dart-define=CUSTOM_TIME=11 (11 AM)
  /// solo se permiten horas entre 6 y 15 (6 AM a 3 PM)
  /// si se ingresa un valor inválido, se usará el valor por defecto (10)
  /// Ejemplo:
  /// flutter run --dart-define=CUSTOM_TIME=9
  /// flutter build apk --dart-define=CUSTOM_TIME=11
  final String customTime = const String.fromEnvironment(
    'CUSTOM_TIME',
    defaultValue: '10',
  );

  final ExpressModeUsecase _usecase;

  bool _isExpressMode = false;
  bool _isExpressModeAvailable = false;

  bool get isExpressMode => _isExpressMode;
  bool get isExpressModeAvailable => _isExpressModeAvailable;

  void toggleExpressMode({bool? isEnabled}) async {
    _isExpressMode = isEnabled ?? !_isExpressMode;
    await _usecase.toggleExpressMode(isEnabled: _isExpressMode);
    notifyListeners();
  }

  void loadExpressMode() async {
    _isExpressMode = await _usecase.isExpressModeEnabled();
    notifyListeners();
  }

  /// 🔄 Ejecuta checkExpressModeAvailable automáticamente cada minuto
  void _startCheckingAvailability() {
    // chequeo inicial al crear el provider
    checkExpressModeAvailable();

    // luego cada 1 minuto vuelve a validar
    Timer.periodic(const Duration(minutes: 1), (_) {
      checkExpressModeAvailable();
    });
  }

  /// Verifica si el modo exprés está disponible según la hora actual
  /// y la hora personalizada (customTime)
  void checkExpressModeAvailable() {
    final DateTime now = DateTime.now();
    final DateTime start = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(customTime),
    );
    final DateTime end = DateTime(now.year, now.month, now.day, 16);

    final bool available = now.isAfter(start) && now.isBefore(end);

    if (available != _isExpressModeAvailable) {
      _isExpressModeAvailable = available;
      notifyListeners();
    }
  }
}
