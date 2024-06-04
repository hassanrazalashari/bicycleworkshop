import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountingView extends StatefulWidget {
  double textSize;

  AccountingView({Key? key, required this.textSize}) : super(key: key);

  State<AccountingView> createState() =>
      _AccountingViewState(textSize: textSize);
}

class _AccountingViewState extends State<AccountingView> {
  double btnWidth = 200, btnHeight = 150;
  double textSize = 15;

  _AccountingViewState({Key? key, required this.textSize});

  String status = "Not Created";

  void initState() {
    super.initState();
    getServices();
  }

  Future<void> getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = await prefs.getStringList("order_details")![4];

    if (status == "false") status = "Not Created";
    if (await prefs.getStringList("order_details")![5] == "true")
      status = "Paid";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Accounting View',
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
                  setState(() {
                    if (status == "Not Created") status = "Not Paid";
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text('Create Invoice',
                    style: TextStyle(fontSize: textSize)),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text("Invoice Status: " + status,
                style: TextStyle(fontSize: textSize)),
          ],
        ),
      ),
    );
  }
}
