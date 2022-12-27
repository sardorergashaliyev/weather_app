import 'package:flutter/material.dart';
import 'package:weather/model/obhavo_model.dart';
import 'package:weather/pages/search_page.dart';
import 'package:weather/repository/get_info.dart';
import 'package:weather/widget/hour_item.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({Key? key, this.name = 'Tashkent'}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WeatherModel> getWeatherInfo() async {
    final data =
        await GetInformationRepository.getInformationWeather(name: widget.name);
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
        int.parse(snapshot?.current?.lastUpdated?.substring(10, 13) ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: getWeatherInfo(),
          builder:
              (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 50),
                        Column(
                          children: [
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
                            const SizedBox(height: 20),
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
                                    "L:${snapshot.data?.forecast?.forecastday?.last.day?.mintemp_c ?? 0}°",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 0),
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x702E335A),
                                    Color(0x701C1B33),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                ),
                              ),
                              child: SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 16),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data?.forecast
                                            ?.forecastday?.first.hour?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return HourItem(
                                        isActive:
                                            checkHour(index, snapshot.data),
                                        title: snapshot
                                            .data
                                            ?.forecast
                                            ?.forecastday
                                            ?.first
                                            .hour?[index]
                                            .time,
                                        temp: snapshot
                                            .data
                                            ?.forecast
                                            ?.forecastday
                                            ?.first
                                            .hour?[index]
                                            .tempC,
                                        image: snapshot
                                            .data
                                            ?.forecast
                                            ?.forecastday
                                            ?.first
                                            .hour?[index]
                                            .condition
                                            ?.icon,
                                      );
                                    }),
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('asset/icon/restangle.png'),
            ),
            Positioned(
              bottom: 0,
              left: 66,
              right: 66,
              child: Image.asset('asset/icon/oval.png'),
            ),
            Positioned(
              bottom: 0,
              left: 142,
              right: 142,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (a) => const SearchPage(),
                    ),
                  );
                },
                child: Image.asset('asset/icon/Button.png'),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              child: SizedBox(
                width: 32,
                height: 32,
                child: Image.asset('asset/icon/location.png'),
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: SizedBox(
                width: 32,
                height: 32,
                child: Image.asset('asset/icon/menu.png'),
              ),
            )
          ],
        ));
  }
}
