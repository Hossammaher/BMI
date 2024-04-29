part of 'show_details_cubit.dart';

@immutable
abstract class ShowDetailsState {}

class ShowDetailsInitial extends ShowDetailsState {}


class ShowDetailsLoading extends ShowDetailsState {}

class ShowDetailsSuccess extends ShowDetailsState {

  List<DataModel> data ;

  ShowDetailsSuccess(this.data);
}

class ShowDetailsFailure extends ShowDetailsState {

  String errMessage ;

  ShowDetailsFailure(this.errMessage);
}
