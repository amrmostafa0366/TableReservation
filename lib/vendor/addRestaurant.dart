//import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'package:TableReservation/main.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_downloader/image_downloader.dart';

import 'package:image_picker/image_picker.dart';

import 'restaurants.dart';

class AddRestaurant extends StatefulWidget {
  final String category;
  AddRestaurant({this.category});
  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _firestore= Firestore.instance;
  
  TextEditingController name = new TextEditingController();
 // TextEditingController category = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController tables1 = new TextEditingController();
  TextEditingController tables2 = new TextEditingController();
  TextEditingController tables3 = new TextEditingController();
  TextEditingController tables4 = new TextEditingController();
  TextEditingController tables5 = new TextEditingController();
  TextEditingController tables6 = new TextEditingController();


  File _image;
    String _url = 'image';
    String img;




  @override
  Widget build(BuildContext context) {
     return Scaffold(    
       
     appBar: AppBar(    
       
       title: Text('Add Restaurant'),    
       backgroundColor:Colors.red,

     ),    
     

     body: ListView(
            children: [
              Container(
 
              alignment: Alignment.center,
               child: Column(
                 
                 children: [
                     Padding(padding: EdgeInsets.all(10.0)),
                      Container(
                        width: 350,
                        child: TextField(
                              controller: name,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Restaurant',
                                hintText: 'Restaurant Name...',
                              ),
                              autofocus: false,
                            ),
                        ),

                      /*  Padding(padding: EdgeInsets.all(10.0)),

                        Container(
                        width: 350,
                        
                        child: TextField(
                          controller: category,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Category',
                                hintText: 'Food Category...',
                              ),
                              autofocus: false,
                            ),
                        ),
                        */
                        Padding(padding: EdgeInsets.all(10.0)),

                        Container(
                        width: 350,
                        child: TextField(
                          controller: description,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Description',
                                hintText: 'Description about the restaurant...',
                              ),
                              autofocus: false,
                           ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),

                        Container(
                        width: 350,
                        child: TextField(
                          controller: tables1,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Single Tables',
                                hintText: 'Number of single tables...',
                              ),
                              autofocus: false,
                           ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                        width: 350,
                        child: TextField(
                          controller: tables2,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Double Tables',
                                hintText: 'Number of double tables...',
                              ),
                              autofocus: false,
                           ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                        width: 350,
                        child: TextField(
                          controller: tables3,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Triple Tables',
                                hintText: 'Number of triple tables...',
                              ),
                              autofocus: false,
                           ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                        width: 350,
                        child: TextField(
                          controller: tables4,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Quadruple Tables',
                                hintText: 'Number of quadruple tables...',
                              ),
                              autofocus: false,
                           ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                        width: 350,
                        child: TextField(
                          controller: tables5,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Quintuple Tables',
                                hintText: 'Number of quintuple tables...',
                              ),
                              autofocus: false,
                           ),
                        ),
                         Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                        width: 350,
                        child: TextField(
                          controller: tables6,
                              decoration: InputDecoration(
                               border: OutlineInputBorder(),
                                labelText: 'Sextuple Tables',
                                hintText: 'Number of sextuple tables...',
                              ),
                              autofocus: false,
                           ),
                        ),
                      Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                         child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                 backgroundColor:Colors.grey[400],
                                backgroundImage: _image == null ? null : FileImage(_image),
                                radius: 25,
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Builder(
                                builder: (context) => RaisedButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  child: Icon(Icons.camera),
                                ),
                                
                              ),
                              Padding(padding: EdgeInsets.all(2.0)),
                              RaisedButton(
                                onPressed:(){
                                  pickImageGallary();
                                },
                                child: Icon(Icons.image),
                                
                              ),
                              Padding(padding: EdgeInsets.all(2.0)),
                                Builder(
                                builder: (context) => RaisedButton(
                                  onPressed: () {
                                    uploadImage(context);
                                  },
                                  child: Icon(Icons.save),
                                ),
                              ),
                                              
                                
                              
                            ],
                          )
                        ],
                      ),
                        ),

                         Padding(padding: EdgeInsets.all(10.0)),

                        
                        ButtonTheme(
                        minWidth: 250.0,
                         
                          child:RaisedButton(
                           child: Text('Add Restaurant',
                           style: TextStyle(fontSize: 22, color: Colors.white),
                          
                           ),
                          color:Colors.red,
                          onPressed: (){
                       //   Navigator.push(context,MaterialPageRoute(builder: (context)=>Restaurants()));
                         //   uploadImage(context);
                            
                            Map<String, dynamic> _data={
                            'name':name.text,
                            'category':widget.category,
                            'description':description.text,
                            'single tables':tables1.text,
                            'double tables':tables2.text,
                            'triple tables':tables3.text,
                            'quadruple tables':tables4.text,
                            'quintuple tables':tables5.text,
                            'sextuple tables':tables6.text,
                            'image':_url,
                      
                            };
                            _firestore.collection("Restaurants").add(_data);
                            //_firestore.collection('Categories').path('').add(_data);                            
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MyApp()));


                          }
                          ),
                        ),
                      /*/  ButtonTheme(
                        minWidth: 150.0,
                         
                          child:RaisedButton(
                           child: Text('Restaruants',
                           style: TextStyle(fontSize: 22, color: Colors.white),
                          
                           ),
                          color:Colors.red,
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Restaurants()));
                            
                   
                          }
                          ),
                        ),*/


                 ],

               ),

         ),
            ],
     ),
     );
     
   
 }
 

 void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

 void pickImageGallary() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  

  void uploadImage(context) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://restaurant-reservation-478d9.appspot.com');
      StorageReference ref = storage.ref().child(p.basename(_image.path));
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        _url = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }

  /*void loadImage() async {
    var imageId = await ImageDownloader.downloadImage(_url);
    var path = await ImageDownloader.findPath(imageId);
    File image = File(path);
    setState(() {
      _image = image;
    });
  }
  */
}

 



