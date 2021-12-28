import 'package:firstapp/SharesPerformance.dart';
import 'package:firstapp/language.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './ListPlace.dart';
import './AddPlace.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text( Languages.of(context).getLocal('titlehome'),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Carousel(
                  images: [
                    AssetImage("images/c.jpg"),
                    AssetImage("images/castl.jpg"),
                    AssetImage("images/erbil3.jpg"),
                    AssetImage("images/erbil4.jpg"),
                  ],
                  borderRadius: true,
                  dotColor: Colors.blue,
                ),
              ),
              width: double.infinity,
              height: 430,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  var f = Future.delayed(Duration(seconds: 6), () => 12);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListPlace()));
                },
                child: Text(Languages.of(context).getLocal('places')),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.blue)),
              ),
              width: 180,
            ),
            SizedBox(
              height: 5,
            ),
            FutureBuilder(
              future: Shared().getaccount(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.data == null) {
                  return Container();
                } else {
                  if(snapshot.data[0] == "ziad") {
                    return isAdmin(); // render(snapshot.data[0] , snapshot.data[1] );
                  }else{
                    return Container();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  isAdmin() {
    return SizedBox(
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          var f = Future.delayed(Duration(seconds: 6), () => 12);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPlace()));
        },
        child: Text(Languages.of(context).getLocal('addplace')),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.blue)),
      ),
      width: 180,
    );
  }
}