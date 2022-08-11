import 'package:TableReservation/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'categories.dart';

class AddCategory extends StatefulWidget {

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  final _firestore =Firestore.instance;

  TextEditingController category = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(    
       title: Text('Add Category'),    
       backgroundColor:Colors.red,

     ),    

     body: ListView(
       children:[ Container(
        alignment: Alignment.center,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
               Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  width: 350,
                  child: TextField(
                      controller: category,
                        decoration: InputDecoration(
                         border: OutlineInputBorder(),
                          labelText: 'Category',
                          hintText: 'Category Name...',
                        ),
                        autofocus: false,
                        
                      ),
                  ),

                  Padding(padding: EdgeInsets.all(10.0)),

                  ButtonTheme(
                  minWidth: 250.0,
                   
                    child:RaisedButton(
                     child: Text('Add Category',
                     style: TextStyle(fontSize: 22, color: Colors.white),
                    
                     ),
                    color:Colors.red,
                    onPressed: (){
                   //   Navigator.push(context,MaterialPageRoute(builder: (context)=>Categories()));

                 //   if(category.text !=null)
                     Map<String,dynamic> _data={

                       'category':category.text,
                            };
                            if(category.text.isNotEmpty){
                            _firestore.collection("Categories").add(_data);
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>MyApp()));
                          }
                    }
                      
                    
                    ),
                  ),
                  /*
                  Padding(padding: EdgeInsets.all(5.0)),

                  ButtonTheme(
                  minWidth: 150.0,
                   
                    child:RaisedButton(
                     child: Text('Categories',
                     style: TextStyle(fontSize: 22, color: Colors.white),
                    
                     ),
                    color:Colors.red,
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Categories()));
                      
             
                    }
                    ),
                  ),
                  */
           ],
         ),
       ),
       ],
     ),
      
    );
  }
  


 }
