import 'package:flutter/material.dart';
import 'package:shared/src/widgets/app_toast.dart';

extension AppToastExtension on BuildContext {
  void showSuccessToast({
    required String message,
    required String description,
  }) {
    AppToast.showSuccess(
      context: this,
      message: message,
      description: description,
    );
  }

  void showErrorToast({required String message, required String description}) {
    AppToast.showError(
      context: this,
      message: message,
      description: description,
    );
  }
}
