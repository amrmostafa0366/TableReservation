
import 'package:TableReservation/vendor/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'addRestaurant.dart';
import 'reservation.dart';

class Reservations extends StatefulWidget {
  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {

  Future _data;

  Future getReservations() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Reservations').getDocuments();

    return qn.documents;
  }

  @override
  void initState(){
    super.initState();

    _data = getReservations();

  }

  navigateToReservation(DocumentSnapshot reservation){

    Navigator.push(context, MaterialPageRoute(builder: (context) => Reservation(reservation: reservation,)));

  }

var refresh;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Reservations'),
        backgroundColor: Colors.red,
      ),
   /*   floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.red,
        child: Icon(Icons.add ,),
        onPressed:(){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddRestaurant()));
        } 
      ), */
      
      body: RefreshIndicator(
        onRefresh: () {
       setState(() {
    _data = getReservations();
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
               child: Text(''),
              );
            } else {

             return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){

                  return ListTile(
                    title:Center( child:Text(snapshot.data[index].data['restaurant name'],
                    style: TextStyle( fontSize: 28,
                                      fontFamily: 'Bangers',
                                      )
                    ),),
                    onTap: () => navigateToReservation(snapshot.data[index]),
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