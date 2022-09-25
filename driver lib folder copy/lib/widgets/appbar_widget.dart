
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver/themes.dart';

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [

    ],
  );
}
