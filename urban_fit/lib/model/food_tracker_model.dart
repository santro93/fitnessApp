class FoodModel {
  final int? id;
  final int? userid;
  final String foodname;
  final String unit;
  final String date;
  final String time;

  FoodModel({
    this.id,
    this.userid,
    required this.foodname,
    required this.unit,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'foodname': foodname,
      'foodunit': unit,
      'fooddate': date,
      'foodtime': time,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      userid: map['userid'],
      foodname: map['foodname'],
      unit: map['foodunit'],
      date: map['fooddate'],
      time: map['foodtime'],
    );
  }
}
