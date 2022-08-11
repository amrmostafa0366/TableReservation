
import 'dart:io';
import 'dart:async';

import 'package:TableReservation/main.dart';
import 'package:TableReservation/vendor/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_downloader/image_downloader.dart';

class Restaurant extends StatefulWidget {

  final DocumentSnapshot restaurant;
  Restaurant({this.restaurant});
  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {

  final firestore =Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(widget.restaurant.data['name']),
        backgroundColor: Colors.red,
      ),

      body: ListView(
        children:[ Container(
          child: Column(
            children: [
              
              Image.network(widget.restaurant.data['image'],
              width: 500,
              height:200 ,
              fit: BoxFit.fill,
              ),
  

              Padding(padding: EdgeInsets.all(5.0)),
              Container(
                alignment: Alignment.center,             
                child:Column(
                  children: [
                    
                 Text(widget.restaurant.data['name'],
                 
                style: TextStyle(fontSize: 40, 
                fontFamily: 'Bangers',
                color: Colors.red[900],
                ),
                ),
               
                ],
              ),
              ),
              Container(
                alignment: Alignment.center,             
                child:Column(
                  children: [
                    
                 Text(widget.restaurant.data['category'],
                style: TextStyle(fontSize: 30,
                fontFamily: 'Bangers',
                ),
                ),
               
                ],
              ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                  child: Container(
                   padding: const EdgeInsets.all(8.0),

                    alignment: Alignment.topLeft,             
                    child:Column(
                      children: [
                        
                     Text(widget.restaurant.data['description'],
                    style: TextStyle(fontSize: 25, 
                    fontFamily: 'Handlee',
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                   
                    ],
                    
                  ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                     Radius.circular(10),
                  ),
                  ),
                  child: Container(
                   padding: const EdgeInsets.all(8.0),

                    alignment: Alignment.topLeft,             
                    child:Column(
                      children: [
                        
                     Text('Single Tables: '+widget.restaurant.data['single tables']+'\n'
                     'Double Tables: '+widget.restaurant.data['double tables']+'\n'
                     'Triple Tables: '+widget.restaurant.data['triple tables']+'\n'
                     'Quadruple Tables: '+widget.restaurant.data['quadruple tables']+'\n'
                     'Quintuple Tables: '+widget.restaurant.data['quintuple tables']+'\n'
                     'Sextuple Tables: '+widget.restaurant.data['sextuple tables'],
                    style: TextStyle(fontSize: 25, 
                    fontFamily: 'Handlee',
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                   
                    ],
                    
                  ),
                  ),
                ),
              ),
              ButtonTheme(
                        minWidth: 150.0,
                         
                          child:RaisedButton(
                           child: Text('Delete Restaurant',
                           style: TextStyle(fontSize: 22, color: Colors.white),
                           
                          
                           ),
                          color:Colors.red,
                          onPressed: ()async{
                            await firestore.collection('Restaurants').document(widget.restaurant.documentID).delete();
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