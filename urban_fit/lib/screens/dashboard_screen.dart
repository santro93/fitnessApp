import 'package:flutter/material.dart';
import 'package:urban_fit/screens/food_tracker/food_tracker_screen.dart';
import 'package:urban_fit/screens/sleep_tracker/sleep_tracker_screen.dart';
import 'package:urban_fit/screens/user_profile.dart';
import 'package:urban_fit/screens/workout_tracker/workout_tracker_screen.dart';
import 'package:urban_fit/utils/appimages.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';
import 'water_tracker/water_tracker_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'Dashboard',
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _getDashboardWidget(),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const ListTile(
              title: Text(
                'Urban Fit',
                style: TextStyle(fontSize: 30),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'My Profile',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(),
                  ),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDashboardWidget() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        buildDashboardWidget(
          title: 'Foods Tracker',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const FoodTrackerScreen(),
              ),
            );
          },
          image: AppImages.foodTracker(),
        ),
        buildDashboardWidget(
          title: 'Water Tracker',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WaterTrackerScreen(),
              ),
            );
          },
          image: AppImages.waterTracker(),
        ),
        buildDashboardWidget(
          title: 'Workout Tracker',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WorkoutTrackerScreen(),
              ),
            );
          },
          image: AppImages.workoutTracker(),
        ),
        buildDashboardWidget(
          title: 'Sleep Tracker',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SleepTrackerScreen(),
              ),
            );
          },
          image: AppImages.sleepTracker(),
        ),
      ],
    );
  }

  Widget buildDashboardWidget({
    String? title,
    ImageProvider? image,
    required void Function() onTap,
  }) {
    return Card(
      color: Colors.blue.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: image,
            ),
            Text(
              title!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.add_circle_outline_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
