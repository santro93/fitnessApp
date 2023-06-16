import 'package:flutter/material.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
