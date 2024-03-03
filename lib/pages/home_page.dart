import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/custom_widget/bottom_box.dart';
import 'package:weather_app/custom_widget/text_span.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

import '../custom_widget/middle_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final _weatherService = WeatherService('1edd88b8741d4d84b30181810242402');
  Weather? _weather;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  _fetchWeather(String city) async {
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  _fetchInitialWeather() async {
    String currentCity = await _weatherService.getCurrentCity();
    _fetchWeather(currentCity);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchInitialWeather();
  }

  @override
  Widget build(BuildContext context) {
    double querySize = MediaQuery.of(context).size.width;
    String? cityName = _weather?.location.name;
    String? countryName = _weather?.location.country;

    DateTime? date = _weather?.forecast.forecastday[0].date;
    DateTime? tDate = _weather?.forecast.forecastday[1].date;
    DateTime? datDate = _weather?.forecast.forecastday[2].date;

    final DateFormat formatter = DateFormat('E,dd LLLL'); // ex: tue,27 february
    final DateFormat weekdayFormatter = DateFormat('EEEE'); // ex:

    String today;
    String todayTimeText;
    String tomorrowTimeText; //Tomorrow Time Text
    String datTimeText; //one day after tomorrow time text

    date == null ? today = "" : today = formatter.format(date).toString();

    date == null
        ? todayTimeText = ""
        : todayTimeText = weekdayFormatter.format(date).toString();
    tDate == null
        ? tomorrowTimeText = ""
        : tomorrowTimeText = weekdayFormatter.format(tDate).toString();
    datDate == null
        ? datTimeText = ""
        : datTimeText = weekdayFormatter.format(datDate).toString();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      home: Scaffold(
        backgroundColor: Colors.indigo.shade900,
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      margin: const EdgeInsets.only(left: 30),
                      width: 3 * querySize / 4 - 30,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade700,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1.0, color: Colors.white)),
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (value) => _fetchWeather(value),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.white54),
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.white54)),
                      ),
                    ),
                    //const SizedBox(width:100),
                    SizedBox(
                      width: querySize / 4,
                      child: const Icon(
                        Icons.edit_location_alt_outlined,
                        size: 40,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.indigo.shade700,
                  width: querySize,
                  height: 200,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  today,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade400),
                                ),
                                Text(
                                  "$cityName - $countryName",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade400),
                                ),
                                ColorText(
                                    firstText:
                                        _weather?.current.tempC.toString(),
                                    firstColor: Colors.white,
                                    secondText: '°C',
                                    secondColor: Colors.orange,
                                    fontSize: 38),
                                Row(children: <Widget>[
                                  ColorText(
                                      firstText:
                                          '˅ ${_weather?.forecast.forecastday[0].day.mintempC}',
                                      firstColor: Colors.grey.shade400,
                                      secondText: ' °C',
                                      secondColor: Colors.orange,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ColorText(
                                      firstText:
                                          '˄ ${_weather?.forecast.forecastday[0].day.maxtempC}',
                                      firstColor: Colors.grey.shade400,
                                      secondText: ' °C',
                                      secondColor: Colors.orange,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ]),
                                const SizedBox(height: 10),
                                Text(
                                  _weather?.current.condition.text ?? "",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                ColorText(
                                    firstText:
                                        "Feelings like ${_weather?.current.feelslikeC.toString()}",
                                    firstColor: Colors.grey.shade400,
                                    secondText: '°C',
                                    secondColor: Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: _weather == null
                              ? const CircularProgressIndicator()
                              : FittedBox(fit: BoxFit.contain,child: Image.network(_weather!.current.condition.icon),),
                        ), // weather image
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Today',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
                 MiddleBox(weather: _weather),
                const SizedBox(height: 15,),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo.shade700),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BottomBox(
                          day: todayTimeText,
                          humidity:
                              "${_weather?.forecast.forecastday[0].day.avghumidity.toString()} %",
                          degree:
                              "${_weather?.forecast.forecastday[0].day.avgtempC.toString()}",
                          image: _weather == null
                              ? const CircularProgressIndicator()
                              : Image.network(_weather!
                                  .forecast.forecastday[0].day.condition.icon),
                        ),
                        BottomBox(
                          day: tomorrowTimeText,
                          humidity:
                              "${_weather?.forecast.forecastday[1].day.avghumidity.toString()}",
                          degree:
                              "${_weather?.forecast.forecastday[1].day.avgtempC.toString()}",
                          image: _weather == null
                              ? const CircularProgressIndicator()
                              : Image.network(_weather!
                                  .forecast.forecastday[1].day.condition.icon),
                        ),
                        BottomBox(
                          day: datTimeText,
                          humidity:
                              "${_weather?.forecast.forecastday[2].day.avghumidity.toString()}",
                          degree:
                              "${_weather?.forecast.forecastday[2].day.avgtempC.toString()}",
                          image: _weather == null
                              ? const CircularProgressIndicator()
                              : Image.network(_weather!
                                  .forecast.forecastday[2].day.condition.icon),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
