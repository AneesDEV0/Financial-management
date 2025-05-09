part of 'add_funantial_cubit.dart';

@immutable
sealed class AddFunantialState {}

final class AddFunantialInitial extends AddFunantialState {}

final class AddFunantialSeuccess extends AddFunantialState {}

final class AddFunantialFailure extends AddFunantialState {

  final String error;
  AddFunantialFailure({required this.error});
}
