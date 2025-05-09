import 'package:edaray_applecation/Feature/Home/data/repo/home_repo_imp.dart';
import 'package:edaray_applecation/Feature/add_Financial/data/repo/add_financial_repo_imp.dart';
import 'package:edaray_applecation/Feature/add_Financial/doman/repo/add_financial_repo.dart';
import 'package:edaray_applecation/core/services/app_services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/slider_enum.dart';
import '../../../../add_Financial/data/model/add_financial_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImp homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());
  bool isDarkMode = prefs.getBool('mode') ?? false;
  List<AddFinancialModel> listOfData = [];
  List<AddFinancialModel> listOfFinancialsHistory = [];
  List<AddFinancialModel> filteredData = [];
  List<AddFinancialModel> selectedItems = [];

  SortOrderEnum selectedSortType = SortOrderEnum.FirstToNewset;
  SortOrderEnum selectedSortOrder = SortOrderEnum.FirstToNewset;
  DateTime? rangeStartDate;
  DateTime? rangeEndDate;
  DateTime? startDate;
  DateTime? endDate;
  final FocusNode focusNode = FocusNode();
  bool isSelectedMode = false;

  void changeTheme() {
    isDarkMode = !isDarkMode;
    prefs.setBool('mode', isDarkMode);
    emit(HomeSeuccess());
  }

  Future getAllData() async {
    emit(HomeLoading());
    var data = await homeRepo.getFinancials();
    data.fold((l) => emit(HomeFailure(l.message)), (r) {
      listOfData = r;
      // filteredData = listOfData;
      filteredData = r;
      if (listOfData.isEmpty) {
        emit(HomeInitial());
      } else {
        emit(HomeSeuccess());
      }
    });
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredData = listOfData; // Reset to full data if search query is empty
    } else {
      filteredData = listOfData.where((element) {
        // Check supplier name and financial number And projectType
        if (element.supplierName.contains(query) ||
            element.projectType.toLowerCase() == query.toLowerCase() ||
            element.funantialNo.contains(query) ||
            element.category!
                .toLowerCase()
                .contains(query.split('%').last.toString())) {
          return true;
        }

        DateTime financialDate = element.financialDate;

        if (query.startsWith('/') && query.length == 5) {
          int year = int.parse(query.substring(1));
          return financialDate.year == year;
        }

        List<String> dateParts = query.split('/');

        if (dateParts.length == 2) {
          // Search by month/year (e.g., "4/2012")
          int month = int.parse(dateParts[0]);
          int year = int.parse(dateParts[1]);
          return financialDate.month == month && financialDate.year == year;
        } else if (dateParts.length == 3) {
          // Search by day/month/year (e.g., "22/4/2012")
          int day = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int year = int.parse(dateParts[2]);
          return financialDate.day == day &&
              financialDate.month == month &&
              financialDate.year == year;
        }

        return false;
      }).toList();
    }

    if (filteredData.isEmpty) {
      emit(HomeSearchNoResults());
    } else {
      emit(HomeSeuccess());
    }
  }

  void getHistory() async {
    emit(HomeLoading());
    var data = await homeRepo.getFinancialsHistory();
    data.fold((l) => emit(HomeFailure(l.message)), (r) {
      listOfFinancialsHistory = r;
      emit(HomeSeuccess());
    });
  }

  Future add(AddFinancialModel model) async {
    await homeRepo.addFinancial(model);
    // filteredData.add(model);
    listOfData.add(model);
    emit(HomeSeuccess());
  }

  void edit(AddFinancialModel model) {
    model.save();
    homeRepo.editFinancial(model);
    emit(HomeSeuccess());
  }

  void dealte(
      AddFinancialModel model, List<AddFinancialModel>? selected) async {
    // First dealete from home
    if (selected != null) {
      for (var model in selected) {
        model.delete();
      }
    } else {
      model.delete();
    }
    // First dealete from History
    var data = await homeRepo.getFinancialsHistory();
    data.fold((l) => emit(HomeFailure(l.message)), (r) {
      r
          .where((element) => element.funantialNo == model.funantialNo)
          .forEach((element) {
        element.delete();
      });
    });
    if (selected != null) {
      for (var element in selected) {
        listOfData.remove(element);
      }
    } else {
      listOfData.remove(model);
    }
    if (listOfData.isEmpty) {
      emit(HomeInitial());
    } else {
      emit(HomeSeuccess());
    }
  }

  void sort() {
    if (selectedSortType == SortOrderEnum.FirstToNewset) {
      filteredData.sort((a, b) => a.financialDate.compareTo(b.financialDate));
    } else if (selectedSortType == SortOrderEnum.NewsetFirst) {
      filteredData.sort((a, b) => b.financialDate.compareTo(a.financialDate));
    } else if (selectedSortType == SortOrderEnum.ATZ) {
      filteredData.sort((a, b) => a.supplierName.compareTo(b.supplierName));
    } else if (selectedSortType == SortOrderEnum.RangeDate &&
        rangeStartDate != null &&
        rangeEndDate != null) {
      filteredData = listOfData.where((item) {
        return item.financialDate
                .isAfter(rangeStartDate!.subtract(const Duration(days: 0))) &&
            item.financialDate
                .isBefore(rangeEndDate!.add(const Duration(days: 365)));
      }).toList();
    }
    if (filteredData.isEmpty) {
      emit(HomeSearchNoResults());
    } else {
      emit(HomeSeuccess());
    }
  }

  // void enableSelectMode() {
  //   isSelectedMode = !isSelectedMode;
  //   selectedItems.clear();
  //   emit(HomeSeuccess());
  // }
  void enableSelectMode() {
    if (isSelectedMode && selectedItems.isEmpty) {
      // If in selection mode and no items are selected, turn off the selection mode
      isSelectedMode = false;
    } else {
      // Otherwise, toggle the selection mode
      isSelectedMode = !isSelectedMode;
    }
    emit(HomeSeuccess());
  }

  void toggleItemSelection(int index) {
    if (selectedItems.contains(filteredData[index])) {
      selectedItems.remove(filteredData[index]);
    } else {
      selectedItems.add(filteredData[index]);
    }

    // Check if the list is empty, and if so, disable selection mode
    if (selectedItems.isEmpty) {
      isSelectedMode = false;
    }

    emit(HomeSeuccess());
  }

  void selectAll() {
    if (selectedItems.length == filteredData.length) {
      // If all items are already selected, deselect all
      selectedItems.clear();
      isSelectedMode =
          false; // Turn off selection mode when no items are selected
    } else {
      // Otherwise, select all items
      selectedItems =
          List.generate(filteredData.length, (index) => filteredData[index]);
      isSelectedMode = true; // Make sure selection mode is on
    }
    emit(HomeSeuccess());
  }

  // void disableSelectionMode() {
  //   selectedItems.clear();
  //   isSelectedMode = false;
  //   emit(HomeLoading());
  //   emit(HomeSeuccess());
  // }
}


//امر توريد
