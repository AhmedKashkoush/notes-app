import 'package:flutter/material.dart';
import 'package:notes_app/UI/Widgets/clear_button_widget.dart';

class StackedClearButton extends StatelessWidget {
  final VoidCallback onClear;
  final double alignment;
  const StackedClearButton({
    Key? key,
    required this.onClear,
    this.alignment = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      top: alignment,
      end: alignment,
      textDirection: Directionality.of(context),
      child: ClearButtonWidget(
        onPressed: onClear,
      ),
    );
  }
}
