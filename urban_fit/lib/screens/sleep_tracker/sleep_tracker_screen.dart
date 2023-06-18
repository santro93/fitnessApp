import 'package:flutter/material.dart';
import 'package:urban_fit/model/sleep_tracker_model.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/screens/sleep_tracker/add_sleep_track_bottomsheet.dart';
import 'package:urban_fit/screens/sleep_tracker/update_sleep_track_bottomsheet.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

class SleepTrackerScreen extends StatefulWidget {
  int? userId;
  SleepTrackerScreen({super.key, required this.userId});

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  DataBaseHelper? database;
  List<SleepModel> sleepTrackers = [];

  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
    refreshSleepTrackers();
  }

  Future<void> refreshSleepTrackers() async {
    final List<SleepModel> list =
        await database!.queryAllSleepTrackerEntitis(widget.userId!);
    setState(() {
      sleepTrackers = list;
    });
  }

  Future<void> deleteSleepTracker(int id) async {
    await database!.deleteSleepTrackerEntity(id);
    refreshSleepTrackers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: ('Sleep Tracker Screen'),
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
            onPressed: _onClickSleepTrackerBottomSheet,
            icon: const Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sleepTrackers.length,
        itemBuilder: (context, index) {
          final sleepTracker = sleepTrackers[index];
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
                      Text('Sleep Id: ${sleepTracker.id}'),
                      const SizedBox(height: 10),
                      Text('Sleep Time: ${sleepTracker.sleepTime}'),
                      const SizedBox(height: 10),
                      Text('Wakeup Time: ${sleepTracker.wakeUpTime}'),
                      const SizedBox(height: 10),
                      Text('Date: ${sleepTracker.sleepDate}'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _onClickUpdateSleepTrackerBottomSheet(
                              sleepId: sleepTracker.id!);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteSleepTracker(sleepTracker.id!);
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

  Future<void> _onClickSleepTrackerBottomSheet() async {
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
            child: SleepTrackerBottomSheet(
              userId: widget.userId,
              addtrack: () {
                refreshSleepTrackers();
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _onClickUpdateSleepTrackerBottomSheet({
    int? sleepId,
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
            child: UpdateSleepTrackBottomSheet(
              addtrack: () {
                refreshSleepTrackers();
              },
              userId: widget.userId,
              sleepId: sleepId,
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
