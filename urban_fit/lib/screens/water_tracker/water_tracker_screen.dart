import 'package:flutter/material.dart';
import 'package:urban_fit/model/water_tracker_model.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/screens/water_tracker/update_water_track_bottomsheet.dart';
import 'package:urban_fit/screens/water_tracker/add_water_track_bottomsheet.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

class WaterTrackerScreen extends StatefulWidget {
  int? userId;
  WaterTrackerScreen({super.key, required this.userId});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  DataBaseHelper? database;
  List<WaterModel> waterTrackers = [];

  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
    refreshWaterTrackers();
  }

  Future<void> refreshWaterTrackers() async {
    final List<WaterModel> list =
        await database!.queryAllWaterTrackerEntitis(widget.userId!);
    setState(() {
      waterTrackers = list;
    });
  }

  Future<void> deleteWaterTracker(int id) async {
    await database!.deleteWaterTrackerEntity(id);
    refreshWaterTrackers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: ('Water Tracker Screen'),
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
            onPressed: _onClickWaterTrackerBottomSheet,
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: waterTrackers.length,
        itemBuilder: (context, index) {
          final waterTracker = waterTrackers[index];
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
                      Text('Water glasses drink Id: ${waterTracker.id}'),
                      const SizedBox(height: 10),
                      Text(
                          'Water glasses quantity: ${waterTracker.waterGlass}'),
                      const SizedBox(height: 10),
                      Text(
                          'Date: ${waterTracker.waterDate} At Time: ${waterTracker.waterTime}'),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _onClickUpdateWaterTrackerBottomSheet(
                              waterId: waterTracker.id!);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteWaterTracker(waterTracker.id!);
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

  Future<void> _onClickWaterTrackerBottomSheet() async {
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
            child: WaterTrackBottomSheet(
              userId: widget.userId,
              addtrack: () {
                refreshWaterTrackers();
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _onClickUpdateWaterTrackerBottomSheet({
    int? waterId,
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
            child: UpdateWaterTrackBottomSheet(
              addtrack: () {
                refreshWaterTrackers();
              },
              userId: widget.userId,
              waterId: waterId,
            ),
          ),
        );
      },
    );
  }
}
