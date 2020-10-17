import 'package:cropmedic/Prediction.dart';
import 'package:cropmedic/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Prediction.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetectMain())),
        ),
        title: Text(
          "Crop Medic Plus 2.0",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.teal,
        centerTitle: false,
      ),

      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),

              Image(
                image: AssetImage("assets/icon.PNG"),
                height: 320,
              ),

              SizedBox(
                height: 15,
              ),

              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f3),
                  filled: true,
                  labelText: "Email ID",
                  prefixIcon: Icon(Icons.email, color: Colors.green),
                ),
                validator: validateEmail,
                autovalidate: false,
                onSaved: (input) => _email = input,
//              decoration: InputDecoration(
//                  labelText: "Email"
//              ),
              ),
              SizedBox(height: 20),

              TextFormField(
                validator: validatePassword,
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  labelText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                ),
                obscureText: true,
              ),

//            RaisedButton(
//              onPressed: signIn,
//              color: Colors.indigo,
//              height:,
//              child: Text('Sign In'),
//            ),
              SizedBox(
                height: 30,
              ),

              SizedBox(
                  height: 50,
                  width: 380,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.teal)),
                    onPressed: signIn,
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Text("Sign In".toUpperCase(),
                        style: TextStyle(fontSize: 16)),
                  )),

              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 95,
                    ),
                    Text(
                      'Don\'t have an account ?',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )),
              )
            ],
          ))),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetectMain()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter the email address';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid Email! Please Enter the Valid Email address';
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return ' Please enter the Password';
    } else if (value.length < 6) {
      return "Your password needs to be atleast 6 characters";
    }
  }
}
