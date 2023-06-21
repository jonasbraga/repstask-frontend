import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return const InkWell(
      child: Icon(Icons.menu),
    );
  }
}
