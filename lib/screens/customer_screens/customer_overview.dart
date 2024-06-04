import 'package:bicycle_workshop/screens/customer_screens/create_order.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerOverview extends StatefulWidget {
  bool isGerman = false;
  double textSize = 15;
  CustomerOverview({Key? key, required this.textSize, required this.isGerman})
      : super(key: key);
  State<CustomerOverview> createState() =>
      _CustomerOverviewState(textSize: textSize, isGerman: isGerman);
}

class _CustomerOverviewState extends State<CustomerOverview> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  double btnWidth = 150, btnHeight = 70;
  double textSize = 15;
  bool isGerman = false;

  _CustomerOverviewState(
      {Key? key, required this.textSize, required this.isGerman});

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("order_details", [
      nameController.text,
      phoneController.text,
      "",
      "not started",
      "false",
      "false",
      "",
      "0"
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !isGerman
              ? Text('OverView', style: TextStyle(fontSize: textSize + 5))
              : Text('Überblick', style: TextStyle(fontSize: textSize + 5))),
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
                          height: 200,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText:
                                  isGerman ? "Name eingeben" : "Enter Name",
                              labelText: "Name",
                              labelStyle: TextStyle(
                                fontSize: textSize + 5,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          decoration: InputDecoration(
                              hintText: isGerman
                                  ? "Telefonnummer eingeben"
                                  : "Enter Phone Number",
                              labelText:
                                  isGerman ? "Telefonnummer" : "Phone Number",
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: 300,
                          height: btnHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() async {
                                await saveUserData();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CreateOrder(
                                        textSize: textSize,
                                        isGerman: isGerman)));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: isGerman
                                ? Text('Bestellung anlegen',
                                    style: TextStyle(fontSize: textSize))
                                : Text('Create Order',
                                    style: TextStyle(fontSize: textSize)),
                          ),
                        ),
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
