import 'package:exito/src/core/app/presentation/page/app.dart';
import 'package:exito/src/injection/container_injection.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
