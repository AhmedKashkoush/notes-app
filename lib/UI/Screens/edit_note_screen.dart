import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/Constants/app_colors.dart';
import 'package:notes_app/Constants/app_images.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/Logic/ViewModels/notes_view_model.dart';
import 'package:notes_app/UI/Widgets/custom_alert.dart';
import 'package:notes_app/UI/Widgets/note_text_field.dart';
import 'package:notes_app/UI/Widgets/stacked_clear_button.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteModel model;
  const EditNoteScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  //late final NotesViewModel _vm;
  late int _id;
  String _image = '';
  Color? _firstColor;
  Color? _selectedColor;
  File? _noteImage;
  Uint8List? _bytes;

  @override
  void initState() {
    NoteModel model = widget.model;
    _id = model.id!;
    _image = model.image;
    int colorCode = int.parse(model.color);
    _firstColor =
        AppColors.colors.where((element) => colorCode == element.value).first;
    _selectedColor = _firstColor;
    _titleController = TextEditingController(text: model.title);
    _contentController = TextEditingController(text: model.content);
    if (widget.model.image != '') _bytes = base64Decode(widget.model.image);
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
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (_titleController.text.isNotEmpty &&
                        _titleController.text != widget.model.title) ||
                    (_contentController.text.isNotEmpty &&
                        _contentController.text != widget.model.content) ||
                    (_selectedColor != _firstColor) ||
                    (_image != widget.model.image || _noteImage != null)
                ? () async {
                    String _image = _bytes != null ? base64Encode(_bytes!) : '';
                    NoteModel model = NoteModel(
                      id: widget.model.id,
                      title: _titleController.text,
                      content: _contentController.text,
                      image: _image,
                      color: '${_selectedColor!.value}',
                      date: '${DateTime.now()}',
                      isFav: widget.model.isFav,
                    );
                    int response;
                    if (_noteImage == null)
                      response = await _vm.updateNote(model);
                    else
                      response =
                          await _vm.updateNoteWithImage(model, _noteImage!);
                    if (response != 0) {
                      //await _vm.readNotes();
                      Navigator.pop(context);
                    }
                  }
                : null,
            child: const Text('Save'),
          )
        ],
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 80),
        children: [
          Builder(builder: (context) {
            return Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: 'Title tag:${widget.model.id}/${widget.model.title}',
                      child: Material(
                        color: Colors.transparent,
                        child: NoteTextField(
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
                      ),
                    ),
                    Hero(
                      tag:
                          'Content tag:${widget.model.id}/${widget.model.content}',
                      child: Material(
                        color: Colors.transparent,
                        child: NoteTextField(
                          hint: "What this note's about?",
                          controller: _contentController,
                          maxLines: 20,
                          onChanged: (s) {
                            setState(() {});
                          },
                          onTap: () {
                            setState(() {});
                          },
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Edit the note image',
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
                      child: Hero(
                        tag:
                            'Image tag:${widget.model.id}/${widget.model.image}',
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            image: _noteImage != null
                                ? DecorationImage(
                                    image: FileImage(_noteImage!),
                                    fit: BoxFit.cover,
                                  )
                                : _bytes != null
                                    ? DecorationImage(
                                        image: MemoryImage(_bytes!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                          ),
                          child: _noteImage != null || _bytes != null
                              ? null
                              : Icon(
                                  Ionicons.add_circle_outline,
                                  color: Theme.of(context).primaryColor,
                                  size: 40,
                                ),
                        ),
                      ),
                    ),
                    if (_noteImage != null || _bytes != null)
                      StackedClearButton(
                        onClear: () {
                          setState(() {
                            _noteImage = null;
                            _bytes = null;
                            _image = '';
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
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0.5, color: Colors.white24))),
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
                      radius:
                          _selectedColor == AppColors.colors[index] ? 18 : 13,
                      backgroundColor: AppColors.colors[index].withOpacity(0.4),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAlert,
        backgroundColor: Colors.red,
        child: Icon(
          Ionicons.trash_bin_outline,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showAlert() => showDialog(
      context: context,
      builder: (context) => CustomAlert(
            title: 'Delete note?',
            content: 'Are you sure you want to delete this note?',
            centerTitle: true,
            image: AssetImage(AppImages.deleteNoteImg),
            onCancel: () {
              Navigator.pop(context);
            },
            onConfirm: () async {
              final NotesViewModel _vm =
                  Provider.of<NotesViewModel>(context, listen: false);
              int response = await _vm.deleteNote(_id);
              //await _vm.readNotes();
              Navigator.pop(context);
              if (response != 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Note Deleted'),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                );
                Navigator.pop(context);
              }
            },
            hasSpaceBetweenActions: true,
          ));

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
