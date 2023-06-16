import 'package:flutter/material.dart';
import 'package:urban_fit/model/workout_tracker_model.dart';
import 'package:urban_fit/screens/workout_tracker/workout_track_bottomsheet.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

import '../dashboard_screen.dart';

class WorkoutTrackerScreen extends StatefulWidget {
  int? userId;
  WorkoutTrackerScreen({super.key, required this.userId});

  @override
  State<WorkoutTrackerScreen> createState() => _WorkoutTrackerScreenState();
}

class _WorkoutTrackerScreenState extends State<WorkoutTrackerScreen> {
  DataBaseHelper? database;
  List<WorkoutModel> workTrackers = [];

  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
    refreshWorkoutTrackers();
  }

  Future<void> refreshWorkoutTrackers() async {
    final List<WorkoutModel> list =
        await database!.queryAllWorkoutTrackerEntitis(widget.userId!);
    setState(() {
      workTrackers = list;
    });
  }

  void updateWorkoutTracker(int id) async {
    final WorkoutModel updatedWorkoutTracker = WorkoutModel(
      id: 2,
      workUserId: widget.userId,
      workoutName: 'Dum Bells',
      workoutTime: '3:00 PM',
      workoutDate: '2023-06-15',
    );

    await database!.updateWorkoutTrackerEntity(updatedWorkoutTracker);
    refreshWorkoutTrackers();
  }

  Future<void> deleteWorkoutTracker(int id) async {
    await database!.deleteWorkoutTrackerEntity(id);
    refreshWorkoutTrackers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: ('Work Tracker Screen'),
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(userId: widget.userId),
                ));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _onClickWorkoutTrackerBottomSheet,
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: workTrackers.length,
        itemBuilder: (context, index) {
          final workoutTracker = workTrackers[index];
          return Card(
            color: const Color(0xFFF5F7FE),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Workout Name is: ${workoutTracker.workoutName}'),
                      const SizedBox(height: 10),
                      Text('Workout Date is: ${workoutTracker.workoutDate}'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updateWorkoutTracker(workoutTracker.id!);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteWorkoutTracker(workoutTracker.id!);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onClickWorkoutTrackerBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bct) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SafeArea(
            child: WorkoutTrackBottomSheet(
              userId: widget.userId,
              addtrack: () {
                refreshWorkoutTrackers();
              },
            ),
          ),
        );
      },
    );
  }
}
