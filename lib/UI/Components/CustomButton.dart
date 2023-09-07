import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Function()? onTap;
  const CustomButton({super.key, required this.label,this.backgroundColor,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(1000),
      color: backgroundColor,
      child: InkWell(
        onTap:onTap,
        borderRadius: BorderRadius.circular(1000),
        child: SizedBox(
          height: 50,
            child: Center(
              child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16,color: Colors.white),
        ),
            )),
      ),
    );
  }
}
