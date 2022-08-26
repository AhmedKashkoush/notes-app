import 'package:flutter/material.dart';
import 'package:notes_app/Constants/app_images.dart';
import 'package:notes_app/UI/Widgets/empty_screen_image.dart';

class ArchivedNotesScreen extends StatefulWidget {
  const ArchivedNotesScreen({Key? key}) : super(key: key);

  @override
  State<ArchivedNotesScreen> createState() => _ArchivedNotesScreenState();
}

class _ArchivedNotesScreenState extends State<ArchivedNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return const EmptyScreenImage(
      imageUrl: AppImages.noArchivedNotesImg,
      text: 'No Archived Notes',
    );
  }
}
