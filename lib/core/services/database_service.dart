
import '../../Feature/add_Financial/data/model/add_financial_model.dart';

abstract class DatabaseService {
  addData(AddFinancialModel model, String boxName);
  List<T> getAddData<T>( String boxName);
}