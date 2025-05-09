import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../add_Financial/data/model/add_financial_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<AddFinancialModel>>> getFinancials();
  Future<Either<Failure, List<AddFinancialModel>>> getFinancialsHistory();
  void editFinancial(AddFinancialModel model);
  Future<void> addFinancial(AddFinancialModel model);
}
