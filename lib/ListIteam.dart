import 'package:firstapp/DBHelper.dart';
import 'package:firstapp/DBTourism.dart';
import 'package:firstapp/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Utility.dart';
import 'DBTourism.dart';

class ListIteam extends StatefulWidget {

  String tableName;

  ListIteam(this.tableName);

  @override
  _ListIteam createState() => _ListIteam();

}

class _ListIteam extends State<ListIteam> {
  DBHelper dbHelper;
  String _tableName;
  @override
  void initState() {
    // TODO: implement initStat
    dbHelper = DBHelper.dbInstance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch(widget.tableName){
      case "Hotel":
        _tableName = Languages.of(context).getLocal('listHotels');
        break;
      case "Restuarant":
        _tableName = Languages.of(context).getLocal('listRestaurants');
        break;
      case "Tourism":
        _tableName = Languages.of(context).getLocal('listTorisms');
        break;
      case "Shop":
        _tableName = Languages.of(context).getLocal('listShop');
        break;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_tableName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                this.setState(() {

                });
              },
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder<List<DBTourism>>(
            future: DBHelper.dbInstance.getData(widget.tableName),
            initialData: List(),
            builder: (context, AsyncSnapshot<List<DBTourism>> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int position) {
                        DBTourism tourism = snapshot.data[position];
                        return GestureDetector(
                          onLongPress: () {
                              showDialogs(tourism.id ,widget.tableName);
                          },
                          child: Container(
                            height: 200,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: <Widget>[
                                  Container(width: double.infinity , height: 150 , child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Utility.imageFromBase64String(tourism.image))),
                                  Text(tourism.name),
                                  Text(tourism.address)
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }


  showDialogs(int id , String table) {
    Alert(context: context,
        title: "Selected One",
        content: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: DialogButton(
                child: Text("Update"),
                onPressed: (){
                    Navigator.pop(context);
                    showDialog(context: context,
                        builder: (context) {
                          return ShowUpdate(id , table);
                        }
                    );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: DialogButton(
                child: Text("Delete"),
                onPressed: (){
                  Navigator.pop(context);
                  showDelete(id, table);
                },
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          )
        ]
    ).show();
  }

  showDelete(int id , table) {
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Do you want delete this iteam"),
          actions: <Widget>[
            FlatButton(
              child: Text("delte"),
              onPressed: (){
                this.setState(() {
                  DBHelper db = DBHelper.dbInstance;
                  db.delete(id, table);
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              child: Text("close"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }
}






class ShowUpdate extends StatefulWidget {

  int id;
  String tableName;
  ShowUpdate(this.id , this.tableName);

  @override
  _ShowUpdateState createState() => _ShowUpdateState();
}

class _ShowUpdateState extends State<ShowUpdate> {


  String _tableName;
  int id;
  String imagePath;
  Future<File> imageFile;
  String name , address;
  DBHelper db;
  List<DBTourism> data;

  getData() async{
    db = DBHelper.dbInstance;
    data = await db.getData(_tableName);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id = widget.id;
    _tableName = widget.tableName;
    print(_tableName);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                    ShowDialig(context);
                },
                child: showImage(),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (value){
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'address',
                ),
                onChanged: (value){
                  address = value;
                },
              ),
              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {

                    setState(() {
//                      print(data[id].lat);
                      DBTourism tour = new DBTourism(id , name , address ,imagePath, 10.3 , 10.4);
                      db.update(tour.toMap(), _tableName);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showImage(){
    return FutureBuilder<File>(
      future: imageFile,
      builder:  (context , snapshot){
        if(!snapshot.hasData){

          return CircleAvatar(
            radius: 55,
            backgroundColor: Colors.blue,
            child: Icon(Icons.add_a_photo , size: 85, color: Colors.black,),
          );
        }
        else{
          return  Image.file(
              snapshot.data,
              width: MediaQuery.of(context).size.width,
              height: 100,
          );
        }
      }
    );
  }

  Future<void> ShowDialig(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Chioce Your Image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text("Opne Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text("Opne Gallary"),
                      onTap: () {
                        _opnGallary(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }


  _openCamera(BuildContext context) async {
    this.setState(() async{
      imageFile = ImagePicker.pickImage(source: ImageSource.camera);
      File picture = await imageFile;
      imagePath = Utility.base64String(picture.readAsBytesSync());
    });
    Navigator.of(context).pop();
  }

  _opnGallary(BuildContext context) async {
    imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    File picture = await imageFile;
    this.setState(() {
      imagePath = Utility.base64String(picture.readAsBytesSync());
    });
    Navigator.of(context).pop();
  }
}
