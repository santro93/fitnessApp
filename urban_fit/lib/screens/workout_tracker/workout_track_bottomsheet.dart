import 'package:flutter/material.dart';
import 'package:urban_fit/model/workout_tracker_model.dart';
import 'package:urban_fit/service/database_helper.dart';


class WorkoutTrackBottomSheet extends StatefulWidget {
  int? userId;
  void Function() addtrack;
  WorkoutTrackBottomSheet({Key? key, required this.addtrack, required this.userId});
  @override
  State<WorkoutTrackBottomSheet> createState() =>
      _WorkoutTrackBottomSheetState();
}

class _WorkoutTrackBottomSheetState extends State<WorkoutTrackBottomSheet> {
  TextEditingController workoutNameController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DataBaseHelper? database;
  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
  }

  Future<void> addWorkTracker() async {
    final WorkoutModel newWorkTracker = WorkoutModel(
      // id: 33,
      workUserId: widget.userId,
      workoutName: workoutNameController.text,
      workoutDate:
          '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
      workoutTime: selectedTime!.format(context),
    );
    await database!.insertWorkoutTrackerEntity(newWorkTracker);
    widget.addtrack();
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Add Workout Track ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: workoutNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter workout Name",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select Date'),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: const Text('Select Time'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Selected Date: ${selectedDate != null ? '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}' : 'Not selected'}',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Selected Time: ${selectedTime != null ? selectedTime!.format(context) : 'Not selected'}',
            ),
            //  Navigator.pop(context);
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                addWorkTracker();
              },
              child: const Text('Submit Info'),
            ),
          ],
        ),
      ],
    );
  }
}
