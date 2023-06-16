import 'package:flutter/material.dart';
import 'package:urban_fit/model/sleep_tracker_model.dart';
import 'package:urban_fit/service/database_helper.dart';

class SleepTrackerBottomSheet extends StatefulWidget {
  int? userId;
  void Function() addtrack;
  SleepTrackerBottomSheet(
      {Key? key, required this.addtrack, required this.userId});
  @override
  State<SleepTrackerBottomSheet> createState() => _SleepTrackBottomSheetState();
}

class _SleepTrackBottomSheetState extends State<SleepTrackerBottomSheet> {
  TextEditingController sleepTimeController = TextEditingController();
  TextEditingController wakeupTimeController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DataBaseHelper? database;
  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
  }

  Future<void> addWaterTracker() async {
    final SleepModel newSleepTracker = SleepModel(
      // id: 33,
      sleepUserId: widget.userId,
      sleepTime: sleepTimeController.text,
      wakeUpTime: wakeupTimeController.text,
      sleepDate:
          '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
      // time: selectedTime!.format(context),
    );
    await database!.insertSleepTracker(newSleepTracker);
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
                    'Add Sleep Track ',
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
              controller: sleepTimeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter sleep Time",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: wakeupTimeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter wakeup Time",
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
                addWaterTracker();
              },
              child: const Text('Submit Info'),
            ),
          ],
        ),
      ],
    );
  }
}
