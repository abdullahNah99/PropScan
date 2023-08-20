class PropertyModel {
  final int id;
  final int userId;
  final int price;
  final int space;
  final String state;
  final String governorate;
  final String region;
  final String type;
  final double x;
  final double y;
  final List<dynamic> images;
  bool isFoveate;
  double? distance;

  PropertyModel({
    required this.id,
    required this.price,
    required this.space,
    required this.state,
    required this.governorate,
    required this.region,
    required this.type,
    required this.x,
    required this.y,
    required this.images,
    required this.isFoveate,
    required this.userId,
    this.distance,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> jsonData) {
    return PropertyModel(
      id: jsonData['id'],
      userId: jsonData['user_id'],
      price: jsonData['price'],
      space: jsonData['space'],
      state: jsonData['state'],
      governorate: jsonData['governorate'],
      region: jsonData['region'],
      type: jsonData['type'],
      x: jsonData['x'],
      y: jsonData['y'],
      images: jsonData['images'],
      isFoveate: false,
    );
  }
}
