import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailsAppointment extends StatelessWidget {
  const DetailsAppointment({Key? key, this.appointment}) : super(key: key);

  final appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("On ${appointment['datetime'].split(' ')[0]}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundColor: Colors.grey.shade200,
              child: ClipRRect(
                child: Image.network(appointment['imageUrl'] ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/OOjs_UI_icon_userAvatar.svg/2048px-OOjs_UI_icon_userAvatar.svg.png" ),
                borderRadius: BorderRadius.circular(80.0),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name", style: TextStyle(fontSize: 16),),
                    Text(appointment['name'] ?? "N/A" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time", style: TextStyle(fontSize: 16),),
                            Text(appointment['datetime'] == null ? "N/A" :  appointment['datetime'].substring(11) , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Status", style: TextStyle(fontSize: 16),),
                            Text(appointment['status'] ?? "N/A" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: HexColor(appointment['statusColor'] ?? "#000000")),),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
