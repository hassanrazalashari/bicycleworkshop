import 'package:bicycle_workshop/screens/employee_screens/employee_orderview.dart';
import 'package:bicycle_workshop/screens/employee_screens/special_orderview.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  double btnWidth = 200, btnHeight = 150;
  double textSize = 15;
  bool isGerman = false;
  EmployeeScreen({Key? key, required this.textSize, required this.isGerman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Employee Dashboard',
                  style: TextStyle(fontSize: textSize + 5))
              : Text('Mitarbeiter-Dashboard',
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
                      builder: (context) => EmployeeOrderView(
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
                    ? Text('Allgemeine Bestellansicht',
                        style: TextStyle(fontSize: textSize))
                    : Text('General Order View',
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
                      builder: (context) => SpecialOrderView(
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
                    ? Text('Ansicht „Sonderbestellung“.',
                        style: TextStyle(fontSize: textSize))
                    : Text('Special Order view',
                        style: TextStyle(fontSize: textSize)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
