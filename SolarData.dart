import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:illuminate/HttpReq.dart';
import 'package:illuminate/LocationScreen.dart';
import 'package:date_time_picker/date_time_picker.dart';


class SolarData extends StatefulWidget {
  const SolarData({key}) : super(key: key);

  @override
  _SolarDataState createState() => _SolarDataState();
}

class _SolarDataState extends State<SolarData> {

  var parameter = new Parameters('Yearly', DateFormat('MM/dd/yyyy, hh:mm a').parse('10/14/2018, 10:00 PM'), DateFormat('MM/dd/yyyy, hh:mm a').parse('9/20/2019, 10:00 PM'));

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
            icon: Icon(Icons.filter_list_rounded),
            label: Text("Data", style: TextStyle(color: Colors.black54),),
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context) => BuildFilterPopupDialog()).then((val) {
                setState(() {
                  var returnedPar = val as Parameters;
                  parameter.TimeFrame = returnedPar.TimeFrame;
                  parameter.StartDate = returnedPar.StartDate;
                  parameter.EndDate = returnedPar.EndDate;
                  /*final log = Logger();
                  log.d(parameter.TimeFrame);*/
                });
              });
            },
          )),
      YearlyData(),
      Row(children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            children: [

              Text("Mauritius St, Lafto K, Ethiopia", ),
              Text("Latitude: 9.0079  Longitude: 38.7678 ", style: TextStyle(color: Colors.black38)),

            ],
          ),
          /*child: ElevatedButton(
            //onPressed: addBar,
            onPressed: getData,
            child: Text('Add bar'),
          ),*/
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.red,
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationScreen()),
              );
            },
          ),
        )
      ])
    ]);
  }




  Future<void> getData() async {
    List<RawSolarData> rawSolarData;
    rawSolarData= await HttpReq().fetchIrradiation();
  }
}

class BuildFilterPopupDialog extends StatefulWidget {
  const BuildFilterPopupDialog({key}) : super(key: key);

  @override
  _BuildFilterPopupDialogState createState() => _BuildFilterPopupDialogState();
}

class _BuildFilterPopupDialogState extends State<BuildFilterPopupDialog> {
  String timeFrame = 'Hourly';


