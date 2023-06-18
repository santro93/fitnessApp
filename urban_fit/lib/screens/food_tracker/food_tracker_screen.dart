import 'package:flutter/material.dart';
import 'package:urban_fit/model/food_tracker_model.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/screens/food_tracker/add_food_track_bottomsheet%20copy.dart';
import 'package:urban_fit/screens/food_tracker/update_food_track_bottomsheet.dart';
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
    print(foodTrackers.length);
  }

  Future<void> deleteFoodTracker(int id) async {
    await database!.deleteFoodTracker(id);
    refreshFoodTrackers();
    setState(() {});
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
            onPressed: _onClickAddFoodTrackerBottomSheet,
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
                      Text('Food Id: ${foodTracker.id}'),
                      const SizedBox(height: 10),
                      Text('Food Name: ${foodTracker.foodname}'),
                      const SizedBox(height: 10),
                      Text('Unit: ${foodTracker.unit}'),
                      const SizedBox(height: 10),
                      Text(
                          'Date: ${foodTracker.date} At Time: ${foodTracker.time}'),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _onClickUpdateFoodTrackerBottomSheet(
                            foodId: foodTracker.id!,
                            // foodname: foodTracker.foodname,
                            // foodunit: foodTracker.unit,
                            // fooddate: foodTracker.date,
                            // foodtime: foodTracker.date,
                          );
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

  Future<void> _onClickAddFoodTrackerBottomSheet() async {
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
            child: AddFoodTrackBottomSheet(
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

  Future<void> _onClickUpdateFoodTrackerBottomSheet({
    int? foodId,
    // String? foodname,
    // String? fooddate,
    // String? foodtime,
    // String? foodunit
  }) async {
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
            child: UpdateFoodTrackBottomSheet(
              addtrack: () {
                refreshFoodTrackers();
              },
              userId: widget.userId,
              foodId: foodId,
              // foodname: foodname,
              // fooddate: fooddate,
              // foodtime: foodtime,
              // foodunit: foodunit,
            ),
          ),
        );
      },
    );
  }
}
