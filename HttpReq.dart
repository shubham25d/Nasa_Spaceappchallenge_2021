import 'package:http/http.dart' as http;
import 'dart:convert';



class HttpReq{

  Future<List<RawSolarData>> fetchIrradiation() async {
    String uri = 'https://power.larc.nasa.gov/api/temporal/monthly/point?parameters=ALLSKY_SFC_SW_DWN&community=RE&longitude=38.7678&latitude=9.0079&format=JSON&start=2019&end=2020';

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((data) => RawSolarData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

}

/*
  Future<http.Response> fetchIrradiation(http.Client client) async {
    String uri = 'https://power.larc.nasa.gov/api/temporal/monthly/point?parameters=ALLSKY_SFC_SW_DWN&community=RE&longitude=38.7678&latitude=9.0079&format=JSON&start=2019&end=2020';
    return client.get(Uri.parse(uri));
  }*/





class RawSolarData{


  String type;
  String geometry;
  Properties properties;
  String header;
  String messages;
  String parameters;
  String times;


  RawSolarData({
    this.type,
    this.geometry,
    this.properties,
    this.header,
    this.messages,
    this.parameters,
    this.times
  });


  factory RawSolarData.fromJson(Map<String, dynamic> parsedJson){
    return RawSolarData(
      type: parsedJson['type'],
      geometry: parsedJson['geometry'],
      properties: Properties.fromJson(parsedJson['properties']),
      header: parsedJson['header'],
      messages: parsedJson['messages'],
      parameters: parsedJson['parameters'],
      times: parsedJson['times'],

    );
  }


}

class Properties{

  String parameter;

  Properties({
    this.parameter
  });

  factory Properties.fromJson(Map<String, dynamic> parsedJson){
    return Properties(
      parameter: parsedJson['parameter'],
    );
  }
}

/*
class Parameter{
  ALLSKY_SFC_SW_DWN allsky_sfc_sw_dwn;
  Parameter({this.allsky_sfc_sw_dwn});
}

class ALLSKY_SFC_SW_DWN{

}
*/
/*
class SolarIrradiation {
  final String year;
  final String month;
  final String day;
  final String kw;

  SolarIrradiation({this.year, this.month, this.day, this.kw});

  factory SolarIrradiation.fromJson(Map<String, dynamic> json) {
    return SolarIrradiation(
      year: json['userId'],
      month: json['id'],
      day: json['title'],
    );
  }
}*/


class SolarIrradiation {

  Map<String, String> irradiation;
  SolarIrradiation({this.irradiation});

  factory SolarIrradiation.fromJson(Map<String, dynamic> json) => SolarIrradiation(
    irradiation: Map.from(json["ALLSKY_SFC_SW_DWN"]).map((k, v) => MapEntry<String, String>(k, v)),
  );


}



