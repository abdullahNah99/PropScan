// class ChatUser22 {
//   String image;
//   String about;
//   String name;
//   String createdAt;
//   String id;
//   String lastActive;
//   bool isOnline;
//   String pushToken;
//   String email;
//   int localUserID;

//   ChatUser22({
//     required this.image,
//     required this.about,
//     required this.name,
//     required this.createdAt,
//     required this.id,
//     required this.lastActive,
//     required this.isOnline,
//     required this.pushToken,
//     required this.email,
//     required this.localUserID,
//   });

//   factory ChatUser22.fromJson(Map<String, dynamic> json) {
//     return ChatUser22(
//       image: json['image'] ?? '',
//       about: json['about'] ?? '',
//       name: json['name'] ?? '',
//       createdAt: json['created_at'] ?? '',
//       id: json['id'] ?? '',
//       lastActive: json['last_active'] ?? '',
//       isOnline: json['is_online'] ?? false,
//       pushToken: json['push_token'] ?? '',
//       email: json['email'] ?? '',
//       localUserID: json['local_user_id'] ?? -1,
//     );
//   }
// }
