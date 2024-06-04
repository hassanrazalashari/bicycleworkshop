import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerInvoiceView extends StatefulWidget {
  double textSize;

  OwnerInvoiceView({Key? key, required this.textSize}) : super(key: key);
  State<OwnerInvoiceView> createState() =>
      _OwnerInvoiceViewState(textSize: textSize);
}

class _OwnerInvoiceViewState extends State<OwnerInvoiceView> {
  TextEditingController commentController = TextEditingController();

  double textSize = 15;

  _OwnerInvoiceViewState({Key? key, required this.textSize});

  List<String> spare_parts = [
    "Chain",
    "Brake pads",
    "Brake cable",
    "Spokes",
    "Tyre",
    "Gear cable",
    "Lights",
    "Mudguard",
    "Kickstand",
    "grips",
    "Lock"
  ];

  void initState() {
    super.initState();
    getStock();
    setState(() {});
  }

  int revenue = 0;
  int expenses = 0;

  List<String> stock = [];

  Future<void> getStock() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stock = prefs.getStringList("stock")!;
    revenue = prefs.getInt("revenue")!;
    expenses = prefs.getInt("expenses")!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Invoice View', style: TextStyle(fontSize: textSize + 5))),
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
                    Text("Revenue: " + revenue.toString() + "€",
                        style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Expenses: " + expenses.toString() + "€",
                        style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 100,
                    ),
                    Text("Stock:", style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      color: Colors.amber,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: stock.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("${spare_parts[index]}",
                                  style: TextStyle(fontSize: textSize)),
                              trailing: Text("${stock[index]}",
                                  style: TextStyle(fontSize: textSize)),
                            );
                          },
                        ),
                      ),
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
