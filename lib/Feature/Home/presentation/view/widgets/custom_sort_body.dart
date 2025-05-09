import 'package:edaray_applecation/Feature/Home/presentation/cubits/home/home_cubit.dart';
import 'package:edaray_applecation/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/slider_enum.dart';


class SortingDialogBody extends StatefulWidget {
  const SortingDialogBody({super.key});

  @override
  State<SortingDialogBody> createState() => _SortingDialogBodyState();
}

class _SortingDialogBodyState extends State<SortingDialogBody> {
  final DateTime _minDate = DateTime(2010);
  final DateTime _maxDate = DateTime(2050);
  DateTime _startDate = DateTime(2010);
  DateTime _endDate = DateTime(2050);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "ترتيب حسب",
            style: TextStyles.bold16,
          ),
          RadioListTile<SortOrderEnum>(
            title: const Text("من الأقدم إلى أحدث "),
            value: SortOrderEnum.FirstToNewset,
            groupValue: context.read<HomeCubit>().selectedSortOrder,
            onChanged: (SortOrderEnum? value) {
              setState(() {
                context.read<HomeCubit>().selectedSortOrder = value!;
                context.read<HomeCubit>().selectedSortType = value;
              });
            },
          ),
          RadioListTile<SortOrderEnum>(
            title: const Text("من أحدث إلى الأقدم"),
            value: SortOrderEnum.NewsetFirst,
            groupValue: context.read<HomeCubit>().selectedSortOrder,
            onChanged: (SortOrderEnum? value) {
              setState(() {
                context.read<HomeCubit>().selectedSortOrder = value!;
                context.read<HomeCubit>().selectedSortType = value;
              });
            },
          ),
          RadioListTile<SortOrderEnum>(
            title: const Text("حسب الأبجدية"),
            value: SortOrderEnum.ATZ,
            groupValue: context.read<HomeCubit>().selectedSortOrder,
            onChanged: (SortOrderEnum? value) {
              setState(() {
                context.read<HomeCubit>().selectedSortOrder = value!;
                context.read<HomeCubit>().selectedSortType = value;
              });
            },
          ),
          RadioListTile<SortOrderEnum>(
            title: const Text("حسب فترة زمنية"),
            value: SortOrderEnum.RangeDate,
            groupValue: context.read<HomeCubit>().selectedSortOrder,
            onChanged: (SortOrderEnum? value) {
              setState(() {
                context.read<HomeCubit>().selectedSortOrder = value!;
                context.read<HomeCubit>().selectedSortType = value;
              });
            },
          ),
          Visibility(
            visible: context.read<HomeCubit>().selectedSortOrder ==
                SortOrderEnum.RangeDate,
            child: RangeSlider(
              values: RangeValues(
                _startDate.millisecondsSinceEpoch.toDouble(),
                _endDate.millisecondsSinceEpoch.toDouble(),
              ),
              min: _minDate.millisecondsSinceEpoch.toDouble(),
              max: _maxDate.millisecondsSinceEpoch.toDouble(),
              divisions: _maxDate.year - _minDate.year,
              labels: RangeLabels(
                _startDate.year.toString(),
                _endDate.year.toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _startDate = DateTime.fromMillisecondsSinceEpoch(
                    values.start.toInt(),
                  );
                  _endDate = DateTime.fromMillisecondsSinceEpoch(
                    values.end.toInt(),
                  );
                  context.read<HomeCubit>().rangeStartDate =
                      DateTime.fromMillisecondsSinceEpoch(
                          (values.start).toInt());
                  context.read<HomeCubit>().rangeEndDate =
                      DateTime.fromMillisecondsSinceEpoch((values.end).toInt());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
