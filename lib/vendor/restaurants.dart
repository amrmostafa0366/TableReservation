
import 'package:TableReservation/vendor/reservations.dart';
import 'package:TableReservation/vendor/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'addRestaurant.dart';

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {

  Future _data;

  Future getRestaurants() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Restaurants').getDocuments();

    return qn.documents;
  }

  
 

  @override
  void initState(){
    super.initState();
    
    _data = getRestaurants();

  }

  navigateToRestaurant(DocumentSnapshot restaurant){

    Navigator.push(context, MaterialPageRoute(builder: (context) => Restaurant(restaurant: restaurant,)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Restaurants'),
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
              Navigator.push(context,MaterialPageRoute(builder: (context)=>AddRestaurant()));
            },
          child: Icon(Icons.add,),
        ),
        ),
      ],
    ),

      
      body: RefreshIndicator(
        onRefresh: () {
       setState(() {
    _data = getRestaurants();
             });
             return _data;
          },
        
        child: Container(
          child: FutureBuilder(
            future: _data,
            builder:(_, snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
               // child: Text('Loading...'),
              // child: Text(''),
              child: CircularProgressIndicator(),
              );
            } else {

             return ListView.builder(
               
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){

                  return ListTile(
                    title:Center( child:Text(snapshot.data[index].data['name'],
                    style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Bangers',
                                    ),
                                    
                    ),
                    
                    ),
                    
                    onTap: () => navigateToRestaurant(snapshot.data[index]),
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