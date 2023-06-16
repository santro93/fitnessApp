import 'package:flutter/material.dart';
import 'package:urban_fit/model/water_tracker_model.dart';
import 'package:urban_fit/service/database_helper.dart';

class WaterTrackBottomSheet extends StatefulWidget {
  void Function() addtrack;
  WaterTrackBottomSheet({Key? key, required this.addtrack}) : super(key: key);
  @override
  State<WaterTrackBottomSheet> createState() => _WaterTrackBottomSheetState();
}

class _WaterTrackBottomSheetState extends State<WaterTrackBottomSheet> {
  TextEditingController waterNameController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DataBaseHelper? database;
  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
  }

  Future<void> addWaterTracker() async {
    final WaterModel newWaterTracker = WaterModel(
      // id: 33,
      waterUserId: '1',
      waterGlass: waterNameController.text,
      waterDate:
          '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
      waterTime: selectedTime!.format(context),
    );
    await database!.insertWaterTrackerEntity(newWaterTracker);
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
                    'Add Water Track ',
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
              controller: waterNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Water Glass Quantity",
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
