import 'package:flutter/material.dart';
import 'package:weather_app/custom_widget/text_span.dart';

class BottomBox extends StatelessWidget {
  BottomBox(
      {super.key,
      required this.day,
      required this.humidity,
      required this.degree,
      required this.image});

  String day;
  String humidity;
  String degree;
  Widget image = const CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    double querySize = MediaQuery.of(context).size.width - 30;

    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 5),
      child: Row(
        children: <Widget>[
          Container(
            width: ((2 * querySize) / 6) - 5,
            child: Text(
              day,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
          ),
          Container(
            width: (querySize / 6) - 5,
            child: const Icon(
              Icons.water_drop,
              color: Colors.blue,
            ),
          ),
          Container(
            width: (querySize / 6) - 5,
            child: Text(
              humidity,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 11),
            ),
          ),
          Container(
            width: (querySize / 6) - 5,
            child: image,
          ),
          Container(
            width: (querySize / 6) - 5,
            child: ColorText(
              firstText: degree,
              firstColor: Colors.grey.shade500,
              secondText: ' °C',
              secondColor: Colors.orange,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
