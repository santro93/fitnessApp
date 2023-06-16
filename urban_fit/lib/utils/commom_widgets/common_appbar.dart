import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool? isBackButtonEnabled;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.backgroundColor,
    this.isBackButtonEnabled,  this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text(title),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      leading:leading,
      actions: actions,
      backgroundColor: backgroundColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
