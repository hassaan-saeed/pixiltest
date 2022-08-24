import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _pass = '';

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 5),
        content: Text(value)
    ));
  }

  loginUser() async {
    try {
      var url = Uri.parse('http://ec2-34-206-72-0.compute-1.amazonaws.com:8081/login');
      var data = {'email': _email, 'password': _pass};
      var body = json.encode(data);
      var response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(response.statusCode == 200){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home()));
      }
    } catch (e) {
      print('error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty
                          ? 'PLease enter email!'
                          : null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: '   Email',
                      prefixIcon: Icon(Icons.mail, color: Colors.deepPurpleAccent,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0))),
                    ),
                    onChanged: (text){
                      _email = text;
                    },
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty
                          ? 'PLease enter password!'
                          : null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: '   Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.deepPurpleAccent,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0))),
                    ),
                    onChanged: (text){
                      _pass = text;
                    },
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () => {
                      if (_formKey != null)
                        {
                          if (_formKey.currentState!.validate())
                            {
                              loginUser()
                            }
                        }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 14, horizontal: 40),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
