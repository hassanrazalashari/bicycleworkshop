import 'dart:io';
import 'package:bicycle_workshop/screens/customer_screens/customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateOrder extends StatefulWidget {
  CreateOrder({Key? key, required this.textSize, required this.isGerman})
      : super(key: key);
  double textSize = 15;
  bool isGerman = false;

  State<CreateOrder> createState() =>
      _CreateCustomerOrderState(textSize: textSize, isGerman: isGerman);
}

class _CreateCustomerOrderState extends State<CreateOrder> {
  _CreateCustomerOrderState(
      {Key? key, required this.textSize, required this.isGerman});
  TextEditingController commentController = TextEditingController();

  double btnWidth = 150, btnHeight = 70;
  double textSize = 15;
  String bikeText = "Image of bike";
  bool isUploaded = false;
  bool isGerman = false;

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> order_details = await prefs.getStringList("order_details")!;
    order_details[2] = bikeText;
    await prefs.setStringList("order_details", order_details);
    await prefs.setInt("total_orders", await prefs.getInt("orders")! + 1);
  }

  Future<void> saveServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> services = await prefs.getStringList("services_cust_1")!;

    services = [];

    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        services.add(parts[i]);
      }
    }

    await prefs.setStringList("services_cust_1", services);
  }

  List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  int index = -1;

  List<String> parts = [
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

  List<String> servicesInGerman = [
    "Kette behalten 10€",
    "Spannkette 10€",
    "Kette ersetzen 10€",
    "Bremsen einstellen (vorne/hinten) 11€",
    "Bremsbeläge 11€",
    "Bremszug ersetzen 12€",
    "Speichen anpassen (achter!) 13€",
    "Reifendruck prüfen 14€",
    "Reifen ersetzen (vorne/hinten) 15€",
    "Gänge anpassen 15€",
    "Schaltzug ersetzen 15€",
    "Lichter anpassen 16€",
    "Lichtertausch 16€",
    "Gepäckträger einbauen 17€",
    "Kotflügel ersetzen 18€",
    "Luftpumpe einbauen 19€",
    "Ständer ersetzen 20€",
    "Griffe ersetzen 21€",
    "Schloss ersetzen 22€"
  ];

  File _image = File("");

  final picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isGerman
              ? Text('Bestellung anlegen', style: TextStyle(fontSize: textSize))
              : Text('Create Order', style: TextStyle(fontSize: textSize))),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              color: Colors.amber,
                              child: isUploaded == false
                                  ? Text(
                                      bikeText,
                                      style: TextStyle(fontSize: textSize),
                                    )
                                  : Image.file(_image, fit: BoxFit.cover),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: btnWidth,
                                  height: btnHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() async {
                                        await getImage();
                                        bikeText = _image.path;
                                        isUploaded = false;
                                        await saveUserData();
                                      });
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: isGerman
                                        ? Text('Wählen',
                                            style:
                                                TextStyle(fontSize: textSize))
                                        : Text('Select',
                                            style:
                                                TextStyle(fontSize: textSize)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: btnWidth,
                                  height: btnHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isUploaded = true;
                                        print(isGerman);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: !isGerman
                                        ? Text('Upload',
                                            style:
                                                TextStyle(fontSize: textSize))
                                        : Text('Hochladen',
                                            style:
                                                TextStyle(fontSize: textSize)),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                              itemCount: isSelected.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Checkbox(
                                    value: isSelected[index],
                                    onChanged: (value) {
                                      setState(() {
                                        isSelected[index - 1] = value!;
                                      });
                                    },
                                  ),
                                  title: isGerman
                                      ? Text("${servicesInGerman[index++]}",
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
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                              hintText: isGerman
                                  ? "Kommentar eingeben"
                                  : "Enter Comment",
                              labelText: isGerman ? "Kommentare" : "Comments",
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => CustomerScreen(
                                          textSize: textSize,
                                          isGerman: isGerman),
                                    ));
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: isGerman
                                    ? Text('Stornieren',
                                        style: TextStyle(fontSize: textSize))
                                    : Text('Cancel',
                                        style: TextStyle(fontSize: textSize)),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: btnWidth,
                              height: btnHeight,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    saveServices();
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: isGerman
                                            ? Text(
                                                'Bestellung erfolgreich erstellt')
                                            : Text(
                                                'Order Created Successfully'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              //back to customer dashboard
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: isGerman
                                                ? Text('OK')
                                                : Text('OK'),
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
                                    ? Text('Erstellen',
                                        style: TextStyle(fontSize: textSize))
                                    : Text('Create',
                                        style: TextStyle(fontSize: textSize)),
                              ),
                            ),
                          ],
                        )
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
