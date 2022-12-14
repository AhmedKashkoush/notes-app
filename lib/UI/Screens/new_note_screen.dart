import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/Constants/app_colors.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/Logic/ViewModels/notes_view_model.dart';
import 'package:notes_app/UI/Widgets/note_text_field.dart';
import 'package:notes_app/UI/Widgets/stacked_clear_button.dart';
import 'package:provider/provider.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentNode = FocusNode();
  Color? _selectedColor;
  File? _noteImage;

  bool isBold = false;
  bool isItalic = false;
  String textAlign = 'left';

  @override
  void initState() {
    _selectedColor = AppColors.colors.first;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NotesViewModel _vm = Provider.of<NotesViewModel>(
      context,
    );
    return Hero(
      tag: 'add note',
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: _titleController.text.isNotEmpty &&
                        _contentController.text.isNotEmpty
                    ? () async {
                        NoteModel model = NoteModel(
                          id: 0,
                          title: _titleController.text,
                          content: _contentController.text,
                          color: '${_selectedColor!.value}',
                          date: '${DateTime.now()}',
                        );
                        int response;
                        if (_noteImage == null)
                          response = await _vm.createNote(model);
                        else
                          response =
                              await _vm.createNoteWithImage(model, _noteImage!);
                        if (response != 0) {
                          await _vm.readNotes();
                          Navigator.pop(context);
                        }
                      }
                    : null,
                child: const Text('Add'),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                      top: 18, left: 18, right: 18, bottom: 80),
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NoteTextField(
                              hint: 'Type your title',
                              controller: _titleController,
                              fontWeight: FontWeight.bold,
                              onChanged: (s) {
                                setState(() {});
                              },
                              onTap: () {
                                setState(() {});
                              },
                            ),
                            NoteTextField(
                              hint: "What this note's about?",
                              controller: _contentController,
                              focusNode: _contentNode,
                              maxLines: 20,
                              onChanged: (s) {
                                setState(() {});
                              },
                              onTap: () {
                                setState(() {});
                              },
                              fontWeight:
                                  isBold ? FontWeight.w600 : FontWeight.w300,
                              fontSize: 16,
                              textAlign: textAlign == 'right'
                                  ? TextAlign.end
                                  : textAlign == 'center'
                                      ? TextAlign.center
                                      : TextAlign.start,
                              fontStyle: isItalic
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Add an image to your note',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      child: DottedBorder(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 3,
                        radius: Radius.circular(25),
                        dashPattern: [10, 5],
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _selectSourceSheet();
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    image: _noteImage != null
                                        ? DecorationImage(
                                            image: FileImage(_noteImage!),
                                            fit: BoxFit.cover)
                                        : null,
                                  ),
                                  child: _noteImage != null
                                      ? null
                                      : Icon(
                                          Ionicons.add_circle_outline,
                                          color: Theme.of(context).primaryColor,
                                          size: 40,
                                        ),
                                ),
                              ),
                              if (_noteImage != null)
                                StackedClearButton(
                                  onClear: () {
                                    setState(() {
                                      _noteImage = null;
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _contentNode.hasPrimaryFocus ? 60 : 0,
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                          top: BorderSide(width: 0.5, color: Colors.white24))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBold = !isBold;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isBold
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                          child: Icon(Icons.format_bold_rounded),
                        ),
                      ),
                      //textAlign
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isItalic = !isItalic;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isItalic
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                          child: Icon(Icons.format_italic_outlined),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            textAlign = 'left';
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: textAlign == 'left'
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                          child: Icon(Icons.format_align_left),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            textAlign = 'center';
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: textAlign == 'center'
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                          child: Icon(Icons.format_align_center),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            textAlign = 'right';
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: textAlign == 'right'
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                          child: Icon(Icons.format_align_right),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border:
                    Border(top: BorderSide(width: 0.5, color: Colors.white24))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: _selectedColor,
                  ),
                  const VerticalDivider(
                    thickness: 1,
                  ),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: AppColors.colors.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = AppColors.colors[index];
                          });
                        },
                        child: CircleAvatar(
                          radius: _selectedColor == AppColors.colors[index]
                              ? 18
                              : 13,
                          backgroundColor:
                              AppColors.colors[index].withOpacity(0.4),
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: AppColors.colors[index],
                            child: Center(
                              child: AnimatedScale(
                                scale: _selectedColor == AppColors.colors[index]
                                    ? 1
                                    : 0,
                                duration: const Duration(
                                  milliseconds: 300,
                                ),
                                curve: Curves.easeInOut,
                                child: Icon(
                                  Ionicons.checkmark,
                                  color: AppColors.blackColorList
                                          .contains(AppColors.colors[index])
                                      ? Colors.black
                                      : Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectSourceSheet() => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.horizontal_rule_rounded,
                  size: 50, color: Colors.grey.shade400),
              ListTile(
                leading: Icon(Ionicons.camera_outline),
                title: const Text('Camera',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onTap: () async {
                  XFile? _imageFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (_imageFile != null) {
                    setState(() {
                      _noteImage = File(_imageFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
                iconColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColor,
              ),
              ListTile(
                leading: Icon(Ionicons.image_outline),
                title: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  XFile? _imageFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (_imageFile != null) {
                    setState(() {
                      _noteImage = File(_imageFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
                iconColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ));
}
