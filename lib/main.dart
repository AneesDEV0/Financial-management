import 'dart:io';
import 'package:edaray_applecation/Feature/Home/data/repo/home_repo_imp.dart';
import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/repo/add_financial_repo_imp.dart';
import 'package:edaray_applecation/core/classes/theams.dart';
import 'package:edaray_applecation/core/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';
import 'Feature/Home/presentation/view/home_view.dart';
import 'core/repos/on_generate_routes.dart';
import 'core/services/bloc_observer_service.dart';
import 'core/services/getit.dart';

void main() async {
  await AppServices.initHive();
  await AppServices.initSharedPreferences();
  setupLocator();
  Bloc.observer = CustomBlocObserver();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(1200, 600));
  }
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => HomeCubit(getIt<HomeRepoImp>()),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Financial management',
          debugShowCheckedModeBanner: false,
          locale: const Locale("ar"),
          theme: Theams.lightTheam,
          darkTheme: Theams.darkTheam,
          themeMode:
              prefs.getBool('mode') ?? context.watch<HomeCubit>().isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
          onGenerateRoute: onGenerateRoute,
          initialRoute: HomeView.routeName,
        );
      },
    );
  }
}
