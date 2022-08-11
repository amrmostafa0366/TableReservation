
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_downloader/image_downloader.dart';

//import 'addRestaurant.dart';
import '../restaurantSearch.dart';
import 'reservations.dart';
import 'restaurant.dart';

class Category extends StatefulWidget {

  final DocumentSnapshot category;
  Category({this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  Future _list;
  Future _data;
  int x=0;

  
  List<String> listsearch = [];

Future getSearchList() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Restaurants').getDocuments();
    QuerySnapshot fc = await firestore.collection('Init').getDocuments();

        for (int i = 0; i < qn.documents.length; ++i) {
          if(widget.category.data['category'] == qn.documents[i]['category']){

        fc.documents.add(qn.documents[i]) ;
        x++;
      }
        
          
        }
         for (int i = 0; i < fc.documents.length; ++i){

            listsearch.add(fc.documents[i]['name']);

         }
    return fc.documents;
    
  }


  Future getRestaurants() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Restaurants').getDocuments();
    QuerySnapshot fc = await firestore.collection('Init').getDocuments();
    
    for (int i = 0; i < qn.documents.length; ++i) {
      

      if(widget.category.data['category'] == qn.documents[i]['category']){

        fc.documents.add(qn.documents[i]) ;
        x++;
      }

          
    }
    return fc.documents;
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
        elevation: 6,
        actions: <Widget>[ 
          IconButton(
            icon: Icon(Icons.search),
            onPressed:(){
              showSearch(context: context, delegate: RestaurantSearch(list: listsearch));
            }
          ),
        ],
        title:Text(widget.category.data['category']),
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
