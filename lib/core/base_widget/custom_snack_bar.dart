import 'package:flutter/material.dart';

void showSnackBar(BuildContext context , String message , String status) {
  ScaffoldMessenger.of(context).showSnackBar(

    SnackBar(
      backgroundColor:status=="error" ? Colors.red  : Colors.green,
      content: Text(message),

      duration: const Duration(
          seconds: 3), // Optional: Set the duration for the SnackBar
    ),
  );
}