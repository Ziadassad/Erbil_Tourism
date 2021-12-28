import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DBHelper.dart';
import 'Member.dart';

class SiginUp extends StatelessWidget {
  String name = "";
  String pass = "";
  String email = "";
  String passConfirm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Text("Sgin Up",
                        style: TextStyle(fontSize: 40, color: Colors.blue))),
                Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          border: InputBorder.none,
                                          hintText: 'User Name'),
                                      onChanged: (String str) {
                                        name = str;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 28, left: 8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.email),
                                          border: InputBorder.none,
                                          hintText: 'Email'),
                                      onChanged: (str) {
                                        email = str;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 28, left: 8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.lock),
                                          border: InputBorder.none,
                                          hintText: 'Password'),
                                      onChanged: (String str) {
                                        pass = str;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 28, left: 8),
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.lock),
                                          border: InputBorder.none,
                                          hintText: 'Confirm Password'),
                                      onChanged: (str) {
                                        passConfirm = str;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue),
                  child: FlatButton(
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (name == "" ||
                          email == "" ||
                          pass == "" ||
                          passConfirm == "") {
                        message("Maybe One field is empty");
                      } else {
                        try {
                          Member me = new Member(null, name, email, pass);
                          DBHelper db = DBHelper.dbInstance;
                          db.insertMember(me);
                          Navigator.pop(context);
                          message("Add Account Successfully");
                        } catch (err) {
                          message("Add Account not Successfully");
                        }
                      }
                    },
                  ),
                )
              ],
            ),
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
}
