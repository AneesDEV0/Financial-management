import 'package:edaray_applecation/Feature/add_Financial/data/repo/add_financial_repo_imp.dart';
import 'package:edaray_applecation/core/services/getit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cubit/add_funantial_cubit.dart';
import 'widgets/add_financial_view_body.dart';

class AddFinancialView extends StatelessWidget {
  static const String routeName = "addFinancialView";

  const AddFinancialView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => AddFunantialCubit(
          getIt<AddFinancialRepoImp>(),
        ),
        child: const  AddFinancialViewBody(),
      ),
      // body: SearchableDropdown(),
    );
  }
}
/*

git config --global user.name "AneesDEV0"
git config --global user.email "aneesrafat0@gmail.com"


 */