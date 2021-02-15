import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Remove',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
