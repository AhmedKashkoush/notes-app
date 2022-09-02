import 'package:flutter/material.dart';
import 'package:notes_app/UI/Widgets/orientation_widget.dart';

class EmptyScreenImage extends StatelessWidget {
  final String imageUrl;
  final String? text;
  final double size;
  const EmptyScreenImage(
      {Key? key, required this.imageUrl, this.text, this.size = 250})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OrientationWidget(
        portraitWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageUrl,
              width: 250,
              height: 250,
            ),
            const SizedBox(
              height: 25,
            ),
            if (text != null)
              Text(
                text!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
          ],
        ),
        landscapeWidget: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imageUrl,
              width: 250,
              height: 250,
            ),
            if (text != null)
              Text(
                text!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
          ],
        ),
      ),
    );
  }
}
