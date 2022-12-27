import 'package:flutter/material.dart';

class HourItem extends StatelessWidget {
  final bool isActive;
  final String? title;
  final String? image;
  final num? temp;

  const HourItem(
      {Key? key,
      required this.isActive,
      required this.title,
      required this.temp,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: isActive
              ? Colors.blue.withOpacity(0.5)
              : Colors.pinkAccent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(isActive
              ? 'now'
              : (title ?? "").substring((title ?? "").indexOf(" ") + 1)),
          Image.network("https:${image ?? ""}"),
          Text((temp ?? 0)
              .toString()
              .substring(0, (temp ?? 0).toString().indexOf(".")))
        ],
      ),
    );
  }
}
