import 'package:flutter/material.dart';
import 'package:weather_app/custom_widget/text_span.dart';

class CustomColumnWidget extends StatelessWidget {
  CustomColumnWidget(
      {super.key,
      required this.time,
      required this.image,
      required this.degree,
      required this.humidity});

  String time;
  String image;
  String degree;
  String humidity;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      //   // border: Border.all(color: Colors.deepOrangeAccent)
      // ),
      // width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            time,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
            child: Image.network(
              image,
              height: 60,
              width: 60,
            ),
          ),
          ColorText(
              firstText: degree,
              firstColor: Colors.grey.shade500,
              secondText: '°C',
              secondColor: Colors.orange,
              fontSize: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.water_drop,
                color: Colors.blue,
                size: 12,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                "$humidity %",
                style: const TextStyle(fontSize: 14, color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
