import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/DB_Connection/db_conn.dart';
import 'package:flutter_database/Pages/home1.dart';
import 'package:flutter_database/Pages/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';




class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
final _formkey=GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FToast? fToast;
  bool _isObscured=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast=FToast();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator:(value){
                if(value == ''){
                  return "field is empty";
                }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isObscured,
                    decoration:InputDecoration(
                  suffixIcon: IconButton(
                  icon: Icon(!_isObscured ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                  border:OutlineInputBorder(),
                  label:Text(' password'),
                 ),
                    validator:(value){
                if(value == ''){
                  return "field is empty";
                }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    
                    onPressed: ()async {
                      // Handle button press
                      bool idExists = await localDatabase().login(usernameController.text??'', passwordController.text??'');
                      if(_formkey.currentState!.validate()){
                        if(!idExists){
                        _showToast("Invalid username or password");
                      }
                      else{  
                      Navigator.push(context,MaterialPageRoute(builder: (context) => home1()),);
                      
                        usernameController.clear();  
                        passwordController.clear();}
                      
                      }
                       },
                      
                      
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      Navigator.push(context,MaterialPageRoute(builder: (context) => signup()),);
                    },
                    child: Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  
    
  }
   _showToast(name) {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text(name),
        ],
        ),
    );


    fToast?.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
    
    // Custom Toast Position
    fToast?.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
}
}