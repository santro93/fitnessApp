import 'package:flutter/material.dart';
import 'package:urban_fit/model/food_tracker_model.dart';
import 'package:urban_fit/service/database_helper.dart';

class AddFoodTrackBottomSheet extends StatefulWidget {
  int? userId;
  void Function() addtrack;
  AddFoodTrackBottomSheet(
      {Key? key, required this.addtrack, required this.userId})
      : super(key: key);
  @override
  State<AddFoodTrackBottomSheet> createState() =>
      _AddFoodTrackBottomSheetState();
}

class _AddFoodTrackBottomSheetState extends State<AddFoodTrackBottomSheet> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodUnitController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DataBaseHelper? database;
  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
  }

  Future<void> addFoodTracker() async {
    final FoodModel newFoodTracker = FoodModel(
      userid: widget.userId,
      foodname: foodNameController.text,
      unit: foodUnitController.text,
      date: '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
      time: selectedTime!.format(context),
    );
    await database!.insertFoodTracker(newFoodTracker);
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

  // void updateFoodTracker(int id) async {
  //   final FoodModel updatedFoodTracker = FoodModel(
  //     userid: '2',
  //     foodname: foodNameController.text,
  //     unit: foodUnitController.text,
  //     date: '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
  //     time: selectedTime!.format(context),
  //   );

  //   await database!.updateFoodTracker(updatedFoodTracker);

  //   widget.addtrack();
  //   Navigator.pop(context);
  // }

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
                    'Add Food Track ',
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
              controller: foodNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Food Name",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: foodUnitController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Food Unit",
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
                addFoodTracker();
              },
              child: const Text('Submit Info'),
            ),
          ],
        ),
      ],
    );
  }
}
