import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../Models/DataModel.dart';

part 'add_details_state.dart';

class AddDetailsCubit extends Cubit<AddDetailsState> {
  AddDetailsCubit() : super(AddDetailsInitial());

  Future<void> addData(DataModel data) async {
    try {
      emit(AddDetailsLoading());
      User? user = FirebaseAuth.instance.currentUser;

      final CollectionReference userDataCollection = FirebaseFirestore.instance.
      collection('users').doc(user?.uid).collection('data');

      // Add the data to the user's data subcollection
      await userDataCollection.add(data.toMap());
      emit(AddDetailsSuccess());
    } catch (e) {
      emit(AddDetailsFailure(e.toString()));
    }
  }

}
