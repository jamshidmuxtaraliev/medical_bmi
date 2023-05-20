import 'package:flutter/material.dart';
import 'package:medical_bmi/models/covid_api_model.dart';
import '../../api/covidAPI.dart';
import '../../models/homeCountryDataModel.dart';
import '../../utility/bottomAnimation.dart';
import '../../widget/customLoader.dart';
import '../../widget/homeTile.dart';

class Pakistan extends StatefulWidget {
  @override
  _PakistanState createState() => _PakistanState();
}

class _PakistanState extends State<Pakistan> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
        child: Container(
          color: Colors.white,
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flag(),
              FutureBuilder<CovidApiModel>(
                // future: CovidAPI().getHomeCase(),
                future: CovidAPI().getCountry(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: height * 0.4155,
                      child: Center(
                        child: VirusLoader(),
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Oxirgi yangilanish: ${snapshot.data?.response[0].day.substring(0, 10)}",
                              style: TextStyle(color: Colors.black, fontSize: height * 0.02, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Icon(Icons.refresh))
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            WidgetAnimator(
                              HomeTile(
                                caseCount: snapshot.data?.response[0].cases.total.toInt() ?? 0,
                                infoHeader: 'Cases',
                                tileColor: Colors.blueAccent,
                              ),
                            ),
                            WidgetAnimator(
                              HomeTile(
                                caseCount: snapshot.data?.response[0].cases.recovered?.toInt() ?? 0,
                                infoHeader: 'Recoveries',
                                tileColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            WidgetAnimator(
                              HomeTile(
                                caseCount: snapshot.data?.response[0].deaths.total.toInt() ?? 0,
                                infoHeader: 'Deaths',
                                tileColor: Colors.redAccent,
                              ),
                            ),
                            WidgetAnimator(
                              HomeTile(
                                caseCount: snapshot.data?.response[0].tests.total.toInt() ?? 0,
                                infoHeader: 'Tests',
                                tileColor: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "Kasallik alomatlarini sezsangiz Sanitariya epidemiya xodimlari bilan bog'laning",
                            style: TextStyle(
                                fontFamily: 'semibold',
                                color: Colors.black54,
                                fontSize: 22,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}

class Flag extends StatelessWidget {
  String emoji() {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    String country = "UZ";

    int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

    String emoji = String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
    return emoji;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "${emoji()}",
          style: TextStyle(fontSize: MediaQuery
              .of(context)
              .size
              .height * 0.1),
        ),
        const Text(
            "O'ZBEKISTON",
            style: TextStyle(
                fontFamily: 'semibold',
                color: Colors.black,
                fontSize: 34,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold)
        ),
      ],
    );
  }
}
