import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

late SharedPreferences prefs;

class AppServices {
  static Future initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(AddFinancialModelAdapter());
    await Hive.openBox<AddFinancialModel>(kFinancialsBox);
    await Hive.openBox<AddFinancialModel>(kEditFinancialsBox);
  }

  static Future initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}
