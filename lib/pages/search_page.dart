import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:weather/pages/home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController countries = TextEditingController();

  @override
  void dispose() {
    countries.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/originals/2a/7d/06/2a7d0668824a32d7dd4237f824e3bed6.jpg'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: countries,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 108, 156),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 108, 156),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => HomePage(
                            name: countries.text,
                          )),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Color.fromARGB(255, 166, 166, 166))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(colors: [
                        Color(0xff48319D),
                        Color(0xff1F1D47),
                        Color(0xff083072),
                      ])),
                  child: const Center(
                      child: Text(
                    'Find',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
