import 'package:ethio_weather/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherS {
  Future<Weather?> getWeather(double? latitude, double? longitude) async {
    var client = await http.Client();
    var uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=api');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return weatherFromJson(json);
    }
  }
}
