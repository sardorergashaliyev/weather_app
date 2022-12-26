import 'package:flutter/material.dart';
import 'package:weather/model/obhavo_model.dart';
import 'package:weather/repository/get_info.dart';
import 'package:weather/widget/hour_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WeatherModel> getWeatherInfo() async {
    final data = await GetInformationRepository.getInformationWeather(
        name: "Uzbekistan");
    return WeatherModel.fromJson(data);
  }

  bool checkHour(int index, WeatherModel? snapshot) {
    return int.tryParse((snapshot
                    ?.forecast?.forecastday?.first.hour?[index].time ??
                "")
            .substring(
                (snapshot?.forecast?.forecastday?.first.hour?[index].time ?? "")
                        .indexOf(":") -
                    2,
                (snapshot?.forecast?.forecastday?.first.hour?[index].time ?? "")
                    .indexOf(":"))) ==
        TimeOfDay.now().hour;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getWeatherInfo(),
        builder: (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
          return snapshot.hasData
              ? Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://i.pinimg.com/originals/2a/7d/06/2a7d0668824a32d7dd4237f824e3bed6.jpg'),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Center(
                        child: Text(
                          snapshot.data?.location?.name ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          ('${snapshot.data?.current?.tempC ?? 0.toString()}°'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              snapshot.data?.forecast?.forecastday?.first.day
                                      ?.condition?.text ??
                                  '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "H:${snapshot.data?.forecast?.forecastday?.first.day?.maxtempC ?? 0}°",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Center(
                                child: Text(
                                  "L:${snapshot.data?.forecast?.forecastday?.last.day?.maxtempC ?? 0}°",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data?.forecast?.forecastday
                                        ?.first.hour?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return HourItem(
                                    isActive: checkHour(index, snapshot.data),
                                    title: snapshot.data?.forecast?.forecastday
                                        ?.first.hour?[index].time,
                                    temp: snapshot.data?.forecast?.forecastday
                                        ?.first.hour?[index].tempC,
                                    image: snapshot.data?.forecast?.forecastday
                                        ?.first.hour?[index].condition?.icon,
                                  );
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
