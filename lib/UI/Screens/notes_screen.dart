import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notes_app/Constants/app_images.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/Logic/ViewModels/notes_view_model.dart';
import 'package:notes_app/UI/Widgets/empty_screen_image.dart';
import 'package:notes_app/UI/Widgets/note_card.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final NotesViewModel _vm =
          Provider.of<NotesViewModel>(context, listen: false);
      if (_vm.notes.isNotEmpty) return;
      await _vm.readNotes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, provider, child) {
        if (provider.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (provider.notes.isNotEmpty)
          return OrientationBuilder(builder: (context, orientation) {
            bool isPortrait = orientation == Orientation.portrait;
            return AnimationLimiter(
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.only(
                    top: 16, right: 16, left: 16, bottom: 80),
                crossAxisCount: isPortrait ? 2 : 3,
                itemBuilder: (BuildContext context, int index) =>
                    AnimationConfiguration.staggeredGrid(
                  columnCount: isPortrait ? 2 : 3,
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: FadeInAnimation(
                    child: NoteCard(
                        model: provider.notes[index],
                        onFavTapped: () {
                          NoteModel model = provider.notes[index];
                          if (!model.isFav)
                            provider.addToFavourites(model.id!);
                          else
                            provider.removeFromFavourites(model.id!);
                        }),
                  ),
                ),
                itemCount: provider.notes.length,
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.fit(1);
                },
              ),
            );
          });
        else
          return const EmptyScreenImage(
            imageUrl: AppImages.noNotesImg,
            text: 'No Notes',
          );
      },
    );
  }
}
