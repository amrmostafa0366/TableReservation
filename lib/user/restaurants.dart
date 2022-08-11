
import 'dart:convert';

import 'package:TableReservation/user/reservations.dart';
import 'package:TableReservation/user/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../restaurantSearch.dart';

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  Future _list;
  Future _data;
  List<String> listsearch = [];

Future getSearchList() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Restaurants').getDocuments();
        for (int i = 0; i < qn.documents.length; ++i) {
          
          listsearch.add(qn.documents[i]['name']);
          
        }  // _index[i]['name']
      //  print(listsearch);
    return qn.documents;
    
  } 
  Future getRestaurants() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Restaurants').getDocuments();
        
          
          // _index[i]['name']
      
    return qn.documents;
    
  } 

  @override
  void initState(){
    super.initState();
    _data = getRestaurants();
    _list = getSearchList();

  }

  navigateToRestaurant(DocumentSnapshot restaurant){

    Navigator.push(context, MaterialPageRoute(builder: (context) => Restaurant(restaurant: restaurant,)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:AppBar(
        title:Text('Restaurants'),
        elevation: 6,
        actions: <Widget>[ 
          IconButton(
            icon: Icon(Icons.search),
            onPressed:(){
              showSearch(context: context, delegate: RestaurantSearch(list: listsearch));
            }
          ),
        ],                
        backgroundColor: Colors.red,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Reservations()));
        },
        child: Icon(Icons.description),
        backgroundColor: Colors.red,
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
               //child: Text(''),
               child: CircularProgressIndicator(),
              );
            } else {

             return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){

                  return ListTile(
                    title: Center( child:Text(snapshot.data[index].data['name'],
                    style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Bangers',
                                    )
                    ),),
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