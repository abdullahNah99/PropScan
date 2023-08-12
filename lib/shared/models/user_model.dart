import 'message_model.dart';

class UserModel {
  final MessageModel messageModel;
  final int id;
  final String name;
  final String email;
  final String token;
  final RoleModel? role;

  UserModel({
    required this.messageModel,
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      messageModel: MessageModel.fromJson(jsonData),
      id: jsonData['user']['id'],
      name: jsonData['user']['name'],
      email: jsonData['user']['email'],
      token: jsonData['user']['token'] ?? '',
      role: jsonData['user']['roles'] != null
          ? RoleModel.fromJson(jsonData['user']['roles'][0])
          : null,
    );
  }
}

class RoleModel {
  final int id;
  final String nameEn;

  RoleModel({required this.id, required this.nameEn});

  factory RoleModel.fromJson(Map<String, dynamic> jsonData) {
    return RoleModel(id: jsonData['id'], nameEn: jsonData['name']);
  }
}
