class WaterModel {
  final int? id;
  final String waterUserId;
  final String waterGlass;
  final String waterDate;
  final String waterTime;

  WaterModel({
    this.id,
    required this.waterUserId,
    required this.waterGlass,
    required this.waterDate,
    required this.waterTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'waterUserId': waterUserId,
      'waterGlass': waterGlass,
      'waterDate': waterDate,
      'waterTime': waterTime,
    };
  }

  factory WaterModel.fromMap(Map<String, dynamic> map) {
    return WaterModel(
      id: map['id'],
      waterUserId: map['waterUserId'],
      waterGlass: map['waterGlass'],
      waterDate: map['waterDate'],
      waterTime: map['waterTime'],
    );
  }
}