  static DateTime startDate = DateFormat('MM/dd/yyyy, hh:mm a').parse('10/14/2018, 10:00 PM');// DateTime.now();
  static DateTime endDate = DateFormat('MM/dd/yyyy, hh:mm a').parse('9/20/2019, 10:00 PM');// DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selection Parameters', style: TextStyle(color: Colors.black54)),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                flex:1,
                child: Column(
                  children: [
                    Text("Time Frame", style: TextStyle(color: Color.fromRGBO(75, 132, 241,1), fontSize: 17),),
                    DropdownButton<String>(
                      items: <String>['Hourly', 'Daily', 'Monthly', 'Yearly', 'Forecast'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: timeFrame,
                      onChanged: (String newValue) {
                        setState(() {
                          timeFrame = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Expanded(child: Text(''), flex:1)
            ],
          ),

          Container(
            margin: EdgeInsets.only(top:17.0),
            child: Row(
              children: [
                Expanded(
                  flex:1,
                  child: Column(
                    children: [
                      GestureDetector(
                          child: Text("Start Date", style: TextStyle(color: Color.fromRGBO(75, 132, 241,1),fontSize: 17),),
                          onTap: (){selectStartDate(context);}


                      ),
                      GestureDetector(
                          child: Text("${startDate.day}/${startDate.month}/${startDate.year}"),
                          onTap: (){selectStartDate(context);}


                      ),

                      /*DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        selectableDayPredicate: (date) {
                          // Disable weekend days to select from the calendar
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }

                          return true;
                        },
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      )*/




                    ],
                  ),
                ),
                Expanded(
                  flex:1,
                  child: Column(
                    children: [
                      GestureDetector(

                          child: Text("End Date", style: TextStyle(color: Color.fromRGBO(75, 132, 241,1),fontSize: 17),),
                          onTap: (){selectEndDate(context);}

                      ),

                      GestureDetector(

                          child: Text("${endDate.day}/${endDate.month}/${endDate.year}"),
                          onTap: (){selectEndDate(context);}

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top:20),
            child: RaisedButton(
              color: Color.fromRGBO(75, 132, 241,1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              onPressed: (){
                Navigator.pop(context, Parameters( timeFrame, startDate, endDate));
              },
              child: Text('Save', style:TextStyle(color:Colors.white),),

            ),
          ),
        ],
      ),


      /*
     DropdownButton<String>(

            items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
          )
     */

      /*
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],*/
    );
  }

  void selectStartDate(BuildContext context) async {

    // Navigator.of(context).pop();



    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1983),
      lastDate: DateTime(2021),
    );
    if (selected != null && selected != startDate)
      setState(() {
        startDate = selected;
      });
  }

  void selectEndDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(1983),
      lastDate: DateTime(2020),
    );
    if (selected != null && selected != endDate)
      setState(() {
        endDate = selected;
      });
  }

}

class Parameters{
  var TimeFrame;
  var StartDate;
  var EndDate;

  Parameters(this.TimeFrame, this.StartDate, this.EndDate);
}


class SolarIrradiation {
  final String year;
  final double power;

  SolarIrradiation(this.year, this.power);
}

class YearlyData extends StatefulWidget {
  const YearlyData({key}) : super(key: key);

  @override
  _YearlyDataState createState() => _YearlyDataState();
}

class _YearlyDataState extends State<YearlyData> {
  static List<charts.Series> seriesList;

  final random = Random();

  static final solarPanelData = [
    SolarIrradiation('2015', 0.91),
    SolarIrradiation('2016', 0.87),
    SolarIrradiation('2017', 0.89),
    SolarIrradiation('2018', 0.88),
    SolarIrradiation('2019', 0.87),
  ];

  static final nasaSolarData = [
    SolarIrradiation('2015', 6.13),
    SolarIrradiation('2016',5.83),
    SolarIrradiation('2017', 5.96),
    SolarIrradiation('2018', 5.9),
    SolarIrradiation('2019', 5.85),
  ];





  static List<charts.Series<SolarIrradiation, String>> _createRandomData() {
    return [
      charts.Series<SolarIrradiation, String>(
        id: 'Solar Panels',
        domainFn: (SolarIrradiation solarData, _) => solarData.year,
        measureFn: (SolarIrradiation sales, _) => sales.power,
        data: solarPanelData,
      ),

      charts.Series<SolarIrradiation, String>(
        id: 'Solar Irradiation',
        domainFn: (SolarIrradiation sales, _) => sales.year,
        measureFn: (SolarIrradiation sales, _) => sales.power,
        data: nasaSolarData,
        /*fillColorFn: (SolarIrradiation sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },*/
      ),


      /*
      charts.Series<SolarIrradiation, String>(
        id: 'Sales',
        domainFn: (SolarIrradiation sales, _) => sales.year,
        measureFn: (SolarIrradiation sales, _) => sales.power,
        data: mobileSalesData,
        fillColorFn: (SolarIrradiation sales, _) {
          return charts.MaterialPalette.teal.shadeDefault;
        },
      )*/
    ];
  }

  barChart() {
    return Stack(
      children: [
        AnimatedPositioned(
          top: 28,
          child : Text("kw/m²"),
          duration : Duration(seconds:4),
        ),

        charts.BarChart(
          seriesList,
          animate: true,
          barGroupingType: charts.BarGroupingType.grouped,
          behaviors: [charts.SeriesLegend()],
          animationDuration: Duration(seconds: 1),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.fromLTRB(2.0, 0, 2.0, 2.0),
        child: Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 500.0,
              //height: MediaQuery.of(context).copyWith().size.height / 3,
              height: 550.0,
              padding: EdgeInsets.all(20.0),
              child: barChart(),
              /*child:  charts.BarChart(
                          seriesList,
                          animate: true,
                          barGroupingType: charts.BarGroupingType.grouped,
                          behaviors: [new charts.SeriesLegend()],
                          animationDuration: Duration(seconds: 1),
                        )*/
            ),
          ),
        ),
      ),
    ]);
  }

  addBar() {
    setState(() {
      /*
      mobileSalesData.clear();
      mobileSalesData.add(SolarIrradiation('2022', 90));
      seriesList = _createRandomData();
      */

    });
  }
}
