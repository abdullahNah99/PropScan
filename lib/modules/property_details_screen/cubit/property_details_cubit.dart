import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:untitled/shared/models/property_details_model.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/properties/show_property_details_service.dart';
import 'package:untitled/shared/styles/app_colors.dart';

part 'property_details_state.dart';

class PropertyDetailsCubit extends Cubit<PropertyDetailsState> {
  PropertyDetailsCubit() : super(PropertyDetailsInitial());

  PropertyDetailsModel? propertyDetails;

  Future<void> getPropertyDetails({required int propertyID}) async {
    emit(PropertyDetailsLoading());
    (await ShowPropertyDetailsService.showDetails(
      token: CacheHelper.getData(key: "Token"),
      propertyID: propertyID,
    ))
        .fold(
      (failure) {
        emit(
          PropertyDetailsFailure(errorMessage: failure.errorMessege),
        );
      },
      (propertyDetails) {
        emit(
          PropertyDetailsSuccess(properties: propertyDetails),
        );
      },
    );
  }

  List<String> dailyRentDates = [];
  List<String> dailyRentDays = [];
  int? dailyRentStartIndex;
  int? dailyRentEndIndex;

  List<String> test = [
    '2023-08-24',
    '2023-08-25',
    '2023-08-26',
    '2023-08-27',
    '2023-08-28',
    '2023-08-29',
    '2023-09-06',
  ];

  Color getDailyRentItemColor({required int index}) {
    if (reservedDates.contains(index)) {
      return Colors.grey.withOpacity(.7);
    } else if (dailyRentStartIndex != null) {
      if (dailyRentEndIndex != null) {
        if (index >= dailyRentStartIndex! && index <= dailyRentEndIndex!) {
          return AppColors.defaultColor;
        }
      } else {
        if (index == dailyRentStartIndex) {
          return AppColors.defaultColor;
        }
      }
    }
    return AppColors.color2.withOpacity(.3);
  }

  List<int> reservedDates = [];

  void getDailyRentDates() {
    dailyRentDates.clear();
    dailyRentDays.clear();
    reservedDates.clear();
    Jiffy jiffy = Jiffy.now();
    for (int i = 0; i < 90; i++) {
      jiffy = jiffy.add(days: 1);
      dailyRentDates.add(jiffy.format().substring(0, 10));
      dailyRentDays.add(jiffy.EEEE);

      if (test.contains(jiffy.format().substring(0, 10))) {
        reservedDates.add(i);
      }
    }
  }

  void dailyRentItmeOnTap({required int index}) {
    if (dailyRentStartIndex == null) {
      dailyRentStartIndex = index;
    } else {
      if (dailyRentEndIndex != null && index == dailyRentEndIndex) {
        dailyRentEndIndex = null;
      } else {
        if (index > dailyRentStartIndex!) {
          dailyRentEndIndex = index;
        } else if (index == dailyRentStartIndex) {
          dailyRentStartIndex = null;
          dailyRentEndIndex = null;
        }
      }
    }
  }

  List<String> getSelectedDates() {
    List<String> selectedDates = [];
    if (dailyRentStartIndex != null) {
      if (dailyRentEndIndex != null) {
        for (int i = dailyRentStartIndex!; i <= dailyRentEndIndex!; i++) {
          if (!reservedDates.contains(i)) {
            selectedDates.add(dailyRentDates[i]);
          }
        }
      } else {
        selectedDates.add(dailyRentDates[dailyRentStartIndex!]);
      }
    }
    return selectedDates;
  }
}
