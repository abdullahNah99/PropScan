class GovernorateModel {
  final int id;
  final String name;

  GovernorateModel({required this.id, required this.name});

  factory GovernorateModel.fromJson(Map<String, dynamic> jsonData) {
    return GovernorateModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
