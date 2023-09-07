import 'package:flutter/material.dart';

class SuggestionListTile extends StatelessWidget {
  const SuggestionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey.shade200),
      child: const Row(
        children: [
          Icon(
            Icons.my_location_rounded,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Around Your Location",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
