import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: const [
          CupertinoActivityIndicator(
            animating: true,
            color: Colors.white,
            radius: 7,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Updating...",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
