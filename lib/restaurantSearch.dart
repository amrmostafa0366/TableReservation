import 'package:TableReservation/user/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantSearch extends SearchDelegate<String> {
  final _firestore = Firestore.instance;
  String name, image, description, category;

  List<dynamic> list;

  RestaurantSearch({this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Restaurants').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            final dat = snapshots.data.documents;
            for (var nam in dat) {
              if (query == nam.data['name']) {
                image = nam.data['image'];
                name = nam.data['name'];
                category = nam.data['category'];
                description = nam.data['description'];

                return ListView(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.network(
                            image,
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
                                  name,
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
                                  category,
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
                                      description,
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
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  print(name);
                                  print(category);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Booking(
                                              restaurant: name,
                                              category: category)));
                                  //   navigateToBooking();
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => Booking(restaurant: widget.restaurant)));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
          }
          return Text('');
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var searchlist =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.restaurant),
            title: Text(searchlist[i]),
            onTap: () {
              query = searchlist[i];
              showResults(context);
            },
          );
        });
  }
}
