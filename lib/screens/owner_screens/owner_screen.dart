import 'package:bicycle_workshop/screens/owner_screens/accounting_view.dart';
import 'package:bicycle_workshop/screens/owner_screens/invoice_view.dart';
import 'package:bicycle_workshop/screens/owner_screens/owner_overview.dart';
import 'package:flutter/material.dart';

class OwnerScreen extends StatelessWidget {
  double btnWidth = 200, btnHeight = 70;
  double textSize;
  bool isGerman = false;

  OwnerScreen({Key? key, required this.textSize, required this.isGerman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Besitzer-Dashboard',
                  style: TextStyle(fontSize: textSize + 5))
              : Text('Owner Dashboard',
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
                      builder: (context) => OwnerOverView(textSize: textSize)));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: isGerman
                    ? Text('Eigentümerübersicht',
                        style: TextStyle(fontSize: textSize))
                    : Text('Owner Overiew',
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
                          AccountingView(textSize: textSize)));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: isGerman
                    ? Text('Buchhaltungsansicht',
                        style: TextStyle(fontSize: textSize))
                    : Text('Accounting view',
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
                          OwnerInvoiceView(textSize: textSize)));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: isGerman
                    ? Text('Rechnungsansicht',
                        style: TextStyle(fontSize: textSize))
                    : Text('Invoice view',
                        style: TextStyle(fontSize: textSize)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
