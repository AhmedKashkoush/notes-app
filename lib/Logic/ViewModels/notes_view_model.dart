import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes_app/Data/LocalDB/db_api.dart';
import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/Data/Repositories/notes_repository.dart';

class NotesViewModel extends ChangeNotifier implements NotesRepository {
  final DBApi _api = DBApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<NoteModel> _notes = [];
  List<NoteModel> _favNotes = [];
  List<NoteModel> _archNotes = [];

  List<NoteModel> get notes => _notes;
  List<NoteModel> get favNotes => _favNotes;
  List<NoteModel> get archNotes => _archNotes;

  @override
  void dispose() {
    _notes.clear();
    _favNotes.clear();
    _archNotes.clear();
    _isLoading = false;
    super.dispose();
  }

  @override
  Future addToArchive(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.addToFavourites(id);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future addToFavourites(int id) async {
    // _isLoading = true;
    // notifyListeners();
    try {
      await _api.addToFavourites(id);
      NoteModel model = _notes.where((element) => element.id == id).first;
      int index = _notes.indexOf(model);
      _notes.removeAt(index);
      NoteModel newModel = NoteModel(
        id: model.id,
        title: model.title,
        content: model.content,
        color: model.color,
        date: model.date,
        image: model.image,
        isFav: true,
      );
      _notes.insert(index, newModel);
      _favNotes.add(newModel);
    } catch (e) {}
    // _isLoading = false;
    // notifyListeners();
  }

  @override
  Future createNote(NoteModel model) async {
    int response = 0;
    _isLoading = true;
    notifyListeners();
    try {
      response = await _api.createNote(model);
      if (response != 0) {
        _notes.add(model);
      }
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
    return response;
  }

  @override
  Future createNoteWithImage(NoteModel model, File image) async {
    int response = 0;
    _isLoading = true;
    notifyListeners();
    try {
      response = await _api.createNoteWithImage(model, image);
      if (response != 0) {
        _notes.add(model);
      }
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
    return response;
  }

  @override
  Future<void> deleteNote(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.deleteNote(id);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future filterArchive(String query) {
    throw UnimplementedError();
  }

  @override
  Future filterFavourites(String query) {
    throw UnimplementedError();
  }

  @override
  Future filterNotes(String query) {
    throw UnimplementedError();
  }

  @override
  Future<void> markDone(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.markDone(id);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future readNotes() async {
    _isLoading = true;
    notifyListeners();
    try {
      List _notesData = await _api.readNotes();
      List<NoteModel> _newNotes =
          _notesData.map((element) => NoteModel.fromJson(element)).toList();
      _notes.clear();
      _notes.addAll(_newNotes);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> removeFromArchive(int id) async {}

  @override
  Future<void> removeFromFavourites(int id) async {
    try {
      await _api.removeFromFavourites(id);
      NoteModel model = _notes.where((element) => element.id == id).first;
      int index = _notes.indexOf(model);
      _notes.removeAt(index);
      NoteModel newModel = NoteModel(
        id: model.id,
        title: model.title,
        content: model.content,
        color: model.color,
        date: model.date,
        image: model.image,
        isFav: false,
      );
      _notes.insert(index, newModel);
      _favNotes.remove(model);
    } catch (e) {}
  }

  @override
  Future<void> unmarkDone(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.unmarkDone(id);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> updateNote(NoteModel model) async {}

  @override
  Future readArchive() async {
    _isLoading = true;
    notifyListeners();
    try {
      List _notesData = await _api.readArchive();
      List<NoteModel> _newNotes =
          _notesData.map((element) => NoteModel.fromJson(element)).toList();
      _archNotes.addAll(_newNotes);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future readFavourites() async {
    _isLoading = true;
    notifyListeners();
    try {
      List _notesData = await _api.readFavourites();
      List<NoteModel> _newNotes =
          _notesData.map((element) => NoteModel.fromJson(element)).toList();
      _favNotes.addAll(_newNotes);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }

  @override
  Future deleteAll() async {
    await _api.deleteAll();
    await readNotes();
    notifyListeners();
  }
}
