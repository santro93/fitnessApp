import 'package:flutter/material.dart';
import 'package:urban_fit/model/water_tracker_model.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/screens/water_tracker/water_track_bottomsheet.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

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
    final List<WaterModel> list = await database!.queryAllWaterTrackerEntitis();
    setState(() {
      waterTrackers = list;
    });
  }

  void updateWaterTracker(int id) async {
    final WaterModel updatedWaterTracker = WaterModel(
      id: 2,
      waterUserId: '2',
      waterDate: '2023-06-15',
      waterTime: '3:00 PM',
      waterGlass: 'f24',
    );

    await database!.updateWaterTrackerEntity(updatedWaterTracker);
    refreshWaterTrackers();
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
                  builder: (context) => const DashboardScreen(),
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
                      Text(
                          'Water glasses drink date is : ${waterTracker.waterDate}'),
                      const SizedBox(height: 10),
                      Text(
                          'Water glasses quantity is : ${waterTracker.waterGlass}'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          updateWaterTracker(waterTracker.id!);
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
              addtrack: () {
                refreshWaterTrackers();
              },
            ),
          ),
        );
      },
    );
  }
}
