import 'package:dartz/dartz.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/model/add_financial_model.dart';
import 'package:edaray_applecation/constants.dart';
import 'package:edaray_applecation/core/errors/failures.dart';
import '../../../../core/services/hive_database.dart';
import '../../doman/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  HiveDatabase hiveDatabase;
  HomeRepoImp(this.hiveDatabase);
  @override
  Future<Either<Failure, List<AddFinancialModel>>> getFinancials() async {
    try {
      var data = hiveDatabase.getAddData<AddFinancialModel>(kFinancialsBox);
      return Right(data);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  void editFinancial(AddFinancialModel model) {
    try {
      hiveDatabase.addData(model, kEditFinancialsBox);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<AddFinancialModel>>>
      getFinancialsHistory() async {
    try {
      var data = hiveDatabase.getAddData<AddFinancialModel>(kEditFinancialsBox);
      return Right(data);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<void> addFinancial(AddFinancialModel model) async {
    try {
      hiveDatabase.addData(model, kFinancialsBox);
      hiveDatabase.addData(model, kEditFinancialsBox);
    } on Exception catch (e) {
      throw (Exception(e.toString()));
    }
  }
}
