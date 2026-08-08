import 'package:flutter/material.dart';

class WindData extends StatefulWidget {
  const WindData({key}) : super(key: key);

  @override
  _WindDataState createState() => _WindDataState();
}

class _WindDataState extends State<WindData> {

  static const TextStyle optionStyle = TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [

          Stack(
            children: [
              Image.asset("assets/windmill.jpeg",
                height: 1000.0,
                width: 300.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(190, 440, 0, 0),
                child: Text(
                  "Coming soon",
                  style: optionStyle,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
