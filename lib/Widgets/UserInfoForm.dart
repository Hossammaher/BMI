

import 'package:bmi/Cubit/add_detials_cubit/add_details_cubit.dart';
import 'package:bmi/Cubit/show_details_cubit/show_details_cubit.dart';
import 'package:bmi/Models/DataModel.dart';
import 'package:bmi/Widgets/CalBMI.dart';
import 'package:bmi/Widgets/ShowSnakeBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TextFormFieldWidget.dart';

class UserInfoForm extends StatefulWidget {
  DataModel? model;

  UserInfoForm(this.model);

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {

  final _formKey = GlobalKey<FormState>();
  // late int age;
  // late double weight;
  // late double height;
  // late DateTime time;
  late String status ;
  bool containerVisibility = false ;
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      _ageController.text = widget.model!.age.toString();
      _weightController.text = widget.model!.weight.toString();
      _heightController.text = widget.model!.height.toString();

    }
  }

  @override
  Widget build(BuildContext context) {



    return Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormFieldWidget(
                labelText: 'age',
                 controller: _ageController,

              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                labelText: 'Weight',
                controller: _weightController,


              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                labelText: 'Height',
                controller: _heightController,


              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {

                    status = CalBMI().CalBMIAndShowSatus(double.parse(_weightController.text), double.parse(_heightController.text));

                    if (widget.model == null) {
                      // Add new data
                      DataModel newData = DataModel(
                        age: int.parse(_ageController.text.toString()),
                        weight: double.parse(_weightController.text),
                        height: double.parse(_heightController.text),
                        currentTime: DateTime.now(),
                        status: status

                      );
                      BlocProvider.of<AddDetailsCubit>(context).addData(newData);
                      setState(() {
                        BlocProvider.of<ShowDetailsCubit>(context).fetchData();

                      });
                      // Call method to add newData to Firestore
                    } else {
                      // Update existing data
                      widget.model!.age = int.parse(_ageController.text);
                      widget.model!.weight = double.parse(_weightController.text);
                      widget.model!.height = double.parse(_heightController.text);
                      widget.model!.currentTime =  DateTime.now();
                      widget.model!.status = status ;
                      BlocProvider.of<ShowDetailsCubit>(context).editData(widget.model!);
                      setState(() {
                        BlocProvider.of<ShowDetailsCubit>(context).fetchData();

                      });
                      // Call method to update existing data in Firestore
                    }
                    BlocProvider.of<ShowDetailsCubit>(context).fetchData();
                  }
                },
                child: Text('Submit'),
              ),

              BlocBuilder<AddDetailsCubit, AddDetailsState>(
                builder: (context, state) {
                  if (state is AddDetailsSuccess) {
                    Future.delayed(Duration.zero, () {
                      ShowSnakeBar().showSnakeBarr(context, "Data Added");

                    });

                    return  Column(
                      children: [

                        Text("Your Status is $status"),
                      ],
                    );

                  } else if (state is AddDetailsLoading) {

                    return Center(child: CircularProgressIndicator());

                  } else if (state is AddDetailsFailure) {
                    Future.delayed(Duration.zero, () {
                      ShowSnakeBar().showSnakeBarr(context, state.errMessage);
                    });
                  }
                  return Container();

                },

              ),
            ],
          ),
        ));
  }


}
