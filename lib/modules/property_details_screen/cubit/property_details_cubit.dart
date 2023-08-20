import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'property_details_state.dart';

class PropertyDetailsCubit extends Cubit<PropertyDetailsState> {
  PropertyDetailsCubit() : super(PropertyDetailsInitial());
}
