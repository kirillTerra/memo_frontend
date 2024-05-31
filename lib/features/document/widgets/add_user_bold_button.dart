import 'package:flutter/material.dart';

class AddUserBoldButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddUserBoldButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.blue,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
