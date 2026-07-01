class ProjectModel {
  final int? id;
  final String name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String status;

  ProjectModel({
    this.id,
    required this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.status = 'active', // active, completed, cancelled
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }
}
