import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerOverView extends StatefulWidget {
  double textSize = 15;

  OwnerOverView({Key? key, required this.textSize}) : super(key: key);
  State<OwnerOverView> createState() => _OwnerOverViewState(textSize: textSize);
}

class _OwnerOverViewState extends State<OwnerOverView> {
  TextEditingController commentController = TextEditingController();

  double btnWidth = 150, btnHeight = 70;
  double textSize = 15;

  _OwnerOverViewState({Key? key, required this.textSize});

  void initState() {
    super.initState();
    getServices();
  }

  List<String> parts = [];
  List<String> customers = [];
  int profit = 0;

  Future<void> getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    parts = prefs.getStringList("orders")!;
    customers = prefs.getStringList("customers")!;

    profit = prefs.getInt("revenue")!;

    print("Parts:" + {parts.length}.toString());
    print("cus:" + {customers.length}.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Owner1', style: TextStyle(fontSize: textSize + 5))),
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
                    Text("Profit: " + profit.toString() + "€",
                        style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Orders:", style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 150,
                      color: Colors.amber,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: parts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("${parts[index]}",
                                  style: TextStyle(fontSize: textSize)),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Employees: Employee1",
                        style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Customers:", style: TextStyle(fontSize: textSize)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 100,
                      color: Colors.amber,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: customers.length,
                          itemBuilder: (context, index) {
                            return Text("${customers[index]}");
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
