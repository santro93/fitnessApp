import 'package:flutter/material.dart';
import 'package:urban_fit/assets/model/user_model.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

class UserProfileScreen extends StatefulWidget {
  int? userId;
  UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
//getUserById
  DataBaseHelper? database;
  UserModel? usertable;

  Future<void> refreshUserData() async {
    UserModel? list = await database!.getUserById(widget.userId!);
    setState(() {
      usertable = list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = DataBaseHelper.instance;
    refreshUserData();
  }

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
                  builder: (context) => DashboardScreen(userId: widget.userId),
                ));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(98.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('My id: ${usertable!.id }'),
            const SizedBox(
              height: 20,
            ),
            Text('My Name: ${usertable!.name}'),
            const SizedBox(
              height: 20,
            ),
            Text('My email Id: ${usertable!.email}'),
            const SizedBox(
              height: 20,
            ),
            Text('My Mobile No: ${usertable!.mobile}'),
          ],
        ),
      ),
    );
  }
}
