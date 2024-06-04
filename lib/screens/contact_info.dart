import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  double btnWidth = 150, btnHeight = 70;
  double textSize = 15;
  bool isGerman = false;
  ContactInfo({Key? key, required this.textSize, required this.isGerman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Kontaktinformation',
                  style: TextStyle(fontSize: textSize + 5))
              : Text('Contact info', style: TextStyle(fontSize: textSize + 5))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isGerman
                ? Text("Name: Besitzer1",
                    style: TextStyle(fontSize: textSize * 1.5))
                : Text("Name: Owner1",
                    style: TextStyle(fontSize: textSize * 1.5)),
            SizedBox(
              height: 30,
            ),
            Text(
              "Telefon: 0222650209",
              style: TextStyle(fontSize: textSize * 1.5),
            )
          ],
        ),
      ),
    );
  }
}
