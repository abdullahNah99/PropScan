import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:untitled/shared/models/Report_model.dart';
import 'package:untitled/shared/models/message_model.dart';
import 'package:untitled/shared/models/property_details_model.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/properties/show_property_details_service.dart';

import 'package:untitled/shared/network/remote/services/reports/store_report_service.dart';

import 'package:untitled/shared/network/remote/services/reservations/get_reservation_dates.dart';
import 'package:untitled/shared/network/remote/services/reservations/store_reservation_service.dart';

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

  void getDatesBetween(String date1, String date2) {
    DateTime startDate = DateTime(
      int.parse(date1.substring(0, 4)),
      int.parse(date1.substring(5, 7)),
      int.parse(date1.substring(8, 10)),
    );
    DateTime endDate = DateTime(
      int.parse(date2.substring(0, 4)),
      int.parse(date2.substring(5, 7)),
      int.parse(date2.substring(8, 10)),
    );
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
      test.add(days[i].toString().substring(0, 10));
    }
  }

  Future<void> getReservationDates({required int propertyID}) async {
    emit(PropertyDetailsLoading());
    (await GetReservationDatesService.getReservationDates(
            propertyID: propertyID))
        .fold(
      (failure) {
        emit(PropertyDetailsFailure(errorMessage: failure.errorMessege));
      },
      (reservationDates) {
        for (ReservationModel item in reservationDates) {
          getDatesBetween(item.startDate, item.endDate);
        }
        log(test.toString());
        emit(PropertyDetailsInitial());
      },
    );
  }

  Future<void> bookReservation() async {
    (await StoreReservationService.storeReservation(
      token: await CacheHelper.getData(key: 'Token'),
      startDate: dailyRentDates[dailyRentStartIndex!],
      endDate: dailyRentDates[dailyRentEndIndex!],
      // price: int.parse((propertyDetails!.price * .1).toString()),
      price: 1000,
      propertyID: propertyDetails!.id,
    ))
        .fold(
      (failure) {
        emit(ReservationFailure(errorMessage: failure.errorMessege));
      },
      (success) {
        emit(ReservationSuccess());
      },
    );
  }

  List<String> dailyRentDates = [];
  List<String> dailyRentDays = [];
  int? dailyRentStartIndex;
  int? dailyRentEndIndex;

  List<String> test = [
    // '2023-08-24',
    // '2023-08-25',
    // '2023-08-26',
    // '2023-08-27',
    // '2023-08-28',
    // '2023-08-29',
    // '2023-09-06',
  ];

  List<ReportModel> reports = [
    ReportModel(report: 'report1', isReport: false),
    ReportModel(report: 'report2', isReport: false),
    ReportModel(report: 'report3', isReport: false),
    ReportModel(report: 'report4', isReport: false),
    ReportModel(report: 'report5', isReport: false),
    ReportModel(report: 'report6', isReport: false),
    ReportModel(report: 'report7', isReport: false),
  ];
  String descriptionReport = '';
  void changeChecked(ReportModel reports, int index, bool value) {
    for (int i = 0; i < this.reports.length; i++) {
      if (i != index) {
        this.reports[i].isReport = false;
      } else {
        this.reports[i].isReport = value;
        if (value == true) {
          descriptionReport = this.reports[i].report;
          log(descriptionReport);
        } else {
          descriptionReport = '';
          log(descriptionReport);
        }
      }
    }
  }

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

  Future<void> storeReport(
      {required int propertyID, required String description}) async {
    emit(StoreReportLoading());
    (await StoreReportService.addReport(
      token: await CacheHelper.getData(key: "Token"),
      propertyID: propertyID,
      description: description,
    ))
        .fold(
      (failure) {
        emit(
          StoreReportFailure(
            errorMessage: failure.errorMessege,
          ),
        );
      },
      (messageModel) {
        emit(
          StoreReportSuccess(messageModel: messageModel),
        );
      },
    );

    void getDatesBetween(String date1, String date2) {
      DateTime startDate = DateTime(
        int.parse(date1.substring(0, 4)),
        int.parse(date1.substring(5, 7)),
        int.parse(date1.substring(8, 10)),
      );
      DateTime endDate = DateTime(
        int.parse(date2.substring(0, 4)),
        int.parse(date2.substring(5, 7)),
        int.parse(date2.substring(8, 10)),
      );
      List<DateTime> days = [];
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        days.add(startDate.add(Duration(days: i)));
        test.add(days[i].toString().substring(0, 10));
      }
    }
  }
}
