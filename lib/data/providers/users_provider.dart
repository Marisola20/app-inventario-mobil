import 'package:flutter/foundation.dart';
import '../../core/database/database_helper.dart';
import '../models/user_model.dart';

class UsersProvider with ChangeNotifier {
  List<UserModel> _users = [];
  bool _isLoading = false;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    
    _users = maps.map((map) => UserModel.fromMap(map)).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    final db = await _dbHelper.database;
    await db.insert('users', user.toMap());
    await fetchUsers();
  }

  Future<void> updateUser(UserModel user) async {
    final db = await _dbHelper.database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
    await fetchUsers();
  }

  Future<void> toggleUserStatus(int id, bool currentStatus) async {
    final db = await _dbHelper.database;
    await db.update(
      'users',
      {'isActive': currentStatus ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchUsers();
  }
}
