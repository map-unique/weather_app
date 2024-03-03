import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/custom_widget/column_widget.dart';

import '../models/weather_model.dart';

class MiddleBox extends StatelessWidget {
  MiddleBox({super.key, this.weather});

  Weather? weather;

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return const Text(" Search your city!", style: TextStyle(color: Colors.white),);
    }

    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15),
      margin: const EdgeInsets.only(right: 15, left: 15),
      height: 120,
      color: Colors.indigo.shade900,
      child: ListView.builder(
        itemBuilder: (context, index) {
          var L = weather!.forecast.forecastday[0].hour[index];
          
          return CustomColumnWidget(
            time: L.time.substring(11,16),
            image: L.condition.icon,
            degree: L.tempC.toString(),
            humidity: L.humidity.toString(),
          );
        },
        itemCount:  weather!.forecast.forecastday[0].hour.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
