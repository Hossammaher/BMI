import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../Models/DataModel.dart';

part 'show_details_state.dart';

class ShowDetailsCubit extends Cubit<ShowDetailsState> {
  ShowDetailsCubit() : super(ShowDetailsInitial());
  final int itemsPerPage = 10;
  int currentPage = 0;
  DocumentSnapshot? _lastDocumentSnapshot;
  DocumentSnapshot? _firstDocument;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int _perPage = 10; // Number of items to fetch per page
  bool _hasMoreData = true;
  User? user = FirebaseAuth.instance.currentUser;





  void fetchData() async {
    emit(ShowDetailsLoading());
    final querySnapshot = await _firestore
        .collection('users').doc(user?.uid).collection('data')
        .orderBy('currentTime', descending: true)

        .get();
    final dataModels = querySnapshot.docs
        .map((doc) => DataModel.fromSnapshot(doc))
        .toList();
    _lastDocumentSnapshot = querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
    emit(ShowDetailsSuccess(dataModels));

    _firestore
        .collection('users').doc(user?.uid).collection('data')
        .orderBy('currentTime', descending: true)
        .snapshots()
        .listen((snapshot) {
      final updatedDataModels = snapshot.docs
          .map((doc) => DataModel.fromSnapshot(doc))
          .toList();
      emit(ShowDetailsSuccess(updatedDataModels));
    });

  }

  // void fetchNextPage() async {
  //
  //   if (_hasMoreData && _lastDocumentSnapshot != null) {
  //     final querySnapshot = await _firestore
  //         .collection('data')
  //         .orderBy('currentTime',descending: true)
  //         .startAfterDocument(_lastDocumentSnapshot!)
  //         .limit(_perPage)
  //         .get();
  //     final newData = querySnapshot.docs
  //         .map((doc) => DataModel.fromSnapshot(doc))
  //         .toList();
  //     if (querySnapshot.docs.length < _perPage) {
  //       _hasMoreData = false;
  //     }
  //     _lastDocumentSnapshot = querySnapshot.docs.isNotEmpty
  //         ? querySnapshot.docs.last
  //         : null;
  //     emit(ShowDetailsSuccess(newData));
  //   }
  // }
  //
  // void fetchPrevPage() async {
  //   if (_hasMoreData && _firstDocument != null) {
  //     final querySnapshot = await _firestore
  //         .collection('data')
  //         .orderBy('currentTime', descending: true)
  //         .endBeforeDocument(_firstDocument!)
  //         .limit(_perPage)
  //         .get();
  //     final newData = querySnapshot.docs
  //         .map((doc) => DataModel.fromSnapshot(doc))
  //         .toList();
  //     if (querySnapshot.docs.length < _perPage) {
  //       _hasMoreData = false;
  //     }
  //     _firstDocument = querySnapshot.docs.isNotEmpty
  //         ? querySnapshot.docs.first
  //         : null;
  //     emit(ShowDetailsSuccess(newData));
  //   }
  // }



    Future<void> deleteData(String id) async {
      try {
        await FirebaseFirestore.instance .collection('users').doc(user?.uid).collection('data').doc(id).delete();
        emit(ShowDetailsLoading()); // Trigger loading state
        fetchData();
        // Refetch data after deletion
      } catch (e) {
        emit(ShowDetailsFailure('Failed to delete data'));
      }
    }

  Future<void> editData(DataModel model) async {
    try {
      emit(ShowDetailsLoading());
      await _firestore
          .collection('users').doc(user?.uid).collection('data')
          .doc(model.id)
          .update(model.toMap()); // Convert DataModel to Map

      // Fetch updated data from Firestore
      final QuerySnapshot snapshot =
      await _firestore.collection('users').doc(user?.uid).collection('data')

          .orderBy('currentTime', descending: true)
          .get();
      final List<DataModel> updatedDataList = snapshot.docs.map((doc) => DataModel.fromSnapshot(doc)).toList();

      emit(ShowDetailsSuccess(updatedDataList)); // Emit updated data list
    } catch (e) {
      // Handle errors
      emit(ShowDetailsFailure(e.toString()));
    }
  
  }

  }
