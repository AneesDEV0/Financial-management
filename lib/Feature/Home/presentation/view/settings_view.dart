import 'package:flutter/material.dart';

import 'widgets/settings_view_body.dart';

class SettingView extends StatelessWidget {
  static const String routeName = "settingsView";
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingViewBody();
  }
}
