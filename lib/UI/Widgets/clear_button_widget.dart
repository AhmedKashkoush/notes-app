import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ClearButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const ClearButtonWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
      ),
      onPressed: onPressed,
      child: Icon(
        Ionicons.close,
        color: Colors.white,
      ),
    );
  }
}
