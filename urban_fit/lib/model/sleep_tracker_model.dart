class SleepModel {
  final int? id;
  final int? sleepUserId;
  final String sleepTime;
  final String wakeUpTime;
  final String sleepDate;

  SleepModel({
    this.id,
    required this.sleepUserId,
    required this.sleepTime,
    required this.wakeUpTime,
    required this.sleepDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sleepUserId': sleepUserId,
      'sleepTime': sleepTime,
      'wakeUpTime': wakeUpTime,
      'sleepDate': sleepDate,
    };
  }

  factory SleepModel.fromMap(Map<String, dynamic> map) {
    return SleepModel(
      id: map['id'],
      sleepUserId: map['sleepUserId'],
      sleepTime: map['sleepTime'],
      wakeUpTime: map['wakeUpTime'],
      sleepDate: map['sleepDate'],
    );
  }
}
