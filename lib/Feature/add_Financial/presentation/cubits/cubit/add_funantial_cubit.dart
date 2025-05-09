import 'package:bloc/bloc.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/repo/add_financial_repo_imp.dart';
import 'package:edaray_applecation/Feature/add_Financial/doman/entites/add_financial_entity.dart';
import 'package:meta/meta.dart';
part 'add_funantial_state.dart';

class AddFunantialCubit extends Cubit<AddFunantialState> {
  
  final AddFinancialRepoImp addFinancialRepoImp;

  AddFunantialCubit(this.addFinancialRepoImp) : super(AddFunantialInitial());

  Future addAddFinancial(AddFinancialEntity entity) async {
    var x = await addFinancialRepoImp.addFinancial(entity);
    x.fold((l) => emit(AddFunantialFailure(error: l.message)),
        (r) => emit(AddFunantialSeuccess()));
  }
}
