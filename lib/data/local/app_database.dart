import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:budgetbuddy/models/budget_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'budget.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE budget_items (
          id TEXT PRIMARY KEY,
          title TEXT,
          amount REAL,
          isBorrowed INTEGER,
          date TEXT
        )
        ''');
      },
    );
  }

  // Insert a BudgetItem into the database
  Future<void> insertBudgetItem(BudgetItem item) async {
    final db = await database;
    await db.insert(
      'budget_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all BudgetItems
  Future<List<BudgetItem>> getBudgetItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('budget_items');
    return List.generate(maps.length, (i) {
      return BudgetItem.fromMap(maps[i]);
    });
  }

  // Delete a BudgetItem by id
  Future<void> deleteBudgetItem(String id) async {
    final db = await database;
    await db.delete(
      'budget_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
