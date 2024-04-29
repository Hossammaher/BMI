import 'package:bmi/Cubit/add_detials_cubit/add_details_cubit.dart';
import 'package:bmi/Cubit/auth_cubit/auth_cubit.dart';
import 'package:bmi/Cubit/show_details_cubit/show_details_cubit.dart';
import 'package:bmi/Screens/HomeScreen.dart';

import 'package:bmi/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();


  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ShowDetailsCubit()),

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
