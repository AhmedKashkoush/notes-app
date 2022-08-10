import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/UI/Screens/edit_note_screen.dart';

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
  @override
  void initState() {
    _isFav = widget.model.isFav;
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditNoteScreen(
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
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                image: DecorationImage(
                  image: MemoryImage(
                    base64Decode(widget.model.image),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Builder(builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: '${widget.model.id}/${widget.model.title}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.model.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Hero(
                    tag: '${widget.model.id}/${widget.model.content}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.model.content,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      StatefulBuilder(builder: (context, setState) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFav = !_isFav;
                              widget.onFavTapped.call();
                            });
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                            switchInCurve: Curves.bounceInOut,
                            switchOutCurve: Curves.bounceInOut,
                            child: _isFav
                                ? Icon(
                                    Ionicons.heart,
                                    key: ValueKey<bool>(_isFav),
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Ionicons.heart_outline,
                                    key: ValueKey<bool>(_isFav),
                                    color: Colors.white,
                                  ),
                          ),
                        );
                      }),
                      Expanded(
                        child: Text(
                          '${date}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white54,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ]),
      ),
    );
  }
}
