import 'package:bmi/Cubit/auth_cubit/auth_cubit.dart';
import 'package:bmi/Widgets/ShowSnakeBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'HomeScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<AuthCubit>(context).checkAuthenticationStatus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {

          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          });
        }if (state is AuthUnAuthenticated) {

          Future.delayed(Duration.zero, () {
            ShowSnakeBar().showSnakeBarr(context, state.message);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );


          });


        }
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}


// Future<void> _checkAuthenticationAndNavigate(BuildContext context) async {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? user = auth.currentUser;
//
//   if (user != null) {
//     // Navigate to home screen if user is already logged in
//     Future.delayed(Duration.zero, () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     });
//   } else {
//     // Navigate to login screen if user is not logged in
//
//     Future.delayed(Duration.zero, () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });
//   }
// }
