import 'package:flutter/material.dart';

class MachineItem extends StatelessWidget {
  final String title;
  final String status;
  final double size;

  MachineItem({
    required this.title,
    required this.status,
    this.size = 80
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: size,
      height: size,
      child: Column(
        children: [
          if (status != "")
            Container(
              color: Colors.red,
              child: Text(status),
            ),
          Text(title),
        ],
      ),
    );
  }
}
