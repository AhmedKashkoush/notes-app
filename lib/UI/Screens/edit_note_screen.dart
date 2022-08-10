import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/Logic/ViewModels/notes_view_model.dart';
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
  List<Color> _colors = [
    Colors.grey.shade800,
    Colors.grey,
    Colors.redAccent,
    Colors.red,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.yellowAccent,
    Colors.yellow,
    Colors.lime,
    Colors.limeAccent,
    Colors.greenAccent,
    Colors.green,
    Colors.lightGreenAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.deepPurple,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.brown,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.teal,
    Colors.tealAccent,
  ];
  Color? _firstColor;
  Color? _selectedColor;
  File? _noteImage;

  @override
  void initState() {
    NoteModel model = widget.model;
    int colorCode = int.parse(model.color);
    _firstColor = _colors.where((element) => colorCode == element.value).first;
    _selectedColor = _firstColor;
    _titleController = TextEditingController(text: model.title);
    _contentController = TextEditingController(text: model.content);
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (_titleController.text.isNotEmpty &&
                        _titleController.text != widget.model.title) ||
                    (_contentController.text.isNotEmpty &&
                        _contentController.text != widget.model.content) ||
                    (_selectedColor != _firstColor)
                ? () async {
                    // NoteModel model = NoteModel(
                    //   id: 0,
                    //   title: _titleController.text,
                    //   content: _contentController.text,
                    //   color: '${_selectedColor!.value}',
                    //   date: '${DateTime.now()}',
                    // );
                    // int response;
                    // if (_noteImage == null)
                    //   response = await _vm.createNote(model);
                    // else
                    //   response =
                    //       await _vm.createNoteWithImage(model, _noteImage!);
                    // if (response == 0) {
                    //   await _vm.readNotes();
                    //   Navigator.pop(context);
                    // }
                  }
                : null,
            child: const Text('Save'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(18),
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
                            tag: '${widget.model.id}/${widget.model.title}',
                            child: Material(
                              color: Colors.transparent,
                              child: TextField(
                                controller: _titleController,
                                onChanged: (s) {
                                  setState(() {});
                                },
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                decoration: InputDecoration(
                                    hintText: 'Type your title',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Hero(
                            tag: '${widget.model.id}/${widget.model.content}',
                            child: Material(
                              color: Colors.transparent,
                              child: TextField(
                                controller: _contentController,
                                maxLines: 20,
                                onChanged: (s) {
                                  setState(() {});
                                },
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: "What this note's about?",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                  border: InputBorder.none,
                                ),
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
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _selectSourceSheet();
                                    },
                                    child: Icon(
                                      Ionicons.add_circle_outline,
                                      color: Theme.of(context).primaryColor,
                                      size: 40,
                                    ),
                                  ),
                          ),
                        ),
                        if (_noteImage != null)
                          Positioned.directional(
                              top: 10,
                              end: 10,
                              textDirection: Directionality.of(context),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _noteImage = null;
                                  });
                                },
                                icon: Icon(
                                  Ionicons.close,
                                  color: Colors.white,
                                ),
                              )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(width: 0.5, color: Colors.white24))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                  ),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _colors.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = _colors[index];
                          });
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: _colors[index], shape: BoxShape.circle),
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
        ],
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
