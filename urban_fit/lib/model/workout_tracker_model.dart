class WorkoutModel {
  final int? id;
  final int? workUserId;
  final String workoutName;
  final String workoutDate;
  final String workoutTime;

  WorkoutModel({
    this.id,
    required this.workUserId,
    required this.workoutName,
    required this.workoutDate,
    required this.workoutTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workUserId': workUserId,
      'workoutName': workoutName,
      'workoutDate': workoutDate,
      'workoutTime': workoutTime,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'],
      workUserId: map['workUserId'],
      workoutName: map['workoutName'],
      workoutDate: map['workoutDate'],
      workoutTime: map['workoutTime'],
    );
  }
}
