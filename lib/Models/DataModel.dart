
import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {

   String? id ;
   int age;
   double weight;
   double height;
   DateTime currentTime;
   String status ;

   DataModel({ this.id,required this.age,required this.weight,
      required this.height,required this.currentTime,
      required this.status});

   Map<String, dynamic> toMap() {
      return {

         'age': age,
         'weight': weight,
         'height': height,
         'currentTime': currentTime,
         'status' : status
      };
   }

   factory DataModel.fromSnapshot(DocumentSnapshot snapshot) {
      return DataModel(
         id: snapshot.id,
         age: snapshot['age'],
         weight: snapshot['weight'],
         height: snapshot['height'],
         currentTime: (snapshot['currentTime'] as Timestamp).toDate(),
         status: snapshot['status'],
      );
   }

}