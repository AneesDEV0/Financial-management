import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Widget child;
  const CircleIcon({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            // color: AppColor.green50,
            color: Theme.of(context).colorScheme.secondaryContainer,

            shape: const OvalBorder(),
          ),
          child: child),
    );
  }
}
