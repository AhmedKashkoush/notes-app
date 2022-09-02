import 'dart:io';

import 'package:notes_app/Data/Models/note_model.dart';

abstract class NotesRepository {
  //Normal Notes
  Future createNote(NoteModel model);
  Future createNoteWithImage(NoteModel model, File image);
  Future readNotes();
  Future updateNote(NoteModel model);
  Future updateNoteWithImage(NoteModel model, File image);
  Future deleteNote(int id);
  //Done
  Future markDone(int id);
  Future unmarkDone(int id);
  //Favourites
  Future readFavourites();
  Future addToFavourites(int id);
  Future removeFromFavourites(int id);
  //Archive
  Future readArchive();
  Future addToArchive(int id);
  Future removeFromArchive(int id);
  //Filtering
  Future filterNotes(String query);
  Future filterFavourites(String query);
  Future filterArchive(String query);
  //Delete All
  Future deleteAll();
}
