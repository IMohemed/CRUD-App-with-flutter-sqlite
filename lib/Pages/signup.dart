import 'package:flutter/material.dart';
import 'package:flutter_database/DB_Connection/db_conn.dart';
import 'package:flutter_database/Pages/login.dart';
import 'package:fluttertoast/fluttertoast.dart';




class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
   final _formkey=GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  FToast? fToast;

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
        
        Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
        return false;
      },
      child: Scaffold(
        
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: Padding(
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
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                ElevatedButton(
                  onPressed: () async{
                    // Handle button press
                    bool idExists = await localDatabase().login(usernameController.text??'', passwordController.text??'');
                   if(_formkey.currentState!.validate()){
                                           if(idExists){
                                                    _showToast("Id exists");
                                             }
                                            else{
                                              await localDatabase().save(pid: passwordController.text,pName: usernameController.text);
                                               _showToast("Saved successfully");
                                              Navigator.of(context).pop();
                                              }
                                            }
                                             
                                            
              
                    // Add your logic for handling username and password
                   // print('Username: $username, Password: $password');
                  },
                  child: Text('Save'),
                ),
                
              ],
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
            Text("${name}"),
        ],
        ),
    );


    fToast?.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
    
    // Custom Toast Position
    // fToast?.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
}
}