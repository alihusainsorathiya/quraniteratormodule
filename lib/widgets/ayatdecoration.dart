import 'package:flutter/material.dart';

class AyatDecoration extends StatelessWidget {
  const AyatDecoration({
    Key? key,
    required this.sizeNumbering,
    required this.text,
  }) : super(key: key);

  final double sizeNumbering;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeNumbering,
      height: sizeNumbering,
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          SizedBox(
            width: sizeNumbering,
            height: sizeNumbering,
            child: Image.asset(
              "assets/images/number.png",
              color: Colors.blue.shade400,
            ),
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
