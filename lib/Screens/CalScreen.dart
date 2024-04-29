import 'package:bmi/Cubit/add_detials_cubit/add_details_cubit.dart';
import 'package:bmi/Models/DataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/UserInfoForm.dart';

class CalScreen extends StatelessWidget {

  CalScreen({this.model});

  DataModel? model ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: BlocProvider(
          create: (context) => AddDetailsCubit(),
          child: UserInfoForm(model),
        ),

      ),
    );
  }


}
