import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/Constants/app_colors.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/UI/Screens/edit_note_screen.dart';
import 'package:notes_app/UI/Transitions/fade_page_transition.dart';
import 'package:notes_app/UI/Widgets/like_button.dart';

class NoteCard extends StatefulWidget {
  final NoteModel model;
  final VoidCallback onFavTapped;
  const NoteCard({Key? key, required this.model, required this.onFavTapped})
      : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _isFav = false;
  late Uint8List _bytes;
  late Color _titleColor;
  late Color _contentColor;

  @override
  void initState() {
    _isFav = widget.model.isFav;
    _bytes = base64Decode(widget.model.image);
    int colorCode = int.parse(widget.model.color);
    Color color =
        AppColors.colors.where((element) => colorCode == element.value).first;
    _titleColor =
        AppColors.blackColorList.contains(color) ? Colors.black : Colors.white;
    _contentColor = AppColors.blackColorList.contains(color)
        ? Colors.black54
        : Colors.white54;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int value = int.parse(widget.model.color);
    final Color color = Color(value);
    final String dateString = widget.model.date;
    final DateTime date = DateTime.parse(dateString);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(FadePageTransition(
            page: EditNoteScreen(
          model: widget.model,
        )));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (widget.model.image != '')
            Hero(
              tag: 'Image tag:${widget.model.id}/${widget.model.image}',
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  image: DecorationImage(
                    image: MemoryImage(_bytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 0,
                  child: Icon(
                    Ionicons.archive_outline,
                    color: _titleColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'Title tag:${widget.model.id}/${widget.model.title}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          widget.model.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: _titleColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Hero(
                      tag:
                          'Content tag:${widget.model.id}/${widget.model.content}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          widget.model.content,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: _contentColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        LikeButton(
                          isLiked: _isFav,
                          onTap: widget.onFavTapped,
                          outlineColor: _titleColor,
                        ),
                        Expanded(
                          child: Text(
                            '${date}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: _contentColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
