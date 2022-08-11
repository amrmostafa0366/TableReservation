import 'dart:convert';

import 'package:TableReservation/main.dart';
import 'package:TableReservation/user/restaurants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:TableReservation/user/restaurant.dart';

class Booking extends StatefulWidget {
  //final DocumentSnapshot restaurant;
  final  restaurant, category;
  Booking({this.restaurant, this.category});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String dropdownTime = 'Time';
  String dropdownDay = 'Day';
  String dropdownMonth = 'Month';
  String dropdownYear = 'Year';

  DateTime rdate;
  String strdate;
  final _firestore = Firestore.instance;

  TextEditingController name = new TextEditingController();
  String table = 'seats';
  String tablen = 'seats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Table Reservation',
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Customer name...',
              ),
              autofocus: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Card(
                  child: RaisedButton(
                      child: Text('Single\n Table',
                          style: TextStyle(fontSize: 15)),
                          
                      onPressed: () {
                        setState(() {
                          table = 'Single';
                          tablen = '1';
                         
                        });
                      })),
              Card(
                  child: RaisedButton(
                      child: Text('Double\n Table',
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() {
                          table = 'Double';
                          tablen = '2';
                        });
                      })),
              Card(
                  child: RaisedButton(
                      child: Text('Triple\n Table',
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() {
                          table = 'Triple';
                          tablen = '3';
                        });
                      })),
              Card(
                  child: RaisedButton(
                      child: Text('Quadruple\n    Table',
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() {
                          table = 'Quadruple';
                          tablen = '4';
                        });
                      })),
              Card(
                  child: RaisedButton(
                      child: Text('Quintuple\n    Table',
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() {
                          table = 'Quintuple';
                          tablen = '5';
                        });
                      })),
              Card(
                  child: RaisedButton(
                      child: Text('Sextuple\n   Table',
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() {
                          table = 'Sextuple';
                          tablen = '6';
                        });
                      })),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(2.0)),
                Container(
                  child: DropdownButton<String>(
                    value: dropdownTime,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 15,
                    style: TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownTime = newValue;
                      });
                    },
                    items: <String>[
                      'Time',
                      '00:00',
                      '01:00',
                      '02:00',
                      '03:00',
                      '04:00',
                      '05:00',
                      '06:00',
                      '07:00',
                      '08:00',
                      '09:00',
                      '10:00',
                      '11:00',
                      '12:00',
                      '13:00',
                      '14:00',
                      '15:00',
                      '19:00',
                      '20:00',
                      '21:00',
                      '22:00',
                      '23:00',
                      '24:00',
                    ].map<DropdownMenuItem<String>>((String time) {
                      return DropdownMenuItem<String>(
                        value: time,
                        child: Text(time),
                      );
                    }).toList(),
                  ),
                ),
                Padding(padding: EdgeInsets.all(2.0)),
                Container(
                  child: DropdownButton<String>(
                    value: dropdownDay,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 15,
                    style: TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownDay = newValue;
                      });
                    },
                    items: <String>[
                      'Day',
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '15',
                      '15',
                      '15',
                      '19',
                      '20',
                      '21',
                      '22',
                      '23',
                      '24',
                      '25',
                      '26',
                      '27',
                      '28',
                      '29',
                      '30',
                      '31'
                    ].map<DropdownMenuItem<String>>((String day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                  ),
                ),
                Padding(padding: EdgeInsets.all(2.0)),
                Container(
                  child: DropdownButton<String>(
                    value: dropdownMonth,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 15,
                    style: TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownMonth = newValue;
                      });
                    },
                    items: <String>[
                      'Month',
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December'
                    ].map<DropdownMenuItem<String>>((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                  ),
                ),
                Padding(padding: EdgeInsets.all(2.0)),
                Container(
                  child: DropdownButton<String>(
                    value: dropdownYear,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 15,
                    style: TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownYear = newValue;
                      });
                    },
                    items: <String>[
                      'Year',
                      '2021',
                      '2022',
                      '2023',
                      '2024',
                      '2025',
                      '2026'
                    ].map<DropdownMenuItem<String>>((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Container(
                  child: ButtonTheme(
                    minWidth: 25.0,
                    child: RaisedButton(
                        child: Text(
                          tablen,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        color: Colors.grey,
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: RaisedButton(
                child: Text(
                  'Reserve',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                color: Colors.red,
                onPressed: () async{
                  setState(() {
                    rdate = DateTime.now();
                    strdate = rdate.toString();
                  });
                  //   Navigator.push(context,MaterialPageRoute(builder: (context)=>Restaurants()));
                  Map<String, dynamic> _data = {
                    'customer name': name.text,
                    //   'category':widget.restaurant.data['category'],
                    //   'restaurant name':widget.restaurant.data['name'],
                    'category': widget.category,
                    'restaurant name': widget.restaurant.data['name'],
                    'reserved table': table,
                    'reservation date': dropdownTime +
                        ', ' +
                        dropdownDay +
                        ' ' +
                        dropdownMonth +
                        ' ' +
                        dropdownYear,
                    'reserved at': strdate,
                  };
                  _firestore.collection("Reservations").add(_data);

///////////////////////////

                  final notificationUrl = 'https://fcm.googleapis.com/fcm/send';
                  try {
                    await http.post(
                      notificationUrl,
                      headers: {
                        "Authorization":
                            "key=AAAAtwN62gE:APA91bEmNtuIMl5P9EQJXKkOzmOB2rjTxhvTbZK5OAhkt4sPx6zzWHCH3R_WoUKBzCGCHbJq8gnsdr4OQdNsBEyJNnUzXiKhBWYEG2aFFAV-Pgs787u2nbPc4oearwg-be8ObbKlnE7q",
                        "Content-Type": "application/json",
                      },
                      body: json.encode({
                        "to": "/topics/vendor",
                        "collapse_key": "type_a",
                        "notification": {
                          "body": "${name.text} reserved $table table in ${widget.restaurant.data['name']}",
                          "title": "new table reserved"
                        }
                      }),
                    );
                  } catch (error) {
                    print(error);
                    throw error;
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                }),

                
          ),
        ),
        
      ]),
    );
  }
}
