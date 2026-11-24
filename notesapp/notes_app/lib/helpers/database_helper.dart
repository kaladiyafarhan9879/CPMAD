import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  // In-memory storage for Web preview
  final List<Note> _webNotes = [];
  int _webIdCounter = 1;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get device application documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'notes.db');

    return openDatabase(
      dbPath,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert Note
  Future<int> insertNote(Note note) async {
    if (kIsWeb) {
      final newNote = Note(
        id: _webIdCounter++,
        title: note.title,
        content: note.content,
        date: note.date,
      );
      _webNotes.add(newNote);
      return newNote.id!;
    }
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  // Fetch all Notes
  Future<List<Note>> getNotes() async {
    if (kIsWeb) {
      return List.from(_webNotes);
    }
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  // Update Note
  Future<int> updateNote(Note note) async {
    if (kIsWeb) {
      int index = _webNotes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        _webNotes[index] = note;
        return 1;
      }
      return 0;
    }
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Delete Note
  Future<int> deleteNote(int id) async {
    if (kIsWeb) {
      _webNotes.removeWhere((n) => n.id == id);
      return 1;
    }
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
