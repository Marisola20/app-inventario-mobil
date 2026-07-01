import 'package:flutter/foundation.dart';
import '../../core/database/database_helper.dart';
import '../models/category_model.dart';

class CategoriesProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    
    _categories = maps.map((map) => CategoryModel.fromMap(map)).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel category) async {
    final db = await _dbHelper.database;
    await db.insert('categories', category.toMap());
    await fetchCategories();
  }

  Future<void> updateCategory(CategoryModel category) async {
    final db = await _dbHelper.database;
    await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
    await fetchCategories();
  }

  Future<void> toggleCategoryStatus(int id, bool currentStatus) async {
    final db = await _dbHelper.database;
    await db.update(
      'categories',
      {'isActive': currentStatus ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchCategories();
  }
}
