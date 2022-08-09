import 'package:flutter/material.dart';

class UpdatedWidget extends StatelessWidget {
  const UpdatedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Update",
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
