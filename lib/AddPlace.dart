import 'package:firstapp/DBHelper.dart';
import 'package:firstapp/DBTourism.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'Utility.dart';

class AddPlace extends StatefulWidget {
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  String name = "";
  String address = "";
  int typeInsert = -1;
  int select = -1;
  double late, lang;

  var txtName = TextEditingController();
  var txtAddress = TextEditingController();
  var txtLate = TextEditingController();
  var txtLang = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    select = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("AppPlace"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Name Place",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: txtName,
                  onChanged: (String str) {
                    name = str;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Address",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: txtAddress,
                  onChanged: (String str) {
                    address = str;
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      ShowDialig(context);
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Card(
                        child: Center(child: isImage()),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Color.fromARGB(100, 200, 50, 50))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          width: 180,
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "late",
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                late = double.parse(value);
                              },
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: 180,
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "lang",
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                lang = double.parse(value);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: select,
                            onChanged: (val) {
                              typeInsert = val;
                              check(val);
                              print(val);
                            },
                          ),
                          Text("Hotel"),
                          Radio(
                            value: 2,
                            groupValue: select,
                            onChanged: (val) {
                              check(val);
                              typeInsert = val;
                              print(val);
                            },
                          ),
                          Text("Resturant"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 3,
                            groupValue: select,
                            onChanged: (val) {
                              check(val);
                              typeInsert = val;
                              print(val);
                            },
                          ),
                          Text("Tourism"),
                          Radio(
                            value: 4,
                            groupValue: select,
                            onChanged: (val) {
                              check(val);
                              typeInsert = val;
                              print(val);
                            },
                          ),
                          Text("Shop"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      if (typeInsert == -1) {
                        message("Plaease Select One Place");
                      } else if (name == "" &&
                          address == "" &&
                          imageString == "") {
                        message("Maybe one filled is impty");
                      } else {
                        print("${imageString} aaa");
                        try {
                          DBTourism insert = new DBTourism(
                              null, name, address, imageString, late, lang);
                          DBHelper dbHelper = DBHelper.dbInstance;
                          switch (typeInsert) {
                            case 1:
                              dbHelper.insertHotel(insert);
                              break;
                            case 2:
                              dbHelper.insertResturant(insert);
                              break;
                            case 3:
                              dbHelper.insertTourism(insert);
                              break;
                            case 4:
                              dbHelper.insertShop(insert);
                              break;
                          }
                          txtLang.clear();
                          txtLate.clear();
                          txtName.text = "";
                          txtAddress.text = "";
                          imageFile = null;
                          imageString = "";
                          message("Insert Data successed");
                        } catch (err) {
                          message("Insert Data not successed");
                        }
                      }
                    });
                  },
                  child: Text("Save"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blue)),
                ),
                width: 180,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  check(int val) {
    setState(() {
      select = val;
    });
  }

  String imageString = "";
  File imageFile;

  _openCamera(BuildContext context) async {
    File picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageString = Utility.base64String(picture.readAsBytesSync());
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _opnGallary(BuildContext context) async {
    File picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
      imageString = Utility.base64String(picture.readAsBytesSync());
    });
    Navigator.of(context).pop();
  }

  isImage() {
    if (imageFile == null) {
      return Icon(
        Icons.add_a_photo,
        size: 100,
      );
    } else {
      return Image.file(
        imageFile,
        width: 200,
        height: 200,
      );
    }
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
}
