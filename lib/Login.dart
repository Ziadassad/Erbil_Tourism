import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'SiginUp.dart';
import 'animation.dart';
import 'DBHelper.dart';
import 'Member.dart';
import 'SharesPerformance.dart';

class Login extends StatelessWidget {
  String name;
  String pass;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 150,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        left: 300,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.7,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: FadeAnimation(
                              1.9,
                              Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: Theme(
                                data: ThemeData(hintColor: Colors.black45),
                                child: TextField(
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      border: InputBorder.none,
                                      hintText: 'User Name'),
                                  onChanged: (String str) {
                                    name = str;
                                    print(str);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Theme(
                                data: ThemeData(hintColor: Colors.black45),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.lock),
                                      border: InputBorder.none,
                                      hintText: 'Password'),
                                  onChanged: (str) {
                                    pass = str;
                                    print(str);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue),
                  child: FlatButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Shared sh = new Shared();
                      print("click");
                      bool t = false;
                      DBHelper db = DBHelper.dbInstance;
                      List<Member> list = await db.getMember();

                      if (name == "ziad" && pass == "ziad1234") {
                        t = true;
                        sh.isLogin(true);
                        sh.setAccount(name, "ziad.assad.10@gmail.com");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                            (Route<dynamic> route) => false);
                      } else {
                        for (int i = 0; i < list.length; i++) {
                          print(list[i].name);
                          if (list[i].name == name &&
                              list[i].password == pass) {
                            t = true;
                            sh.isLogin(true);
                            sh.setAccount(name, list[i].email);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                                (Route<dynamic> route) => false);
                            // break;
                          }
                        }
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue),
                  child: FlatButton(
                    child: Text(
                      "Sigin Up",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SiginUp()));
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
