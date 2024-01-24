import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/Pages/home.dart';
import 'package:flutter_database/DB_Connection/db_conn.dart';
import 'package:flutter_database/Pages/home1.dart';

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  List wholedata=[];
  File? imag;
  Uint8List? selectedImage;
  @override
  void initState() {
    getdata();
    super.initState();
    
    //deletedata();
  }

  getdata()async{
    localDatabase local= localDatabase();
    
    await local.readAllData();
    wholedata = local.wholedata;
    setState(() {
      
    });
    print(wholedata);
  }
  // deletedata(String id){
  //   localDatabase local= localDatabase();
    
  //   // await local.deletedata(id);
  //   // await local.readAllData();
  //   wholedata.removeWhere((item) => item['prodName'] == id); 
  //   setState(() {
  //    wholedata ;
  //   });
  //   print(wholedata);
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        
        Navigator.push(context,MaterialPageRoute(builder: (context) => home1()),);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
      leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => home1()),);
        
      },
      ),
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
         body: ListView.builder(
            
            itemCount: wholedata.length,
            itemBuilder: (BuildContext context, int index) {
             var pcode = wholedata[index]["prodCode"];
              var pname=wholedata[index]["prodName"];
              var pprice=wholedata[index]["purPrice"];
              var sprice=wholedata[index]["sellPrice"];
              var img=wholedata[index]["image"];
    
              
                
                 //String? img=pickedFile?.path;
                if (img != null) 
                   {
                  // Convert image to Uint8List
                  //final bytes = await pickedFile.readAsBytes();
                  //setState(() {
                    
                    imag=File(img);
                    selectedImage = imag?.readAsBytesSync();}
                  //});}
                  //Navigator.of(context).pop();
                  //String img=Utility.
                  //img=pickedFile.path;
                  print('path is ${selectedImage}');
                
                
              
              return GestureDetector(
                  onTap: ()=> {
                   // _showToast(context)
                    },
                 
                child:Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 6.0),
                    child: Material(
                      
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 4.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:25.0),
                                child: img!=null? CircleAvatar(
                                                radius: 50,
                                                backgroundImage: MemoryImage(selectedImage!),
                                              ):const CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage("https://icon-library.com/images/add-image-icon-png/add-image-icon-png-21.jpg"),
                                              ),
                              ),
                              SizedBox(width: 7.0,),
                              
                              Padding(
                                padding: EdgeInsets.only (left:20.0),
                                child: Column(
                                
                                  children: [Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("product code:  ${pcode}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("Product Name:  ${pname}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("purchase price:  ${pprice}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.9,
                                    child: Text("Selling price:  ${sprice}",maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.w500),)
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      Container(
                                      width: MediaQuery.of(context).size.width/1.9,
                                      child: OutlinedButton.icon(
                                          label: Text('Delete',style: TextStyle(color: Colors.red[400])),
                                          icon: Icon(Icons.delete),
                                            onPressed: () async{
                                              showAlertDialog(pcode);
                                },
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                  Container(
                                  width: MediaQuery.of(context).size.width/1.9,
                                  child: OutlinedButton.icon(
                                      label: Text('update',),
                                      icon: Icon(Icons.edit_sharp),
                                        onPressed: (){
                                                        Navigator.push(context,MaterialPageRoute(builder: (context) => Home(pcode: pcode, pprice: pprice, sprice: sprice)),);
                                                    }
                                  ),
                                ),]
                                ),
                              ),
                              
                            ],
                          ),
                      ),
                      
                    ),
                  ),
                ),
                );
              
            },
            
            )
            
      ),
    );
  }
  showAlertDialog( uname) {

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
      localDatabase local = localDatabase();
                              await local.deletedata(id: uname);
    
                              await local.getData();
                               //Navigator.of(context).pop();
                              wholedata=local.wholedata;
                             setState(() {
                               wholedata;
                             });
                             Navigator.of(context).pop();

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete",style: TextStyle(color: Colors.red[700])),
    content: Text('Do you really want to delete the username "${uname}"?'),
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