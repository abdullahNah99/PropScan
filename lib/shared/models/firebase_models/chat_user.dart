class ChatUser {
  ChatUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.lastActive,
    required this.isOnline,
    required this.pushToken,
    required this.email,
    required this.localUserID,
  });
  late String image;
  late String about;
  late String name;
  late String createdAt;
  late String id;
  late String lastActive;
  late bool isOnline;
  late String pushToken;
  late String email;
  late int localUserID;

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    isOnline = json['is_online'] ?? false;
    pushToken = json['push_token'] ?? '';
    email = json['email'] ?? '';
    localUserID = json['local_user_id'] ?? -1;
  }

  factory ChatUser.factory(Map<String, dynamic> jsonData) {
    return ChatUser(
      image: jsonData['image'] ?? '',
      about: jsonData['about'] ?? '',
      name: jsonData['name'] ?? '',
      createdAt: jsonData['created_at'] ?? '',
      id: jsonData['id'] ?? '',
      lastActive: jsonData['last_active'] ?? '',
      isOnline: jsonData['is_online'] ?? false,
      pushToken: jsonData['push_token'] ?? '',
      email: jsonData['email'] ?? '',
      localUserID: jsonData['local_user_id'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['push_token'] = pushToken;
    data['email'] = email;
    data['local_user_id'] = localUserID;
    return data;
  }
}
