import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  String title;
  Icon leadingIcon;
  DefaultAppBar({required this.title, required this.leadingIcon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () => Navigator.pop(context), icon: leadingIcon),
      elevation: 1,
      title: Text(
        'Change $title',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
