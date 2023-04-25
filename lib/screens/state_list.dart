import 'package:covid_19_app/Model/country_api_model.dart';
import 'package:covid_19_app/Services/states_services.dart';
import 'package:covid_19_app/screens/countryist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class StatesList extends StatefulWidget {
  const StatesList({super.key});

  @override
  State<StatesList> createState() => _StatesListState();
}

class _StatesListState extends State<StatesList> with TickerProviderStateMixin {
  late final AnimationController animatedCont = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();
  @override
  void dispose() {
    super.dispose();
    animatedCont.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: stateServices.fetchWorldStateRecord(),
                  builder: (context, AsyncSnapshot<CountryApiModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                              color: Colors.white,
                              controller: animatedCont,
                              size: 50));
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration: const Duration(seconds: 5),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReuseableRow(
                                        title: "Total",
                                        value:
                                            snapshot.data!.cases!.toString()),
                                    ReuseableRow(
                                        title: "Recovered",
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    ReuseableRow(
                                        title: "Deaths",
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    ReuseableRow(
                                        title: "Active",
                                        value:
                                            snapshot.data!.active.toString()),
                                    ReuseableRow(
                                        title: "Critical",
                                        value:
                                            snapshot.data!.critical.toString()),
                                    ReuseableRow(
                                        title: "Today Deaths",
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ReuseableRow(
                                        title: "Today Recovered",
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountryList()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green),
                              child: const Center(
                                  child: Text(
                                "Track Counter",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
