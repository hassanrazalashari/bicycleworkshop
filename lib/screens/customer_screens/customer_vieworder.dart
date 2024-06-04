import 'dart:io';

import 'package:bicycle_workshop/screens/customer_screens/Invoice_payment.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewOrder extends StatefulWidget {
  double textSize = 15;
  bool isGerman = false;
  ViewOrder({Key? key, required this.textSize, required this.isGerman})
      : super(key: key);
  State<ViewOrder> createState() =>
      _ViewOrderState(textSize: textSize, isGerman: isGerman);
}

class _ViewOrderState extends State<ViewOrder> {
  TextEditingController commentController = TextEditingController();

  double btnWidth = 150, btnHeight = 70;
  double textSize = 15;
  bool isGerman = false;

  _ViewOrderState({Key? key, required this.textSize, required this.isGerman});

  List<String> parts = [];

  String imgPath = "";
  String isCompleted = "";

  void initState() {
    super.initState();
    getServices();
  }

  List<String> partsInGerman = [];

  Future<void> getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    parts = await prefs.getStringList("services_cust_1")!;
    List<String> order_details = prefs.getStringList("order_details")!;
    imgPath = order_details[2];
    isCompleted = order_details[3];

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

    // void convertToGerman() {
    for (int i = 0; i < parts.length; i++) {
      for (int j = 0; j < servicesInEnglish.length; j++) {
        if (parts[i] == servicesInEnglish[j]) {
          partsInGerman.add(servicesInGerman[j]);
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Bestellung anzeigen',
                  style: TextStyle(fontSize: textSize + 5))
              : Text('View Order', style: TextStyle(fontSize: textSize + 5))),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          width: 180,
                          height: 180,
                          color: Colors.amber,
                          child: imgPath == ""
                              ? Text("Image of bike")
                              : Image.file(
                                  File(imgPath),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 300,
                          height: 200,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: btnWidth,
                              height: btnHeight,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (isCompleted == "finished")
                                      ? Colors.green
                                      : (isCompleted == "started")
                                          ? Colors.yellow
                                          : Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: Text(
                                  'Status',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: btnWidth,
                              height: btnHeight,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (isCompleted == "finished") {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InvoicePayment(
                                                  textSize: textSize,
                                                  parts: parts,
                                                  imgPath: imgPath,
                                                  partsInGerman: partsInGerman,
                                                  isGerman: isGerman,
                                                )));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: isGerman
                                    ? Text('Zahlen',
                                        style: TextStyle(fontSize: textSize))
                                    : Text('Pay',
                                        style: TextStyle(fontSize: textSize)),
                              ),
                            ),
                          ],
                        )
                      ],
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
