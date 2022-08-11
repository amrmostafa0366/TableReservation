import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'booking.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Restaurant extends StatefulWidget {
  final DocumentSnapshot restaurant;
  Restaurant({this.restaurant});
  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  String resname;
  String cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.data['name']),
        backgroundColor: Colors.red,
      ),

      /*    floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.red,
        child: Icon(Icons.add ,),
        onPressed:(){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Booking()));
        }
      ), */

      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Image.network(
                  widget.restaurant.data['image'],
                  width: 500,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        widget.restaurant.data['name'],
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Bangers',
                          color: Colors.red[900],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        widget.restaurant.data['category'],
                        style: TextStyle(
                          fontSize: 30,
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
                      child: Column(
                        children: [
                          Text(
                            widget.restaurant.data['description'],
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Handlee',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    minWidth: 250.0,
                    child: RaisedButton(
                      child: Text(
                        'Table Reservation',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                       //   resname = widget.restaurant.data['name'];
                          cat = widget.restaurant.data['category'];
                          //   print(resname = widget.restaurant.data['name'] );
                          //   print(cat = widget.restaurant.data['category']);
                        });
                        // Navigator.push(context,MaterialPageRoute(builder: (context)=>Booking()));
                        //   navigateToBooking();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Booking(
                                    restaurant:  widget.restaurant, category: cat)));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
