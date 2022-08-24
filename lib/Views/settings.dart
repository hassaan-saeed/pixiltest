import 'package:flutter/material.dart';
import 'package:pixiltest/Views/login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Settings'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffb10505),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()))
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 14, horizontal: 40),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
