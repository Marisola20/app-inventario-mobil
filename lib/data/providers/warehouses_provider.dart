import 'package:flutter/foundation.dart';
import '../../core/database/database_helper.dart';
import '../models/warehouse_model.dart';

class WarehousesProvider with ChangeNotifier {
  List<WarehouseModel> _warehouses = [];
  bool _isLoading = false;

  List<WarehouseModel> get warehouses => _warehouses;
  bool get isLoading => _isLoading;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> fetchWarehouses() async {
    _isLoading = true;
    notifyListeners();

    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('warehouses');
    
    _warehouses = maps.map((map) => WarehouseModel.fromMap(map)).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addWarehouse(WarehouseModel warehouse) async {
    final db = await _dbHelper.database;
    await db.insert('warehouses', warehouse.toMap());
    await fetchWarehouses();
  }

  Future<void> updateWarehouse(WarehouseModel warehouse) async {
    final db = await _dbHelper.database;
    await db.update(
      'warehouses',
      warehouse.toMap(),
      where: 'id = ?',
      whereArgs: [warehouse.id],
    );
    await fetchWarehouses();
  }

  Future<void> toggleWarehouseStatus(int id, bool currentStatus) async {
    final db = await _dbHelper.database;
    await db.update(
      'warehouses',
      {'isActive': currentStatus ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchWarehouses();
  }
}
