import 'package:flutter/material.dart';
import 'package:flutter_database/Pages/home.dart';
import 'package:flutter_database/DB_Connection/db_conn.dart';
import 'package:flutter_database/Pages/home2.dart';
import 'package:flutter_database/Pages/login.dart';

class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: ()async {
        
        Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sample app",style: TextStyle(color: Colors.black),),
              //Text("News",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
            ],
            ),
            //centerTitle: true,
            backgroundColor: Colors.blue,
          elevation: 0.0,
         ),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[SizedBox(height: 5.0,),
                                  Container(
                                  width: MediaQuery.of(context).size.width/1.9,
                                  child: ElevatedButton(
                                      child: Text('Add item'),
                                        onPressed: () async{
                                            //await localDatabase().addDataLocally(pid: pidController.text,pName: pnameController.text,pprice: puprceController.text,sprice: sepriceController.text);
                                            //await localDatabase().readAllData();
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => Home(name: null, pcode: null, pprice: null, sprice: null,image: null,),));
                                        },
                                  ),),
                                  SizedBox(height: 5.0,),
                                  Container(
                                    
                                  width: MediaQuery.of(context).size.width/1.9,
                                  child: ElevatedButton(
                                      child: Text('view item'),
                                        onPressed: () async{
                                            //await localDatabase().addDataLocally(pid: pidController.text,pName: pnameController.text,pprice: puprceController.text,sprice: sepriceController.text);
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => home2()),);
            
                                       },
                                  ),),
                                  SizedBox(height: 5.0,),
                                  Container(
                                    
                                  width: MediaQuery.of(context).size.width/1.9,
                                  child: ElevatedButton(
                                      child: Text('Logout'),
                                        onPressed: () async{
                                            //await localDatabase().addDataLocally(pid: pidController.text,pName: pnameController.text,pprice: puprceController.text,sprice: sepriceController.text);
                                            showAlertDialog();
            
                                       },
                                  ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  // Container(
                                  // width: MediaQuery.of(context).size.width/1.9,
                                  // child: ElevatedButton(
                                  //     child: Text('Save'),
                                  //       onPressed: () async{
                                  //           //await localDatabase().addDataLocally(pid: pidController.text,pName: pnameController.text,pprice: puprceController.text,sprice: sepriceController.text);
                                  //           //await localDatabase().readAllData();
                                  //       },
                                  // ),),
                                  ]),
        )
      ),
    );
  }
  showAlertDialog( ) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  ()async {
      Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
                          Navigator.of(context).pop();

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout",style: TextStyle(color: Colors.black54)),
    content: Text('Do you really want to logout?'),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}