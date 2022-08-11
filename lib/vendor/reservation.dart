
import 'dart:io';
import 'dart:async';

import 'package:TableReservation/main.dart';
import 'package:TableReservation/vendor/reservations.dart';
import 'package:TableReservation/vendor/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_downloader/image_downloader.dart';

class Reservation extends StatefulWidget {

  final DocumentSnapshot reservation;
  Reservation({this.reservation});
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {

  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(widget.reservation.data['restaurant name']),
        backgroundColor: Colors.red,
      ),

      body: ListView(
        children:[ Container(
          child: Column(
            children: [
             Padding(padding: EdgeInsets.all(6.0)),
             

              Container(
                alignment: Alignment.topLeft,             
                child:Column(
                  children: [
                      Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                 child:Text('Customer name: \n'+widget.reservation.data['customer name'],
                style: TextStyle(fontSize: 22,
                ),
                ),
                      ),
                ],
              ),
              ),
             Padding(padding: EdgeInsets.all(6.0)),
             Container(
                alignment: Alignment.topLeft,             
                child:Column(
                  children: [
                      Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                 child:Text('Food category: \n'+widget.reservation.data['category'],
                style: TextStyle(fontSize: 22,
                
                ),
                ),
                      ),
                ],
              ),
              ),
             Padding(padding: EdgeInsets.all(6.0)),


              Container(
                alignment: Alignment.topLeft,             
                child:Column(
                  children: [
                      Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                 child:Text('Restaurant name: \n'+widget.reservation.data['restaurant name'],
                style: TextStyle(fontSize: 22,
                ),
                ),
                      ),
                ],
              ),
              ),
              Padding(padding: EdgeInsets.all(6.0)),
              Container(
                alignment: Alignment.topLeft,             
                child:Column(
                  children: [
                      Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                    
                 child:Text('Reserved table type: \n'+widget.reservation.data['reserved table'],
                style: TextStyle(fontSize: 22,
                ),
                ),
                      ),
                ],
              ),
              ),
               Padding(padding: EdgeInsets.all(6.0)),

              Container(
                alignment: Alignment.topLeft,             
                child:Column(
                  children: [
                    
                      Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                child: Text('Reserved at: \n'+widget.reservation.data['reserved at'],
                style: TextStyle(fontSize: 22,
                ),
                ),
                      ),
                ],
              ),
              ),
               Padding(padding: EdgeInsets.all(6.0)),

             Container( 
                alignment: Alignment.topLeft,             
                child:Column(
                  children: [
                    
                              Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                   child: Text('Reservation date: \n'+widget.reservation.data['reservation date'],
                style: TextStyle(fontSize: 22,
                ),
                ),
                 ),
                               
                ],
              ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
               ButtonTheme(
                        minWidth: 150.0,
                        
                         
                          child:RaisedButton(
                           child: Text('Delete Reservation',
                           style: TextStyle(fontSize: 22, color: Colors.white),
                           
                          
                           ),
                          color:Colors.red,
                          onPressed: ()async{
                            await firestore.collection('Reservations').document(widget.reservation.documentID).delete();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MyApp()));
                            
                   
                          }
                          ),
                        ),

            ],
            
          ),
          
          ),
        
        ]
      
      ),
    );
  }
  /*
   void loadImage() async {
    var imageId = await ImageDownloader.downloadImage(_url);
    var path = await ImageDownloader.findPath(imageId);
    File image = File(path);
    setState(() {
      _image = image;
    });
  }
  */
}