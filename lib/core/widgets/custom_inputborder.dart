import 'package:flutter/material.dart';

OutlineInputBorder customInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
    // borderSide: BorderSide(color: Color(0xffE6E9EA)),
  );
}
