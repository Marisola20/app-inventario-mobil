class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String role; // 'admin' o 'worker'
  final bool isActive;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.isActive = true,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
      isActive: map['isActive'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'isActive': isActive ? 1 : 0,
    };
  }
}
