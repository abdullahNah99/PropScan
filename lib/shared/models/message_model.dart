class MessageModel {
  final bool status;
  final String message;

  MessageModel({required this.status, required this.message});

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      status: jsonData['status'],
      message: jsonData['msg'],
    );
  }
}
