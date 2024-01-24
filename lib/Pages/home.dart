import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/DB_Connection/db_conn.dart';
import 'package:flutter_database/Pages/home1.dart';
import 'package:flutter_database/Pages/home2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class Home extends StatefulWidget {
  //const Home({super.key});
  String? name;
  int? pcode;
  double? pprice,sprice;
  String? image;

  Home({ this.name,required this.pcode,required this.pprice,required this.sprice, this.image});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formstate = GlobalKey<FormState>();
  FToast? fToast;
  List wholedata = [];
  bool pidExistsInWholeData=false;
  Uint8List? selectedImage,selectedImage1;
  File? _image;
  File? _image1;
  final imagePicker = ImagePicker();
  
  String? img;
  @override
  void initState() {
    //checkdata();
    //_pickimage();
    getdata();
    super.initState();
    fToast=FToast();
    if (widget.image != null) {
      _image = File(widget.image!);
      selectedImage = _image?.readAsBytesSync();
      img = widget.image;
    }
  }
  getdata()async{
    localDatabase local= localDatabase();
    
    await local.readAllData();
    setState(() {
      wholedata = local.wholedata;
    });
    print(wholedata);
  }
  
  TextEditingController pidController = TextEditingController();
    TextEditingController pnameController = TextEditingController();
    TextEditingController puprceController = TextEditingController();
    TextEditingController sepriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    

    // if(widget.name!=null && widget.name!=null && widget.name!=null && widget.name!=null){
      
    // }
    pidController = widget.pcode != null ? TextEditingController(text: "${widget.pcode}") : pidController;
    pnameController = widget.name != null ? TextEditingController(text: widget.name) : pnameController;
    puprceController = widget.pprice != null ? TextEditingController(text: "${widget.pprice}") : puprceController;
    sepriceController = widget.sprice != null ? TextEditingController(text:"${ widget.sprice}") : sepriceController;

    //final _db=databasehelper;

    int? editedText1;
    String? editedText2;
    double? editedText3,editedText4;
    // if(widget.image!= null ){
    //   if(PickedFile == null){
    //             //setState(() {
    //               img=widget.image;
    //               _image1=File(widget.image!);
    //               selectedImage = _image1?.readAsBytesSync();
    //             //});
    //             print('you selected ${selectedImage1}');}
              
    //           else selectedImage=selectedImage;}
             
              
    return Scaffold(
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
       body: SingleChildScrollView(
        
         child: Column(
          
           
          key: _formstate,
          children: [
            //SingleChildScrollView(),
            
            
            //  TextField(controller:TextEditingController(text: widget.name)),
            //   TextField(controller:TextEditingController(text: widget.pcode.toString())),
            //   TextField(controller:TextEditingController(text: widget.pprice.toString())),
            //   TextField(controller:TextEditingController(text: widget.sprice.toString())),
            SizedBox(height: 10.0,),
            TextField(controller: pidController,
               keyboardType: TextInputType.number,
               enabled: widget.pcode == null,
               inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly
               ],
               decoration:InputDecoration(
                border:OutlineInputBorder(),
                label:Text('number')
               )
         //         onChanged: (text) {
         //         editedText1 = int.tryParse(text);
         // }, 
            ),
            SizedBox(height: 10.0,),
            //if(widget.name!=null)TextField(controller:TextEditingController(text: widget.pcode.toString())),
            TextFormField(controller: pnameController,
            validator:(value){
                if(value == ''){
                  return "field is empty";
                }
            },
            onChanged: (text) {
            editedText2 = text;
         },
         decoration:InputDecoration(
                border:OutlineInputBorder(),
                label:Text('name')
               ) 
            ),
            SizedBox(height: 10.0,),
            
            TextFormField(controller: puprceController,
            validator:(value){
                if(value == ''){
                  return "field is empty";
                }
            },
            keyboardType: TextInputType.number,
            
               decoration:InputDecoration(
                border:OutlineInputBorder(),
                label:Text('Purchase price')
               )
        
            ),
            SizedBox(height: 10.0,),
            
            TextFormField(controller: sepriceController,
            keyboardType: TextInputType.number,
            validator:(value){
                if(value == ''){
                  return "field is empty";
                }
            },
               decoration:InputDecoration(
                border:OutlineInputBorder(),
                label:Text('Selling price')
               )
         //          
            ),
            
            SizedBox(height: 5.0,),
            selectedImage!=null? CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(selectedImage!),
            ):const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://th.bing.com/th/id/OIP.UoP79f2D8ELqNgSbt02C1wHaHa?rs=1&pid=ImgDetMain"),
            ),
            ElevatedButton(
              onPressed: () async {
                // Pick image from gallery
                showDataAlert();
              },
              child: Text('Pick Image'),
            ),
                                Container(
                                width: MediaQuery.of(context).size.width/1.9,
                                child: ElevatedButton(
                                    
                                    child: Text('Save'),
                                      onPressed:widget.pcode != null ? null:() {
                                        handleElevatedButtonPress();
                                          //await localDatabase().readAllData();
                                      },
                                ),),
                                Container(
                                width: MediaQuery.of(context).size.width/1.9,
                                child: ElevatedButton(
                                    child: Text('update'),
                                      onPressed:widget.pcode != null ? () async{
                                          await localDatabase().updateData(Name: pnameController?.text,id: pidController?.text,pprice: puprceController?.text,sprice: sepriceController?.text,image: img);
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => home2()));
                                          //await localDatabase().readAllData();
                                      }:null,
                                ),)
          ],
         ),
       ),
    );
  }
  // 
  
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
  Future _pickimage() async{
    try{
              final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
               //String? img=pickedFile?.path;
              if (pickedFile== null) return;
              
                 
                // Convert image to Uint8List
                //final bytes = await pickedFile.readAsBytes();
                
                  
                  setState(() {
                    _image=File(pickedFile!.path);
                  selectedImage = _image?.readAsBytesSync();
                  });
                
                Navigator.of(context).pop();
                //String img=Utility.
                img=pickedFile!.path;
                print(img);
              }
              catch(e){
                print("");
                //return "error";
              }
  }
  Future _takeimage() async{
    try{
              final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
               //String? img=pickedFile?.path;
              if (pickedFile== null) return;
              
                 
                // Convert image to Uint8List
                //final bytes = await pickedFile.readAsBytes();
                
                  
                  setState(() {
                    _image=File(pickedFile!.path);
                  selectedImage = _image?.readAsBytesSync();
                  });
                
                Navigator.of(context).pop();
                //String img=Utility.
                img=pickedFile!.path;
                print(img);
              }
              catch(e){
                print("");
                //return "error";
              }
  }
  void handleElevatedButtonPress()async {
  // Do something with the index, e.g., show a toast or navigate to another screen
   bool idExists = await localDatabase().isIdAlreadyExists(pidController.text ?? '');
  if(_formstate.currentState!.validate() && selectedImage != null){
                                       if(idExists){
                                          _showToast("Alreadyexists");
                                        }
                                        else{
                                          await localDatabase().addDataLocally(pid: pidController?.text,pName: pnameController?.text,pprice: puprceController?.text,sprice: sepriceController.text,imag: img );
                                        _showToast("Saved successfully!");
                                        }
                                        }
                                         
                                        else{
                                         // _showToast();
                                        }
                                        
}
showDataAlert() {
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
            "Image",
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
                      "select the action? ",
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
                            _takeimage();},
                          
                          child: Text(
                            "camera",
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        ElevatedButton(
                          
                            
                            //updateNews(id,edit );
                           onPressed: () async{
                            _pickimage();
                          },
                          
                          child: Text(
                            "gallery",
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