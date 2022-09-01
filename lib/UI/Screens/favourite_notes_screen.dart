import 'package:flutter/material.dart';
import 'package:notes_app/Constants/app_images.dart';
import 'package:notes_app/UI/Widgets/empty_screen_image.dart';

class FavouriteNotesScreen extends StatefulWidget {
  const FavouriteNotesScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteNotesScreen> createState() => _FavouriteNotesScreenState();
}

class _FavouriteNotesScreenState extends State<FavouriteNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return const EmptyScreenImage(
      imageUrl: AppImages.noFavouriteNotesImg,
      text: 'No Favourite Notes',
    );
  }
}
