import 'package:flutter/material.dart';

import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset("assets/pixil.png"),
        ),
      ),
    );
  }

}
