import 'package:flutter/material.dart';

class StatsItem extends StatelessWidget {
  final String items;
  final IconData icon;
  final String numbers;
  final Color color;

  const StatsItem({
    super.key,
    required this.items,
    required this.icon,
    required this.numbers,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.8), blurRadius: 5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 35, color: Colors.white),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  items,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  numbers,
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
