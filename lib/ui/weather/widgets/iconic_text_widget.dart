import 'package:flutter/material.dart';

class IconicTextWidget extends StatelessWidget {
  const IconicTextWidget(this.assets, this.title, this.info, {Key? key}) : super(key: key);

  final String assets;
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/$assets.png"),
            height: 35,
            width: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 10, color: Colors.black45, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    info,
                    style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
