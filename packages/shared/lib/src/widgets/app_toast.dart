import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void showSuccess({
    required String message,
    required String description,
    BuildContext? context,
  }) {
    _showToast(
      message: message,
      context: context,
      type: ToastificationType.success,
      description: description,
    );
  }

  static void showError({
    required String message,
    required String description,
    BuildContext? context,
  }) {
    _showToast(
      message: message,
      context: context,
      type: ToastificationType.error,
      description: description,
    );
  }

  static void _showToast({
    required String message,
    required ToastificationType type,
    required String description,
    BuildContext? context,
  }) {
    toastification.show(
      context: context,
      title: Text(message),
      type: type,
      showIcon: true,
      animationDuration: const Duration(milliseconds: 300),
      autoCloseDuration: const Duration(seconds: 2, milliseconds: 500),
      description: Text(description),
    );
  }
}
