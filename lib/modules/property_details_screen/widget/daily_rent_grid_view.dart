import 'package:flutter/material.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/modules/property_details_screen/cubit/property_details_cubit.dart';
import 'daily_rent_item.dart';

class DailyRentGrid extends StatefulWidget {
  final PropertyDetailsCubit propertyDetailsCubit;
  const DailyRentGrid({super.key, required this.propertyDetailsCubit});

  @override
  State<DailyRentGrid> createState() => _DailyRentGridState();
}

class _DailyRentGridState extends State<DailyRentGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.propertyDetailsCubit.dailyRentDates.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return DailyRentItem(
          onTap: widget.propertyDetailsCubit.reservedDates.contains(index)
              ? null
              : () {
                  setState(() {
                    widget.propertyDetailsCubit
                        .dailyRentItmeOnTap(index: index);
                  });
                },
          propertyDetailsCubit: widget.propertyDetailsCubit,
          index: index,
          date: widget.propertyDetailsCubit.dailyRentDates[index],
          day: widget.propertyDetailsCubit.dailyRentDays[index],
          status: widget.propertyDetailsCubit.reservedDates.contains(index)
              ? 'Reserved'
              : 'Availabe',
        );
      },
    );
  }
}
