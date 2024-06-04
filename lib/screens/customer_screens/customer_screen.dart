import 'package:bicycle_workshop/screens/customer_screens/customer_overview.dart';
import 'package:bicycle_workshop/screens/customer_screens/customer_vieworder.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  double textSize = 15;
  bool isGerman = false;
  CustomerScreen({Key? key, required this.textSize, required this.isGerman})
      : super(key: key);
  State<CustomerScreen> createState() =>
      _CustomerScreenState(textSize: textSize, isGerman: isGerman);
}

class _CustomerScreenState extends State<CustomerScreen> {
  double btnWidth = 200, btnHeight = 70;
  double textSize = 15;
  bool isGerman = false;
  _CustomerScreenState(
      {Key? key, required this.textSize, required this.isGerman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Kunden-Dashboard',
                  style: TextStyle(fontSize: textSize + 5))
              : Text('Customer Dashboard',
                  style: TextStyle(fontSize: textSize + 5))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: btnWidth,
              height: btnHeight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomerOverview(
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
                    ? Text('Kundenübersicht',
                        style: TextStyle(fontSize: textSize))
                    : Text('Customer Overview',
                        style: TextStyle(fontSize: textSize)),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: btnWidth,
              height: btnHeight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ViewOrder(textSize: textSize, isGerman: isGerman)));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: isGerman
                    ? Text('Bestellung ansehen',
                        style: TextStyle(fontSize: textSize))
                    : Text('View order', style: TextStyle(fontSize: textSize)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
