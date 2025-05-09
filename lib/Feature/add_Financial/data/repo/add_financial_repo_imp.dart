import 'package:dartz/dartz.dart';
import 'package:edaray_applecation/Feature/add_Financial/doman/entites/add_financial_entity.dart';
import 'package:edaray_applecation/Feature/add_Financial/doman/repo/add_financial_repo.dart';
import 'package:edaray_applecation/constants.dart';
import 'package:edaray_applecation/core/errors/failures.dart';

import '../../../../core/services/hive_database.dart';
import '../model/add_financial_model.dart';

class AddFinancialRepoImp implements AddFinancialRepo {
  final HiveDatabase hiveDatabase;

  AddFinancialRepoImp(this.hiveDatabase);

  @override
  Future<Either<Failure, void>> addFinancial(AddFinancialEntity entity) async {
    try {
      await hiveDatabase.addData(
          AddFinancialModel.fromEntity(entity), kFinancialsBox);
      await hiveDatabase.addData(
          AddFinancialModel.fromEntity(entity), kEditFinancialsBox);
      return const Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
