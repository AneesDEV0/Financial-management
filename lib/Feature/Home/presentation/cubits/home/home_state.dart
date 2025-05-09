part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSeuccess extends HomeState {}

final class HomeFailure extends HomeState {
  final String errorMassage;

  HomeFailure(this.errorMassage);
}

final class HomeSearchNoResults extends HomeState {}

final class HomeSelectedList extends HomeState {}

class HomeThemeChanged extends HomeState {
  final bool isDarkMode;
  HomeThemeChanged(this.isDarkMode);
}
