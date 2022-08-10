import 'dart:io';

import 'package:notes_app/Data/Models/note_model.dart';
import 'package:notes_app/Data/Repositories/notes_repository.dart';
import 'package:notes_app/Utils/Helpers/db_helper.dart';
import 'package:notes_app/Utils/Helpers/file_helper.dart';

class DBApi implements NotesRepository {
  @override
  Future createNote(NoteModel model) async {
    String title = model.title;
    String content = model.content;
    String color = model.color;
    String date = model.date;
    String query =
        "INSERT INTO notes('title','content','color','date','image','is_favourite','is_archived') VALUES(?,?,?,?,?,?,?)";
    int response =
        await DBHelper.create(query, [title, content, color, date, '', 0, 0]);
    if (response == 0) throw Exception();
    return;
  }

  @override
  Future createNoteWithImage(NoteModel model, File imageFile) async {
    String? bytes =
        await FileHelper.saveImage(imageFile, 'note-${model.id}-${model.date}');
    if (bytes == null) throw Exception();
    String title = model.title;
    String content = model.content;
    String image = bytes;
    String color = model.color;
    String date = model.date;
    String query =
        "INSERT INTO notes('title','content','image','color','date','is_favourite','is_archived') VALUES(?,?,?,?,?,?,?)";
    int response = await DBHelper.create(
        query, [title, content, image, color, date, 0, 0]);
    if (response != 0) {
      //await FileHelper.deleteImage(bytes);
      throw Exception();
    }
    return response;
  }

  @override
  Future addToArchive(int id) async {
    String updateQuery = "UPDATE notes SET is_archived = ? WHERE id = ?";

    int response = await DBHelper.update(updateQuery, [1, id]);
    if (response == 0) {
      throw Exception();
    }
  }

  @override
  Future removeFromArchive(int id) async {
    String updateQuery = "UPDATE notes SET is_archived = ? WHERE id = ?";

    int response = await DBHelper.update(updateQuery, [0, id]);
    if (response == 0) {
      throw Exception();
    }
  }

  @override
  Future addToFavourites(int id) async {
    String updateQuery = "UPDATE notes SET is_favourite = ? WHERE id = ?";

    int response = await DBHelper.update(updateQuery, [1, id]);
    if (response == 0) {
      throw Exception();
    }
  }

  @override
  Future removeFromFavourites(int id) async {
    String updateQuery = "UPDATE notes SET is_favourite = ? WHERE id = ?";

    int response = await DBHelper.update(updateQuery, [0, id]);
    if (response == 0) {
      throw Exception();
    }
  }

  @override
  Future deleteNote(int id) async {
    String deleteQuery = "DELETE FROM notes WHERE id = ?";

    int response = await DBHelper.delete(deleteQuery, [id]);
    if (response == 0) {
      throw Exception();
    }
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
  Future readNotes() async {
    String readQuery = "SELECT * FROM notes";
    List<Map<String, Object?>> data = await DBHelper.read(readQuery, []);
    return data;
  }

  @override
  Future updateNote(NoteModel model) async {}

  @override
  Future markDone(int id) async {
    String updateQuery = "UPDATE notes SET is_done = ? WHERE id = ?";

    int response = await DBHelper.update(updateQuery, [1, id]);
    if (response == 0) {
      throw Exception();
    }
  }

  @override
  Future unmarkDone(int id) async {
    String updateQuery = "UPDATE notes SET is_done = ? WHERE id = ?";

    int response = await DBHelper.update(updateQuery, [0, id]);
    if (response == 0) {
      throw Exception();
    }
  }

  @override
  Future readArchive() async {
    String readQuery = "SELECT * FROM notes WHRERE is_archived = 1";
    List<Map<String, Object?>> data = await DBHelper.read(readQuery, []);
    return data;
  }

  @override
  Future readFavourites() async {
    String readQuery = "SELECT * FROM notes WHRERE is_favourite = 1";
    List<Map<String, Object?>> data = await DBHelper.read(readQuery, []);
    return data;
  }

  @override
  Future deleteAll() async {
    await DBHelper.delete('DELETE FROM notes', []);
  }
}
