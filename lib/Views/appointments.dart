import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:pixiltest/Views/detailAppointment.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {

  List<dynamic> appointmentsList = [];

  Future<String> getData() async {
    var url = Uri.parse('http://ec2-34-206-72-0.compute-1.amazonaws.com:8081/appointments');
    var response = await http.get(url, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      appointmentsList = jsonDecode(response.body);
    } else {

    }
    return Future.value("Data download successfully");
  }

  Future<void> _refresh() async {
    setState(() {
      getData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Appointments'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Please wait its loading...'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                        itemCount: appointmentsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: InkWell(
                                onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAppointment(appointment: appointmentsList[index],)))},
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name", style: TextStyle(fontSize: 16),),
                                      Text(appointmentsList[index]['name'] ?? "N/A" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Time", style: TextStyle(fontSize: 16),),
                                              Text(appointmentsList[index]['datetime'] == null ? "N/A" :  appointmentsList[index]['datetime'].substring(11) , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Status", style: TextStyle(fontSize: 16),),
                                              Text(appointmentsList[index]['status'] ?? "N/A" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: HexColor(appointmentsList[index]['statusColor'] ?? "#000000")),),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // child: ListTile(
                              //   // onTap: ()=>{createDialog(subsList[index]['email'])},
                              //   title: Text(appointmentsList[index]['name']),
                              //   subtitle: Text(appointmentsList[index]['datetime']),
                              // ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class Appointment {
  final String dateTime;
  final String name;
  final String status;
  final String statusColor;
  final String imageUrl;

  const Appointment({
    required this.dateTime,
    required this.name,
    required this.status,
    required this.statusColor,
    required this.imageUrl,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      dateTime: json['datetime'],
      name: json['name'],
      status: json['status'],
      statusColor: json['statusColor'],
      imageUrl: json['imageUrl'],
    );
  }
}