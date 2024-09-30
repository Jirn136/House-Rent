import 'package:flutter/material.dart';
import 'package:house_rent/utils/extension.dart';

import '../../../utils/constants.dart';

class OptionsView extends StatelessWidget {
  final String actionTitle;
  final VoidCallback onLeftClicked;
  final VoidCallback onRightClicked;

  const OptionsView({
    super.key,
    required this.onLeftClicked,
    required this.onRightClicked,
    required this.actionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton.icon(
          onPressed: onLeftClicked,
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          icon: const Icon(
            Icons.close,
          ),
          label: Text(
            Constants.actionCancel,
            style: const TextStyle().textButtonStyle,
          ),
        ),
        TextButton.icon(
          onPressed: onRightClicked,
          icon: const Icon(
            Icons.check,
          ),
          label: Text(
            actionTitle,
            style: const TextStyle().textButtonStyle,
          ),
        ),
      ],
    );
  }
}
