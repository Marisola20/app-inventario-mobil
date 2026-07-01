class WarehouseModel {
  final int? id;
  final String name;
  final String? location;
  final bool isActive;

  WarehouseModel({
    this.id,
    required this.name,
    this.location,
    this.isActive = true,
  });

  factory WarehouseModel.fromMap(Map<String, dynamic> map) {
    return WarehouseModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      isActive: map['isActive'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'isActive': isActive ? 1 : 0,
    };
  }
}
