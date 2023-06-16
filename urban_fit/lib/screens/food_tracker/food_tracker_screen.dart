import 'package:flutter/material.dart';
import 'package:urban_fit/model/food_tracker_model.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/screens/food_tracker/add_food_track_bottomsheet.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

class FoodTrackerScreen extends StatefulWidget {
  int? userId;
  FoodTrackerScreen({super.key, required this.userId});

  @override
  State<FoodTrackerScreen> createState() => _FoodTrackerScreenState();
}

class _FoodTrackerScreenState extends State<FoodTrackerScreen> {
  DataBaseHelper? database;
  List<FoodModel> foodTrackers = [];

  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
    refreshFoodTrackers();
  }

  Future<void> refreshFoodTrackers() async {
    final List<FoodModel> list =
        await database!.getFoodTrackers(widget.userId!);
    setState(() {
      foodTrackers = list;
    });
  }

  void updateFoodTracker(int id) async {
    final FoodModel updatedFoodTracker = FoodModel(
      // userid: '2',
      foodname: 'Banana',
      unit: '1 piece',
      date: '2023-06-15',
      time: '3:00 PM',
    );

    await database!.updateFoodTracker(updatedFoodTracker);
    refreshFoodTrackers();
  }

  Future<void> deleteFoodTracker(int id) async {
    await database!.deleteFoodTracker(id);
    refreshFoodTrackers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: ('Food Tracker Screen'),
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
            onPressed: _onClickFoodTrackerBottomSheet,
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: foodTrackers.length,
        itemBuilder: (context, index) {
          final foodTracker = foodTrackers[index];
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
                      Text(foodTracker.foodname),
                      const SizedBox(height: 10),
                      Text('Unit: ${foodTracker.unit}'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updateFoodTracker(foodTracker.id!);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteFoodTracker(foodTracker.id!);
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

  Future<void> _onClickFoodTrackerBottomSheet() async {
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
            child: FoodTrackBottomSheet(
              userId: widget.userId,
              addtrack: () {
                refreshFoodTrackers();
              },
            ),
          ),
        );
      },
    );
  }

  // Future<void> _onClickUpdateFoodTrackerBottomSheet() async {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     context: context,
  //     builder: (BuildContext bct) {
  //       return Container(
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //         ),
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //         child: SafeArea(
  //           child: FoodTrackBottomSheet(
  //             addtrack: () {
  //               refreshFoodTrackers();
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
