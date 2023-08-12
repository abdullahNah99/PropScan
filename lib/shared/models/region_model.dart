class RegionModel {
  final int id;
  final double x;
  final double y;
  final String name;

  RegionModel({
    required this.id,
    required this.x,
    required this.y,
    required this.name,
  });

  factory RegionModel.fromJson(Map<String, dynamic> jsonData) {
    return RegionModel(
      id: jsonData['id'],
      x: jsonData['x'],
      y: jsonData['y'],
      name: jsonData['name'],
    );
  }
}
