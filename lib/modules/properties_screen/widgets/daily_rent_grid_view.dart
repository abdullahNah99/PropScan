import 'package:flutter/material.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'daily_rent_item.dart';

class DailyRentGrid extends StatefulWidget {
  final PropertiesCubit propertiesCubit;
  const DailyRentGrid({super.key, required this.propertiesCubit});

  @override
  State<DailyRentGrid> createState() => _DailyRentGridState();
}

class _DailyRentGridState extends State<DailyRentGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.propertiesCubit.dailyRentDates.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return DailyRentItem(
          onTap: widget.propertiesCubit.reservedDates.contains(index)
              ? null
              : () {
                  setState(() {
                    widget.propertiesCubit.dailyRentItmeOnTap(index: index);
                  });
                },
          propertiesCubit: widget.propertiesCubit,
          index: index,
          date: widget.propertiesCubit.dailyRentDates[index],
          day: widget.propertiesCubit.dailyRentDays[index],
          status: widget.propertiesCubit.reservedDates.contains(index)
              ? 'Reserved'
              : 'Availabe',
        );
      },
    );
  }
}
