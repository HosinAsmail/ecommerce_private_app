import 'package:flutter/material.dart';

class CustomHomeCard extends StatelessWidget {
  const CustomHomeCard({
    super.key,
    required this.appImageAsset,
    required this.text,
    required this.onTap,
  });
  final String appImageAsset;
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Image.asset(
                  appImageAsset,
                  height: 100,
                  width: 180,
                ),
                Text(text)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
