
import 'package:TableReservation/vendor/addCategory.dart';
import 'package:TableReservation/vendor/reservations.dart';
import 'package:TableReservation/vendor/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'addRestaurant.dart';
import 'category.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future _data;

  Future getCategories() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Categories').getDocuments();

    return qn.documents;
  }
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 
  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
     // behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  void initState(){
    super.initState();

    _data = getCategories();

    _firebaseMessaging.subscribeToTopic("vendor");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        return _showScaffold(
          message['notification']['body']
        );
      },
      onLaunch: (Map<String, dynamic> message) async { ///
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async { ///
        print("onResume: $message");
      },
    );

  }

  navigateToCategory(DocumentSnapshot category){

    Navigator.push(context, MaterialPageRoute(builder: (context) => Category(category: category,)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title:Text('Categories'),
        backgroundColor: Colors.red,
      ),

      floatingActionButton: Stack(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left:31),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            heroTag: 'button1',
            backgroundColor: Colors.red,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Reservations()));
            },
            child: Icon(Icons.description),),
        ),),

        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'button2',
            backgroundColor: Colors.red,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>AddCategory()));
            },
          child: Icon(Icons.add,),
        ),
        ),
      ],
    ),

      
      body: RefreshIndicator(
        onRefresh: () {
       setState(() {
    _data = getCategories();
             });
             return _data;
          },
        child: Container(
          child: FutureBuilder(
            future: _data,
            builder:(_, snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                //child: Text('Loading...'),
                //child: Text(''),
                child: CircularProgressIndicator(),
              );
            } else {

             return ListView.builder(
               
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){

                  return ListTile(
                    title:Center( child:Text(snapshot.data[index].data['category'],
                    style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Bangers',
                                    )
                    ),),
                    onTap: () => navigateToCategory(snapshot.data[index]),
                  );
                }

                );

            }

          }),
          
        ),
      ),
    );
  }
}

