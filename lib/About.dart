import 'package:flutter/material.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue
              ),
              child: Column(
                 children: <Widget>[
                   FlatButton(
                     child: Image.asset('images/person.png'),
                     onPressed: (){

                     },
                   ),
                   Divider(color: Colors.black, height: 15,),
                   Text("about us", style: TextStyle(fontSize: 20),)
                 ],
              ),
            ),

            DesignButton("images/c.jpg", "about erbil",(){}),
            DesignButton("images/castl.jpg", "about erbil by video",(){})
          ],
        ),
      ),
    );
  }

  Widget DesignButton(String path ,String text,Function function){
    return Container(
      margin: EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue
      ),
      child: FlatButton(
        onPressed: function,
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(path),
              ),
            ),
            Text(text, style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }

}
