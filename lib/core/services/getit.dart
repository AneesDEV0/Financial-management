import 'package:edaray_applecation/Feature/Home/data/repo/home_repo_imp.dart';
import 'package:get_it/get_it.dart';

import '../../Feature/add_Financial/data/repo/add_financial_repo_imp.dart';
import 'hive_database.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<HiveDatabase>(HiveDatabase());
  getIt.registerSingleton<AddFinancialRepoImp>(AddFinancialRepoImp(
    getIt<HiveDatabase>(),
  ));
  getIt.registerSingleton<HomeRepoImp>(HomeRepoImp(
    getIt<HiveDatabase>(),
  ));
}
