

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../Models/userModel.dart';
import '../../Widgets/ShowSnakeBar.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());


  final FirebaseAuth auth = FirebaseAuth.instance;



  Future<void> checkAuthenticationStatus() async {

    // User? user = FirebaseAuth.instance.currentUser;

    final UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    final User user = userCredential.user!;

      try {
        if (user != null) {
          emit(AuthAuthenticated());
        }else if (user == null){
          signInAnonymously() ;
          emit(AuthUnAuthenticated('Login Anonymously '));
          final userData = UserModel(userId: user!.uid);
          await createUserDocument(userData);
        }
      } on Exception catch (e) {
        print(e.toString());
      }

  }


  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUserDocument(UserModel userData) async {
    try {
      final Map<String, dynamic> data = {
        'userId': userData.userId,
        // Add other user-specific data
      };
      await _usersCollection.doc(userData.userId).set(data);
    } catch (e) {
      // Handle Firestore errors
      print('Error creating user document: $e');
    }
  }
  // Sign in anonymously
  Future<void> signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print('Error signing in anonymously: $e');
      // Handle error
    }
  }


}
