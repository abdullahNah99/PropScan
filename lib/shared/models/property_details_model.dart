class PropertyDetailsModel {
  final int id;
  final int price;
  final int space;
  final int userID;
  final int regionID;
  final int propertyStateID;
  final String state;
  final String governorate;
  final String region;
  final String type;
  final double x;
  final double y;
  final List<dynamic> images;
  final HouseModel? houseModel;
  final FarmModel? farmModel;
  final MarketModel? marketModel;

  PropertyDetailsModel({
    required this.id,
    required this.price,
    required this.space,
    required this.userID,
    required this.regionID,
    required this.propertyStateID,
    required this.state,
    required this.governorate,
    required this.region,
    required this.type,
    required this.x,
    required this.y,
    required this.images,
    this.houseModel,
    this.farmModel,
    this.marketModel,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return PropertyDetailsModel(
      id: jsonData['id'],
      price: jsonData['price'],
      space: jsonData['space'],
      userID: jsonData['user_id'],
      regionID: jsonData['region_id'],
      propertyStateID: jsonData['property_state_id'],
      state: jsonData['state'],
      governorate: jsonData['governorate'],
      region: jsonData['region'],
      type: jsonData['type'],
      x: jsonData['x'],
      y: jsonData['y'],
      images: jsonData['images'],
      houseModel: jsonData['house'] != null
          ? HouseModel.fromJson(jsonData['house'])
          : null,
      farmModel: jsonData['farm'] != null
          ? FarmModel.fromJson(jsonData['farm'])
          : null,
      marketModel: jsonData['market'] != null
          ? MarketModel.fromJson(jsonData['market'])
          : null,
    );
  }
}

class HouseModel {
  final int id;
  final int numberOfRooms;
  final int numberOfBathrooms;
  final int numberOfBalcony;
  final int propertyID;
  final String description;
  final String direction;

  HouseModel({
    required this.id,
    required this.numberOfRooms,
    required this.numberOfBathrooms,
    required this.numberOfBalcony,
    required this.propertyID,
    required this.description,
    required this.direction,
  });

  factory HouseModel.fromJson(Map<String, dynamic> jsonData) {
    return HouseModel(
      id: jsonData['id'],
      numberOfRooms: jsonData['number_of_rooms'],
      numberOfBathrooms: jsonData['number_of_bathroom'],
      numberOfBalcony: jsonData['number_of_balcony'],
      propertyID: jsonData['property_id'],
      description: jsonData['description'],
      direction: jsonData['direction'],
    );
  }
}

class FarmModel {
  final int id;
  final int numberOfRooms;
  final int numberOfPools;
  final int propertyID;
  final bool isGarden;
  final bool isBar;
  final bool isBabyPool;
  final String description;

  FarmModel({
    required this.id,
    required this.numberOfRooms,
    required this.numberOfPools,
    required this.propertyID,
    required this.isGarden,
    required this.isBar,
    required this.isBabyPool,
    required this.description,
  });

  factory FarmModel.fromJson(Map<String, dynamic> jsonData) {
    return FarmModel(
      id: jsonData['id'],
      numberOfRooms: jsonData['number_of_rooms'],
      numberOfPools: jsonData['number_of_pools'],
      propertyID: jsonData['property_id'],
      isGarden: jsonData['is_garden'],
      isBar: jsonData['is_bar'],
      isBabyPool: jsonData['is_baby_pool'],
      description: jsonData['description'],
    );
  }
}

class MarketModel {
  final int id;
  final int propertyID;
  final String description;

  MarketModel({
    required this.id,
    required this.propertyID,
    required this.description,
  });

  factory MarketModel.fromJson(Map<String, dynamic> jsonData) {
    return MarketModel(
      id: jsonData['id'],
      propertyID: jsonData['property_id'],
      description: jsonData['description'],
    );
  }
}
