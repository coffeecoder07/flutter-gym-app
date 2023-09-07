import 'package:flutter/material.dart';
import 'package:gymapp/UI/Components/CustomButton.dart';




class NoPermission extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final String heading;
  final String description;
  const NoPermission({Key? key,required this.label,required this.onPressed,required this.heading,required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 24.0,
              right: 16.0,
            ),
            child: Text(
              heading,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 24.0,
              right: 16.0,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 16.0, top: 24.0, right: 16.0, bottom: 24.0),
            child: CustomButton(
              label: label,
              backgroundColor: Theme.of(context).primaryColor,onTap: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
