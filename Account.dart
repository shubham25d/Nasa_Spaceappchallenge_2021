import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

          height: 190,
          //color: Color.fromRGBO(75, 132, 241,1),
          child: Card(
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.account_circle, color: Color.fromRGBO(75, 132, 241,1), size: 130, ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left:120),
                          child: Text("Simon Peterson", style: TextStyle(color: Color.fromRGBO(75, 132, 241,1), fontSize: 20, fontWeight: FontWeight.bold),)),
                      Icon(Icons.edit, color: Color.fromRGBO(75, 132, 241,1)),
                    ],
                  )

                ],
              ),

            ),
          ),
        ),
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(20,0,0,0),
            child: Text("Connected Solar Panel Tracker Apps")),
        Card(
            child:Padding(
              padding : EdgeInsets.fromLTRB(20,20,0,20),
              child: Row(
                children: [
                  Expanded(flex:1,child: Icon(Icons.delete)),
                  Expanded(flex:4, child: Text("SMA Energy", style: TextStyle(fontSize: 20))),
                ],
              ),
            )
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right:3),
          child: RaisedButton(
              color:  Color.fromRGBO(75, 132, 241,1),
              child: Text("Add", style: TextStyle(color: Colors.white)),
              onPressed:(){

                showDialog(context: context, builder: (BuildContext context) => showAlertDialog(context));

              }
          ),
        )
      ],
    );
  }

  showAlertDialog(BuildContext context) {

    return AlertDialog(
      //backgroundColor: Color.fromRGBO(75, 132, 241,1),


        title: Container(
            child: Text('Select your solar tracker app', style: TextStyle(color: Colors.black54))
        ),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Row(
                  children:[
                    Container(
                      child: Text("MySolarEdge Tracker"),
                      padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                    )
                  ]
              ),
            ),
            Card(
              child: Row(
                  children:[
                    Container(
                      child: Text("Enlighten App from Enphase"),
                      padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                    )
                  ]
              ),
            ),

            Card(
              child: Row(
                  children:[
                    Container(
                      child: Text("Solar.Web App"),
                      padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                    )
                  ]
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(37,15,0,0),
              child: Row(
                children: [
                  Text("Can't find yours? ", style: TextStyle(
                      fontSize: 12
                  ),),
                  Text("Send us a request", style: TextStyle(
                      decoration: TextDecoration.underline,
                      color:  Color.fromRGBO(75, 132, 241,1),
                      fontSize: 12
                  ),),
                ],
              ),
            )


          ],
        )

    );

  }
}
