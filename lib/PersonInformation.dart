import 'package:firstapp/language.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SharesPerformance.dart';
import 'Login.dart';

class PersonInformation extends StatefulWidget {
  @override
  _PersonInformationState createState() => _PersonInformationState();
}

class _PersonInformationState extends State<PersonInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Text(Languages.of(context).getLocal('useraccount'),
                style: TextStyle(fontSize: 30),
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
              ),
              FutureBuilder(
                future: Shared().getaccount(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.data == null) {
                    return Container(child: Center(child: Text("Nothing found"),),);
                  } else {
                    return render(snapshot.data[0] , snapshot.data[1] );
                  }
                },
              ),
              Container(
                width: 200,
                margin: EdgeInsets.only(top: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red[400]
                ),
                child: FlatButton(
                  child: Text(Languages.of(context).getLocal('logout')),
                  onPressed: (){
                    Shared sh = new Shared();
                    sh.isLogin(false);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  render(name , email) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${Languages.of(context).getLocal('Name')} : ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(" ${name}" , style:TextStyle(fontSize: 25) ,),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${Languages.of(context).getLocal('email')} : " , style: TextStyle(fontSize: 20)),
                Text(email , style: TextStyle(fontSize: 20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

