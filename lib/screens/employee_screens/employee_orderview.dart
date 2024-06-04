import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeOrderView extends StatefulWidget {
  bool isGerman = false;
  double textSize = 15;

  EmployeeOrderView({Key? key, required this.textSize, required this.isGerman})
      : super(key: key);
  State<EmployeeOrderView> createState() =>
      _EmployeeOrderViewState(textSize: textSize, isGerman: isGerman);
}

class _EmployeeOrderViewState extends State<EmployeeOrderView> {
  bool isGerman = false;
  double textSize = 15;

  _EmployeeOrderViewState({required this.textSize, required this.isGerman});

  void initState() {
    super.initState();
    getServices();
  }

  List<String> parts = [];

  Future<void> getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    parts = await prefs.getStringList("services_cust_1")!;
    setState(() {});
    convertToGerman();
  }

  List<String> servicesInEnglish = [
    "Maintain chain 10€",
    "Tension chain 10€",
    "Replace chain 10€",
    "Adjust brakes (front/rear) 11€",
    "Brake pads 11€",
    "Replace brake cable 12€",
    "Adjust spokes (eights!) 13€",
    "Check tyre pressure 14€",
    "Replace tyre (front/rear) 15€",
    "Adjust gears 15€",
    "Replace gear cable 15€",
    "Adjust lights 16€",
    "Replace lights 16€",
    "Install pannier rack 17€",
    "Replace mudguard 18€",
    "Install air pump 19€",
    "Replace kickstand 20€",
    "Replace grips 21€",
    "Replace lock 22€"
  ];

  List<String> servicesInGerman = [
    "Kette behalten 10€",
    "Spannkette 10€",
    "Kette ersetzen 10€",
    "Bremsen einstellen (vorne/hinten) 11€",
    "Bremsbeläge 11€",
    "Bremszug ersetzen 12€",
    "Speichen anpassen (achter!) 13€",
    "Reifendruck prüfen 14€",
    "Reifen ersetzen (vorne/hinten) 15€",
    "Gänge anpassen 15€",
    "Schaltzug ersetzen 15€",
    "Lichter anpassen 16€",
    "Lichtertausch 16€",
    "Gepäckträger einbauen 17€",
    "Kotflügel ersetzen 18€",
    "Luftpumpe einbauen 19€",
    "Ständer ersetzen 20€",
    "Griffe ersetzen 21€",
    "Schloss ersetzen 22€"
  ];

  List<String> partsInGerman = [];

  void convertToGerman() {
    for (int i = 0; i < parts.length; i++) {
      for (int j = 0; j < servicesInEnglish.length; j++) {
        if (parts[i] == servicesInEnglish[j]) {
          partsInGerman.add(servicesInGerman[j]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Allgemeine Bestellansicht',
                  style: TextStyle(fontSize: textSize + 5))
              : Text('General Order View',
                  style: TextStyle(fontSize: textSize + 5))),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text("Employee 1", style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      color: Colors.amber,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: parts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: isGerman
                                  ? Text("${partsInGerman[index]}",
                                      style: TextStyle(fontSize: textSize))
                                  : Text("${parts[index]}",
                                      style: TextStyle(fontSize: textSize)),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
