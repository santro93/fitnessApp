import 'package:flutter/material.dart';
import 'package:urban_fit/assets/model/user_model.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
//getUserById
  DataBaseHelper? database;
  List<UserModel> usertable = [];
  // Future<void> refreshFoodTrackers() async {
  //   final List<UserModel> list = await database!.getUserById();
  //   setState(() {
  //     usertable = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: ('My Profile'),
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
      ),
      body: const Center(
        child: Text('No Data Available'),
      ),
    );
  }
}
