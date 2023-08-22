abstract class StorePropertyModel {
  final int price;
  final String space;
  final int regionID;
  final int propertyTypeID;
  final double x;
  final double y;
  final String description;

  StorePropertyModel({
    required this.price,
    required this.space,
    required this.regionID,
    required this.propertyTypeID,
    required this.x,
    required this.y,
    required this.description,
  });
}

class StoreHouseModel extends StorePropertyModel {
  final int numOfRooms;
  final int numOfBathrooms;
  final int numOfBalcony;
  final String direction;

  StoreHouseModel({
    required this.numOfRooms,
    required this.numOfBathrooms,
    required this.numOfBalcony,
    required this.direction,
    required super.description,
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

  StoreFarmModel({
    required this.numOfRooms,
    required this.numOfPools,
    required this.isGarden,
    required this.isBar,
    required this.isBabyPool,
    required super.description,
    required super.price,
    required super.space,
    required super.regionID,
    required super.propertyTypeID,
    required super.x,
    required super.y,
  });
}

class StoreMarketModel extends StorePropertyModel {
  StoreMarketModel({
    required super.price,
    required super.space,
    required super.regionID,
    required super.propertyTypeID,
    required super.x,
    required super.y,
    required super.description,
  });
}
