
import 'package:TableReservation/vendor/addCategory.dart';
import 'package:TableReservation/vendor/reservations.dart';
import 'package:TableReservation/vendor/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import '../restaurantSearch.dart';
import 'category.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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

  Future getCategories() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('Categories').getDocuments();

    return qn.documents;
  } 

  @override
  void initState(){
    super.initState();

    _data = getCategories();
    _list = getSearchList();

  }

  navigateToCategory(DocumentSnapshot category){

    Navigator.push(context, MaterialPageRoute(builder: (context) => Category(category: category,)));

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

        title:Text('Categories'),
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
              //  child: Text(''),
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