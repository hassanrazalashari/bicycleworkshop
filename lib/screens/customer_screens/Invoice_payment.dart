import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoicePayment extends StatefulWidget {
  double textSize = 15;
  List<String> parts = [];
  List<String> partsInGerman = [];
  String imgPath = "";
  bool isGerman = false;
  InvoicePayment(
      {Key? key,
      required this.textSize,
      required this.parts,
      required this.imgPath,
      required this.partsInGerman,
      required this.isGerman})
      : super(key: key);
  State<InvoicePayment> createState() => _InvoicePaymentState(
      textSize: textSize,
      parts: parts,
      imgPath: imgPath,
      partsInGerman: partsInGerman,
      isGerman: isGerman);
}

class _InvoicePaymentState extends State<InvoicePayment> {
  TextEditingController commentController = TextEditingController();

  double btnWidth = 150, btnHeight = 70;
  double textSize = 15;
  List<String> parts = [];
  String imgPath = "";
  String isCompleted = "";
  List<String> partsInGerman = [];
  bool isGerman = false;
  _InvoicePaymentState(
      {Key? key,
      required this.textSize,
      required this.parts,
      required this.imgPath,
      required this.partsInGerman,
      required this.isGerman});

  List<String> stock = [];

  List<String> services = [
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

  List<int> amount = [
    10,
    10,
    10,
    11,
    11,
    12,
    13,
    14,
    15,
    15,
    15,
    16,
    16,
    17,
    18,
    19,
    20,
    21,
    22
  ];

  int total = 0;
  int revenue = 0;
  int expense = 0;

  void initState() {
    super.initState();
    getServices();
    setState(() {});
  }

  Future<void> getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> order_details = await prefs.getStringList("order_details")!;
    isCompleted = order_details[3];
    stock = await prefs.getStringList("stock")!;

    for (int i = 0; i < parts.length; i++) {
      total += amount[services.indexOf(parts[i])];
    }

    setState(() {});
  }

  Future<void> updateStock() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < parts.length; i++) {
      if (parts[i] == "Replace chain 10€") {
        stock[0] = (int.parse(stock[0]) - 1).toString();
        expense += 10;
      }
      if (parts[i] == "Brake pads 11€") {
        stock[1] = (int.parse(stock[1]) - 1).toString();
        expense += 11;
      }
      if (parts[i] == "Replace brake cable 12€") {
        stock[2] = (int.parse(stock[2]) - 1).toString();
        expense += 12;
      }
      if (parts[i] == "Adjust spokes (eights!) 13€") {
        stock[3] = (int.parse(stock[3]) - 8).toString();
        expense += 13;
      }
      if (parts[i] == "Replace tyre (front/rear) 15€") {
        stock[4] = (int.parse(stock[4]) - 1).toString();
        expense += 15;
      }
      if (parts[i] == "Replace gear cable 15€") {
        stock[5] = (int.parse(stock[5]) - 1).toString();
        expense += 15;
      }
      if (parts[i] == "Replace lights 16€") {
        stock[6] = (int.parse(stock[6]) - 1).toString();
        expense += 16;
      }
      if (parts[i] == "Replace mudguard 18€") {
        stock[7] = (int.parse(stock[7]) - 1).toString();
        expense += 18;
      }
      if (parts[i] == "Replace kickstand 20€") {
        stock[8] = (int.parse(stock[8]) - 1).toString();
        expense += 20;
      }
      if (parts[i] == "Replace grips 21€") {
        stock[9] = (int.parse(stock[9]) - 1).toString();
        expense += 21;
      }
      if (parts[i] == "Replace lock 22€") {
        stock[10] = (int.parse(stock[10]) - 1).toString();
        expense += 22;
      }
    }

    int total_expenses = prefs.getInt("expenses")!;
    total_expenses += expense;
    await prefs.setInt("expenses", total_expenses);

    int total_revenue = prefs.getInt("revenue")!;
    revenue = total - expense;
    total_revenue += revenue;
    await prefs.setInt("revenue", total_revenue);

    List<String> orders = prefs.getStringList("orders") ?? [];

    orders.add(parts.toString());

    await prefs.setStringList("orders", orders);

    List<String> customers = prefs.getStringList("customers") ?? [];
    customers.add(prefs.getStringList("order_details")![0] +
        "          " +
        prefs.getStringList("order_details")![1]);
    await prefs.setStringList("customers", customers);

    await prefs.setStringList("stock", stock);

    await prefs.setStringList("order_details",
        ["", "", "", "not started", "false", "false", "", "0"]);
    await prefs.setStringList("services_cust_1", []);

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Rechnungszahlung',
                  style: TextStyle(fontSize: textSize + 5))
              : Text('Invoice Payment',
                  style: TextStyle(fontSize: textSize + 5))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                              ? Text("${partsInGerman[index++]}",
                                  style: TextStyle(fontSize: textSize))
                              : Text("${parts[index++]}",
                                  style: TextStyle(fontSize: textSize)),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                isGerman
                    ? Text("Gesamt = " + total.toString())
                    : Text("Total = " + total.toString()),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: isGerman
                                ? Text('Zahlung erledigt')
                                : Text('Payment Done'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  updateStock();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isGerman
                        ? Text('Zahlen', style: TextStyle(fontSize: textSize))
                        : Text('Pay', style: TextStyle(fontSize: textSize)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
