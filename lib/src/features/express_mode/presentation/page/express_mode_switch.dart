import 'package:exito/src/core/extension/locale_extension.dart';
import 'package:exito/src/features/express_mode/presentation/bloc/express_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

class ExpressModeSwitch extends StatefulWidget {
  const ExpressModeSwitch({super.key});

  @override
  State<ExpressModeSwitch> createState() => _ExpressModeSwitchState();
}

class _ExpressModeSwitchState extends State<ExpressModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpressModeProvider>(
      builder:
          (
            BuildContext context,
            ExpressModeProvider expressModeProvider,
            Widget? child,
          ) {
            if (!expressModeProvider.isExpressModeAvailable) {
              return const SizedBox.shrink();
            }
            return Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Text(
                    context.locale.express_mode,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textTheme.bodyMedium?.color,
                      height: 1,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: expressModeProvider.isExpressMode,
                  onChanged: (bool newValue) {
                    context.read<ExpressModeProvider>().toggleExpressMode();
                  },
                ),
              ],
            );
          },
    );
  }
}
