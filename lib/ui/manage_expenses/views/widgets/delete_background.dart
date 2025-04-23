import 'package:flutter/material.dart';

class DeleteBackground extends StatelessWidget {
  const DeleteBackground({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    color: const Color.fromARGB(255, 196, 91, 91), // Red delete background
    padding: const EdgeInsets.symmetric(horizontal: 20),
    alignment: Alignment.centerRight, // Align to right edge
    child: const Row(
      mainAxisSize: MainAxisSize.min, // Take only needed space
      children: [
        Icon(Icons.delete, color: Colors.white),
        SizedBox(width: 8),
        Text(
          'Delete',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
}