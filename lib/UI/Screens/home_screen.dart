import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/Constants/app_colors.dart';
import 'package:notes_app/Logic/ViewModels/notes_view_model.dart';
import 'package:notes_app/UI/Screens/archived_notes_screen.dart';
import 'package:notes_app/UI/Screens/favourite_notes_screen.dart';
import 'package:notes_app/UI/Screens/new_note_screen.dart';
import 'package:notes_app/UI/Screens/notes_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  final List<Widget> _pagesList = const [
    NotesScreen(),
    FavouriteNotesScreen(),
    ArchivedNotesScreen(),
  ];

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
                onChanged: (s) {
                  setState(() {});
                },
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
          _showSearch && _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                  icon: Icon(Ionicons.close),
                )
              : AnimatedOpacity(
                  opacity: _showSearch ? 0 : 1,
                  duration: const Duration(milliseconds: 400),
                  child: IgnorePointer(
                    ignoring: _showSearch,
                    child: IconButton(
                        onPressed: () {
                          if (_showSearch) return;
                          setState(() {
                            _showSearch = true;
                            FocusScope.of(context).requestFocus(_searchFocus);
                          });
                          //containerRadius = 15;
                          ModalRoute<Object?>? route =
                              ModalRoute.of<Object?>(context);
                          route
                            ?..addLocalHistoryEntry(
                                LocalHistoryEntry(onRemove: () {
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
      body: _pagesList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.appPrimaryColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
            activeIcon: Icon(Ionicons.archive),
            label: 'Archive',
          ),
        ],
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 400),
        offset: _showSearch ? Offset(0, 3) : Offset.zero,
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          opacity: _showSearch ? 0 : 1,
          child: FloatingActionButton(
            heroTag: 'add note',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NewNoteScreen()));
            },
            child: Icon(Ionicons.add),
          ),
        ),
      ),
    );
  }
}
