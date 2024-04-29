part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {

  // String message ;
  //
  // AuthAuthenticated(this.message);
}

class AuthUnAuthenticated extends AuthState {
  String message ;

  AuthUnAuthenticated(this.message);


}

