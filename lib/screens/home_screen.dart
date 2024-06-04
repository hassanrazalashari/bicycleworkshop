import 'package:bicycle_workshop/screens/contact_info.dart';
import 'package:flutter/material.dart';
import 'package:bicycle_workshop/screens/owner_screens/owner_screen.dart';
import 'package:bicycle_workshop/screens/employee_screens/employee_screen.dart';
import 'package:bicycle_workshop/screens/customer_screens/customer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double btnWidth = 150, btnHeight = 70;
  double textSize = 15;
  bool isGerman = false;

  void initState() {
    super.initState();
    saveUserData();
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (await prefs.getBool("dataInserted") ?? false) {
    } else {
      await prefs.setBool("dataInserted", true);
      await prefs.setInt("total_orders", 0);
      await prefs.setStringList("orders", []);
      await prefs.setStringList("customers", []);
      await prefs.setInt("revenue", 0);
      await prefs.setInt("expenses", 0);
      await prefs.setStringList("order_details",
          ["", "", "", "not started", "false", "false", "", "0"]);
      await prefs.setStringList("services_cust_1", []);
      await prefs.setStringList("stock",
          ["10", "10", "10", "80", "10", "15", "18", "20", "10", "10", "10"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isGerman
            ? Text('Fahrradwerkstatt', style: TextStyle(fontSize: textSize + 5))
            : Text('Bicycle Workshop',
                style: TextStyle(fontSize: textSize + 5)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OwnerScreen(
                                    textSize: textSize,
                                    isGerman: isGerman,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isGerman
                        ? Text('Eigentümer',
                            style: TextStyle(fontSize: textSize))
                        : Text('Owner', style: TextStyle(fontSize: textSize)),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmployeeScreen(
                                  textSize: textSize, isGerman: isGerman)));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isGerman
                        ? Text('Mitarbeiter',
                            style: TextStyle(fontSize: textSize))
                        : Text('Employee',
                            style: TextStyle(fontSize: textSize)),
                  ),
                ),
              ],
            ),
            const SizedBox(
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerScreen(
                                  textSize: textSize, isGerman: isGerman)));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isGerman
                        ? Text('Kunde', style: TextStyle(fontSize: textSize))
                        : Text('Customer',
                            style: TextStyle(fontSize: textSize)),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ContactInfo(
                                textSize: textSize,
                                isGerman: isGerman,
                              ))));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isGerman
                        ? Text('Kontaktinformationen speichern',
                            style: TextStyle(fontSize: textSize))
                        : Text('Store Contact Info',
                            style: TextStyle(fontSize: textSize)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: btnWidth,
              height: btnHeight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isGerman = !isGerman;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: isGerman
                    ? Text('Sprache En/De',
                        style: TextStyle(fontSize: textSize))
                    : Text('Language En/De',
                        style: TextStyle(fontSize: textSize)),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (textSize < 20) {
                          textSize++;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isGerman
                        ? Text('Textgröße +',
                            style: TextStyle(fontSize: textSize))
                        : Text('Text size +',
                            style: TextStyle(fontSize: textSize)),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (textSize > 15) {
                          textSize--;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: isGerman
                        ? Text('Textgröße -',
                            style: TextStyle(fontSize: textSize))
                        : Text('Text Size -',
                            style: TextStyle(fontSize: textSize)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
