import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  final Widget portraitWidget;
  final Widget landscapeWidget;
  const OrientationWidget(
      {Key? key, required this.portraitWidget, required this.landscapeWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) return portraitWidget;

        return landscapeWidget;
      },
    );
  }
}
