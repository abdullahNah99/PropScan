import 'package:equatable/equatable.dart';
import 'package:untitled/shared/models/firebase_models/chat_user.dart';

abstract class PropertiesStates extends Equatable {
  @override
  List<Object> get props => [];
}

final class PropertiesInitial extends PropertiesStates {}

final class PropertiesLoading extends PropertiesStates {}

final class PropertiesFailure extends PropertiesStates {
  final String errorMessage;

  PropertiesFailure({required this.errorMessage});
}

final class PropertiesSuccess extends PropertiesStates {}

final class GetPropertyChatUserSuccess extends PropertiesStates {
  final ChatUser chatUser;

  GetPropertyChatUserSuccess({required this.chatUser});
}
