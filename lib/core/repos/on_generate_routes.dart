import 'package:edaray_applecation/Feature/Home/presentation/view/home_view.dart';
import 'package:edaray_applecation/Feature/Home/presentation/view/settings_view.dart';
import 'package:edaray_applecation/Feature/add_Financial/presentation/view/add_financial_view.dart';
import 'package:flutter/material.dart';

import '../../test.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case AddFinancialView.routeName:
      return MaterialPageRoute(builder: (context) => const AddFinancialView());
    case SettingView.routeName:
      return MaterialPageRoute(builder: (context) => const SettingView());
    default:
      return MaterialPageRoute(builder: (context) => const TestView());
  }
}
