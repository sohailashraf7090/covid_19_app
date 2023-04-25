import 'package:covid_19_app/screens/state_list.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        ReuseableRow(
                            title: "Total",
                            value: widget.totalCases.toString()),
                        ReuseableRow(
                            title: "Total Deaths",
                            value: widget.totalDeaths.toString()),
                        ReuseableRow(
                            title: "Total Recovered",
                            value: widget.todayRecovered.toString()),
                        ReuseableRow(
                            title: "Active", value: widget.active.toString()),
                        ReuseableRow(
                            title: "critical",
                            value: widget.critical.toString()),
                        ReuseableRow(
                            title: "Today Recovered",
                            value: widget.todayRecovered.toString()),
                        ReuseableRow(
                            title: "Test", value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ]),
    );
  }
}
