  
import 'package:TableReservation/vendor/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


//import 'map.dart';
import 'vendor/restaurants.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
    child: MaterialApp(

      //home: MyDeletingApp(),
      home: Categories(),
      
    ),
    );
    
    }
    
   }
