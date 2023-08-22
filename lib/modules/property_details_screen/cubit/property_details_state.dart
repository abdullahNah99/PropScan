part of 'property_details_cubit.dart';

sealed class PropertyDetailsState extends Equatable {
  const PropertyDetailsState();

  @override
  List<Object> get props => [];
}

final class PropertyDetailsInitial extends PropertyDetailsState {}

final class ChangeChecked extends PropertyDetailsState {}

final class PropertyDetailsLoading extends PropertyDetailsState {}

final class PropertyDetailsFailure extends PropertyDetailsState {
  final String errorMessage;

  const PropertyDetailsFailure({required this.errorMessage});
}

final class PropertyDetailsSuccess extends PropertyDetailsState {
  final PropertyDetailsModel properties;

  const PropertyDetailsSuccess({required this.properties});
}


final class StoreReportLoading extends PropertyDetailsState {}

final class StoreReportFailure extends PropertyDetailsState {
  final String errorMessage;

  const StoreReportFailure({required this.errorMessage});
}

final class StoreReportSuccess extends PropertyDetailsState {
  final MessageModel messageModel;

  const StoreReportSuccess({required this.messageModel});
}

final class ReservationFailure extends PropertyDetailsState {
  final String errorMessage;

  const ReservationFailure({required this.errorMessage});
}

final class ReservationSuccess extends PropertyDetailsState {}


final class GetPropertyChatUserSuccess extends PropertyDetailsState {
  final ChatUser chatUser;

  const GetPropertyChatUserSuccess({required this.chatUser});
}

