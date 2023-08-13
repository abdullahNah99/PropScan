abstract class StorePropertyModel {
  final int price;
  final int space;
  final int regionID;
  final int propertyTypeID;
  final double x;
  final double y;

  StorePropertyModel({
    required this.price,
    required this.space,
    required this.regionID,
    required this.propertyTypeID,
    required this.x,
    required this.y,
  });
}

class StoreHouseModel extends StorePropertyModel {
  final int numOfRooms;
  final int numOfBathrooms;
  final int numOfBalcony;
  final String direction;
  final String description;
  StoreHouseModel({
    required this.numOfRooms,
    required this.numOfBathrooms,
    required this.numOfBalcony,
    required this.direction,
    required this.description,
    required super.price,
    required super.space,
    required super.regionID,
    required super.propertyTypeID,
    required super.x,
    required super.y,
  });
}

class StoreFarmModel extends StorePropertyModel {
  final int numOfPools;
  final int numOfRooms;
  final bool isGarden;
  final bool isBar;
  final bool isBabyPool;
  final String description;
  StoreFarmModel({
    required this.numOfRooms,
    required this.description,
    required this.numOfPools,
    required this.isGarden,
    required this.isBar,
    required this.isBabyPool,
    required super.price,
    required super.space,
    required super.regionID,
    required super.propertyTypeID,
    required super.x,
    required super.y,
  });
}
