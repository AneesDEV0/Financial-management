import 'package:dartz/dartz.dart';
import 'package:edaray_applecation/Feature/add_Financial/doman/entites/add_financial_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class AddFinancialRepo {
  Future<Either<Failure, void>> addFinancial(AddFinancialEntity entity);
}
