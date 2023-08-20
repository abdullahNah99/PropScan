import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/shared/models/property_details_model.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/properties/show_property_details_service.dart';

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
}
