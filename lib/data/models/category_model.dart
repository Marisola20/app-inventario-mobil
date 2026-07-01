class CategoryModel {
  final int? id;
  final String name;
  final String? description;
  final bool isActive;

  CategoryModel({
    this.id,
    required this.name,
    this.description,
    this.isActive = true,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isActive: map['isActive'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive ? 1 : 0,
    };
  }
}
