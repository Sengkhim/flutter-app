// ignore: file_names
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../repository/dispose.dart';

abstract class DbContextProvder {
  Database? _context;
  Database? get conext => _context;

  Future<Database> db();
  Future init();
  Future<int> saveChangeAync();
}

class DbContext extends DbContextProvder {
  static const String databaseName = '.dinexCloud.db';

  Future<void> Function(Database, int)? onCreate;
  Future<void> Function(Database)? onConfigure;
  Future<void> Function(Database, int, int)? onUpgrade;
  Future<void> Function(Database, int, int)? onDowngrade;
  Future<void> Function(Database)? onOpen;

  Future<Database?> get database async {
    if (_context == null) {
      var databasePath = await getDatabasesPath();
      String path = '$databasePath/$databaseName';
      _context = await openDatabase(
        path,
        version: 1,
        onCreate: onCreate,
        onOpen: onOpen,
        onConfigure: onConfigure,
        onDowngrade: onDowngrade,
        onUpgrade: onDowngrade,
      );
    }
    return _context;
  }

  @override
  Future<Database> db() {
    throw UnimplementedError();
  }

  @override
  Future init() {
    throw UnimplementedError();
  }

  @override
  Future<int> saveChangeAync() {
    throw UnimplementedError();
  }
}

class DinexContext extends DbContext implements IDisposeable {

  @override
  Future<void> disposeable() {
    throw UnimplementedError();
  }
  
}
