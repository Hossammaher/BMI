part of 'add_details_cubit.dart';

@immutable
abstract class AddDetailsState {}

class AddDetailsInitial extends AddDetailsState {}

class AddDetailsLoading extends AddDetailsState {}

class AddDetailsSuccess extends AddDetailsState {


}

class AddDetailsFailure extends AddDetailsState {

  String errMessage ;

  AddDetailsFailure(this.errMessage);
}
