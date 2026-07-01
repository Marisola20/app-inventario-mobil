class MovementModel {
  final int? id;
  final int productId;
  final int warehouseId;
  final int? projectId;
  final int userId;
  final String type; // 'IN' or 'OUT'
  final int quantity;
  final String date;
  final String? notes;
  final bool isSynced;

  MovementModel({
    this.id,
    required this.productId,
    required this.warehouseId,
    this.projectId,
    required this.userId,
    required this.type,
    required this.quantity,
    required this.date,
    this.notes,
    this.isSynced = false,
  });

  factory MovementModel.fromMap(Map<String, dynamic> map) {
    return MovementModel(
      id: map['id'],
      productId: map['productId'],
      warehouseId: map['warehouseId'],
      projectId: map['projectId'],
      userId: map['userId'],
      type: map['type'],
      quantity: map['quantity'],
      date: map['date'],
      notes: map['notes'],
      isSynced: map['is_synced'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'warehouseId': warehouseId,
      'projectId': projectId,
      'userId': userId,
      'type': type,
      'quantity': quantity,
      'date': date,
      'notes': notes,
      'is_synced': isSynced ? 1 : 0,
    };
  }
}
