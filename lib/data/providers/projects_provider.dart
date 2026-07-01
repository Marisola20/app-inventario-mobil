import 'package:flutter/foundation.dart';
import '../../core/database/database_helper.dart';
import '../models/project_model.dart';

class ProjectsProvider with ChangeNotifier {
  List<ProjectModel> _projects = [];
  bool _isLoading = false;

  List<ProjectModel> get projects => _projects;
  bool get isLoading => _isLoading;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> fetchProjects() async {
    _isLoading = true;
    notifyListeners();

    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('projects');
    
    _projects = maps.map((map) => ProjectModel.fromMap(map)).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProject(ProjectModel project) async {
    final db = await _dbHelper.database;
    await db.insert('projects', project.toMap());
    await fetchProjects();
  }

  Future<void> updateProject(ProjectModel project) async {
    final db = await _dbHelper.database;
    await db.update(
      'projects',
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
    await fetchProjects();
  }

  Future<void> deleteProject(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchProjects();
  }
}
