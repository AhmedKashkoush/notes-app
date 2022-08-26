import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String? title;
  final String? content;
  final List<Widget>? actions;
  final ImageProvider? image;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool centerTitle;
  final bool centerContent;
  final bool hasSpaceBetweenActions;
  const CustomAlert({
    Key? key,
    this.title,
    this.content,
    this.actions,
    this.image,
    this.onConfirm,
    this.onCancel,
    this.centerTitle = false,
    this.centerContent = false,
    this.hasSpaceBetweenActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment:
          hasSpaceBetweenActions ? MainAxisAlignment.spaceBetween : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
      actionsPadding: const EdgeInsets.all(8),
      title: image != null
          ? Column(
              children: [
                Image(
                  image: image!,
                  fit: BoxFit.cover,
                  height: 150,
                ),
                if (title != null)
                  const SizedBox(
                    height: 20,
                  ),
                if (title != null)
                  Text(
                    title!,
                    textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  ),
              ],
            )
          : title != null
              ? Text(
                  title!,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                )
              : null,
      content: content != null
          ? Text(
              content!,
              textAlign: centerContent ? TextAlign.center : TextAlign.start,
              style: Theme.of(context).textTheme.bodyText2,
            )
          : null,
      actions: actions == null
          ? [
              if (onConfirm != null)
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                  ),
                ),
              if (onCancel != null)
                OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                  ),
                ),
            ]
          : actions,
    );
  }
}
