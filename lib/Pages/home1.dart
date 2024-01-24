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
        body:Column(
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
                                          showDataAlert();
    
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
                                ])
      ),
    );
  }
  showDataAlert( ) {
    var edit;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
          title: Text(
            "Create ID",
            style: TextStyle(fontSize: 24.0),
          ),
          content: Container(
            height: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Do you want to logout}? ",
                    ),
                  ),
    //               Container(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: TextField(controller: TextEditingController(text: title),
    //       onChanged: (text) {
    // edit = text;}
    //               )
    //               ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async{
                            Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
                          Navigator.of(context).pop();
                          },
                          child: Text(
                            "yes",
                          ),
                          
                        ),
                        SizedBox(width: 5.0,),
                        ElevatedButton(
                          onPressed: () {
                            
                            //updateNews(id,edit );
                            Navigator.of(context).pop();
                          },
                          
                          child: Text(
                            "No",
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                 
                ],
              ),
            ),
          ),
        );
      });
}
}