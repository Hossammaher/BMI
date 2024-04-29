import 'package:bmi/Cubit/show_details_cubit/show_details_cubit.dart';
import 'package:bmi/Models/DataModel.dart';
import 'package:bmi/Screens/CalScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<ShowDetailsCubit>(context).fetchData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CalScreen();
            },
          ));
        },
      ),
      body: BlocBuilder<ShowDetailsCubit, ShowDetailsState>(
        builder: (context, state) {

          if (state is ShowDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ShowDetailsSuccess) {
            final dataModels = state.data;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: dataModels.length + 1,
                    itemBuilder: (context, index) {
                      if (index < dataModels.length) {
                        final data = dataModels[index];
                        return  dataCardwidget(data: data,
                            onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Item'),
                                content: Text('Are you sure you want to delete this item?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Delete item from Firestore and update UI
                                      BlocProvider.of<ShowDetailsCubit>(context).deleteData(data.id!);
                                      BlocProvider.of<ShowDetailsCubit>(context).fetchData();

                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );

                        },
                          onTap: () {
                            BlocProvider.of<ShowDetailsCubit>(context).editData(data);
                             Navigator.push(context, MaterialPageRoute(builder: (context) {
                               return CalScreen(model: data,);
                             },));
                            },

                        );

                      }
                    },
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //
                //         setState(() {
                //           BlocProvider.of<ShowDetailsCubit>(context).fetchPrevPage();
                //         });
                //
                //       },
                //       child: Text('Previous'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //
                //         setState(() {
                //           BlocProvider.of<ShowDetailsCubit>(context).fetchNextPage();
                //         });
                //       },
                //       child: Text('Next'),
                //     ),
                //   ],
                // ),

              ],
            );
          } else {
            return Center(child: Text('Error fetching data'));
          }

        },
      ),
    );
  }
}






class dataCardwidget extends StatelessWidget {


  dataCardwidget({required this.data,required this.onLongPress,required this.onTap});

  final DataModel data;
  void Function()? onLongPress ;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onLongPress: onLongPress ,
        onTap: onTap,
        child: Card(

          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                Text("Age : ${data.age.toString()}"),

              ],) ,
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 1,),
                  Text("Status : ${data.status}"),
                  Spacer(flex: 1,),
                Text("Weight : ${data.weight.toString()}"),
                  Spacer(flex: 1,),
                Text("Height : ${data.height.toString()}"),
                  Spacer(flex: 1,),

              ],),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
