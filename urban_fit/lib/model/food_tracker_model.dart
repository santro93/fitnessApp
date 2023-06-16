class FoodModel {
  final int? id;
  final String userid;
  final String foodname;
  final String unit;
  final String date;
  final String time;

  FoodModel({
    this.id,
    required this.userid,
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
      'unit': unit,
      'date': date,
      'time': time,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      userid: map['userid'],
      foodname: map['foodname'],
      unit: map['unit'],
      date: map['date'],
      time: map['time'],
    );
  }
}
