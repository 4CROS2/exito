import 'dart:async';

import 'package:exito/src/features/express_mode/domain/usecase/express_mode_usecase.dart';
import 'package:flutter/material.dart';

class ExpressModeProvider extends ChangeNotifier {
  ExpressModeProvider({required ExpressModeUsecase usecase})
    : _usecase = usecase {
    _startCheckingAvailability();
    loadExpressMode();
  }

  final ExpressModeUsecase _usecase;

  static const String customTime = String.fromEnvironment(
    'CUSTOM_TIME',
    defaultValue: '10',
  );

  bool _isExpressMode = false; // decisión del usuario
  bool _isExpressModeAvailable = false; // disponibilidad por horario

  bool get isExpressMode => _isExpressMode;
  bool get isExpressModeAvailable => _isExpressModeAvailable;

  /// Usuario cambia el switch
  Future<void> toggleExpressMode({bool? isEnabled}) async {
    _isExpressMode = isEnabled ?? !_isExpressMode;
    await _usecase.toggleExpressMode(isEnabled: _isExpressMode);
    notifyListeners();
  }

  /// Carga el estado desde base de datos con validación de disponibilidad
  Future<void> loadExpressMode() async {
    final bool savedMode = await _usecase.isExpressModeEnabled();

    if (_isExpressModeAvailable) {
      // ✅ Dentro del horario → respetamos lo guardado
      _isExpressMode = savedMode;
    } else {
      // ⛔ Fuera del horario → forzamos OFF
      _isExpressMode = false;
      await _usecase.toggleExpressMode(isEnabled: false);
    }

    notifyListeners();
  }

  /// 🔄 Verifica disponibilidad automáticamente
  void _startCheckingAvailability() {
    checkExpressModeAvailable(); // chequeo inicial
    Timer.periodic(const Duration(seconds: 5), (_) {
      checkExpressModeAvailable();
    });
  }

  /// Revisa si está dentro del horario permitido
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

      // ⚡ Si cambió de disponible → forzamos recarga del estado
      loadExpressMode();
    } else {
      notifyListeners();
    }
  }
}
