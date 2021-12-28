import 'package:firstapp/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'ListIteam.dart';

class ListPlace extends StatefulWidget {
  @override
  _ListPlaceState createState() => _ListPlaceState();
}

class _ListPlaceState extends State<ListPlace> {

  void Hotel(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListIteam("Hotel")));
  }
  void Resturant(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListIteam("Restuarant") ));
  }
  void tourism(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListIteam("Tourism") ));
  }
  void shop(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListIteam("Shop")));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.teal,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).getLocal('listplace')),
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.only(bottom: 15),
            children: <Widget>[
              DesignCard("hotel.jpg", Languages.of(context).getLocal('listHotels') ,Hotel),
              DesignCard("restorants.jpg",Languages.of(context).getLocal('listRestaurants'),Resturant),
              DesignCard("tourism.jpg",Languages.of(context).getLocal('listTorisms'),tourism),
              DesignCard("shoping.jpg",Languages.of(context).getLocal('listShop'), shop),
            ],
            addAutomaticKeepAlives: true,
          ),
        ),
      ),
    );
  }
}

class DesignCard extends StatelessWidget {
  final String pathImage;
  final String name;
  final Function function;
  DesignCard(this.pathImage, this.name , this.function);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.all(2),
        onPressed: (){
          function();
        },
        child: Card(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset("images/$pathImage", fit: BoxFit.fill,),
                  )
              ),
              Text(
                name,
                textAlign: TextAlign.center,
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
      ),
    );
  }
}
