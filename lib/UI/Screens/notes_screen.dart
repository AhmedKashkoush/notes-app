import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/Constants/constants.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/Logic/ViewModels/notes_view_model.dart';
import 'package:notes_app/UI/Screens/new_note_screen.dart';
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
  int _currentIndex = 0;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final NotesViewModel _vm =
          Provider.of<NotesViewModel>(context, listen: false);
      await _vm.readNotes();
    });
    super.initState();
  }

  //double containerRadius = 15;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NotesViewModel _vm =
        Provider.of<NotesViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        // title: !_showSearch
        //     ? Text(
        //         'Notes App',
        //       )
        //     : TextField(
        //         decoration: InputDecoration(
        //           border: InputBorder.none,
        //           hintText: 'Search',
        //         ),
        //       ),
        // flexibleSpace: FlexibleSpaceBar(
        //   background: AnimatedSlide(
        //     offset: !_showSearch ? Offset(-2, 0) : Offset.zero,
        //     duration: const Duration(milliseconds: 400),
        //     child: SafeArea(
        //       child: AnimatedContainer(
        //         decoration: BoxDecoration(
        //           color: AppConstants.appPrimaryColor,
        //           borderRadius: BorderRadiusDirectional.only(
        //               topEnd: Radius.circular(containerRadius),
        //               bottomEnd: Radius.circular(containerRadius)),
        //         ),
        //         duration: const Duration(milliseconds: 400),
        //       ),
        //     ),
        //     onEnd: () {
        //       setState(() {
        //         containerRadius = 0;
        //       });
        //     },
        //   ),
        // ),
        title: Stack(alignment: Alignment.centerLeft, children: [
          AnimatedOpacity(
            opacity: _showSearch ? 0 : 1,
            duration: const Duration(milliseconds: 400),
            child: Text(
              'Notes App',
            ),
          ),
          AnimatedOpacity(
            opacity: !_showSearch ? 0 : 1,
            duration: const Duration(milliseconds: 400),
            child: AnimatedSlide(
              offset: !_showSearch ? Offset(-1, 0) : Offset.zero,
              duration: const Duration(milliseconds: 400),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocus,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
          ),
        ]),
        actions: [
          AnimatedOpacity(
            opacity: _showSearch ? 0 : 1,
            duration: const Duration(milliseconds: 400),
            child: IgnorePointer(
              ignoring: _showSearch,
              child: IconButton(
                onPressed: () async {
                  await _vm.deleteAll();
                },
                icon: Icon(
                  Ionicons.trash_bin,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _showSearch ? 0 : 1,
            duration: const Duration(milliseconds: 400),
            child: IgnorePointer(
              ignoring: _showSearch,
              child: IconButton(
                  onPressed: () {
                    // setState(() {
                    //   _showSearch = !_showSearch;
                    // });
                    if (_showSearch) return;
                    setState(() {
                      _showSearch = true;
                      FocusScope.of(context).requestFocus(_searchFocus);
                    });
                    //containerRadius = 15;
                    ModalRoute<Object?>? route =
                        ModalRoute.of<Object?>(context);
                    route
                      ?..addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
                        _showSearch = false;
                        //containerRadius = 15;
                        FocusScope.of(context).unfocus();
                        _searchController.clear();
                      }))
                      ..createAnimationController()
                      ..createAnimation();
                    route?.buildTransitions(
                        context,
                        route.animation!,
                        route.animation!,
                        FadeTransition(
                          opacity: route.animation!,
                          child: widget,
                        ));
                  },
                  icon: Icon(Ionicons.search)),
            ),
          ),
        ],
      ),
      body: Consumer<NotesViewModel>(
        builder: (context, provider, child) {
          if (provider.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (provider.notes.isNotEmpty)
            return OrientationBuilder(builder: (context, orientation) {
              bool isPortrait = orientation == Orientation.portrait;
              return StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(16),
                crossAxisCount: isPortrait ? 2 : 3,
                itemBuilder: (BuildContext context, int index) => NoteCard(
                    model: provider.notes[index],
                    onFavTapped: () {
                      NoteModel model = provider.notes[index];
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text('${model.id}'),
                      // ));
                      if (!model.isFav)
                        provider.addToFavourites(model.id!);
                      else
                        provider.removeFromFavourites(model.id!);
                    }),
                itemCount: provider.notes.length,
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.fit(1);
                },
                // gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                //   staggeredTileBuilder: (int index) {
                //     return StaggeredTile.extent(2, 200);
                //   },
                //   crossAxisCount: 2,
                // ),
                // itemBuilder: (BuildContext context, int index) =>
                //     NoteCard(model: provider.notes[index]),
                // itemCount: provider.notes.length,
              );
            });
          else
            return Center(
              child: OrientationBuilder(builder: (context, orientation) {
                if (orientation == Orientation.portrait)
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppConstants.noNotesImg,
                        width: 250,
                        height: 250,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'No Notes',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  );

                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppConstants.noNotesImg,
                      width: 250,
                      height: 250,
                    ),
                    Text(
                      'No Notes',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                );
              }),
            );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppConstants.appPrimaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.clipboard_outline),
            activeIcon: Icon(Ionicons.clipboard),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.heart_outline),
            activeIcon: Icon(Ionicons.heart),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.archive_outline),
            activeIcon: Icon(Ionicons.archive_outline),
            label: 'Archive',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add note',
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewNoteScreen()));
        },
        child: Icon(Ionicons.add),
      ),
    );
  }
}
