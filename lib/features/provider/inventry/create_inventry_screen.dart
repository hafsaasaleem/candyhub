import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:towermarket/colors/towermarket_colors.dart';

class CreateInventryScreen extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (_) => const CreateInventryScreen());
  }

  const CreateInventryScreen({Key? key}) : super(key: key);

  @override
  State<CreateInventryScreen> createState() => _CreateInventryScreenState();
}

class _CreateInventryScreenState extends State<CreateInventryScreen> {
  late final TextEditingController _price;
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _quantity;

  String? _selectSymbol;
  String? _selectCategory;
  String? _selectBrand;

  File? image;
  @override
  void initState() {
    super.initState();
    _price = TextEditingController();
    _title = TextEditingController();
    _description = TextEditingController();
    _quantity = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _price.dispose();
    _title.dispose();
    _description.dispose();
    _quantity.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Inventry"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  AspectRatio(
                    aspectRatio: 2 / 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: TowermarketColors.black),
                      ),
                      child: image == null
                          ? ElevatedButton(
                              onPressed: () async {
                                await pickImage();
                              },
                              child: const Text("Select Image"),
                            )
                          : Image.file(image!, fit: BoxFit.contain),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text("Category"),
                      value: _selectCategory,
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selectCategory = newvalue;
                        });
                      },
                      items: List.generate(_categories.length, (index) {
                        return DropdownMenuItem(
                          value: _categories[index],
                          child: Text(_categories[index]),
                        );
                      }),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text("Brand"),
                      value: _selectBrand,
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selectBrand = newvalue;
                        });
                      },
                      items: List.generate(_brands.length, (index) {
                        return DropdownMenuItem(
                          value: _brands[index],
                          child: Text(_brands[index]),
                        );
                      }),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text("Symbol"),
                      value: _selectSymbol,
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selectSymbol = newvalue;
                        });
                      },
                      items: List.generate(_symbols.length, (index) {
                        return DropdownMenuItem(
                          value: _symbols[index],
                          child: Text(_symbols[index]),
                        );
                      }),
                    ),
                  ),
                  _InputPrice(price: _price),
                  InputTitle(title: _title),
                  _InputQuantity(quantity: _quantity),
                  InputDescription(description: _description),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: createInventry,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      log("Failed to pick image: $e");
    }
  }

  Future<String> uploadFile() async {
    final path =
        'productsImages/${image!.absolute.path.substring(image!.absolute.path.lastIndexOf('/'), image!.absolute.path.length)}';
    final file = image;
    final storageRef = FirebaseStorage.instance.ref();
    await storageRef.child(path).putFile(file!);

    final url = await storageRef.child(path).getDownloadURL();
    return url;
  }

  Future<void> createInventry() async {
    final imageUrl = await uploadFile();
    final int price = int.tryParse(_price.text) ?? 0;
    final String title = _title.text;
    final String desc = _description.text;
    final int quantity = int.tryParse(_quantity.text) ?? 0;
    final category = _selectCategory ?? '';
    final symbol = _selectSymbol;
    final brand = _selectBrand;
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("products");
    await collection
        .add({
          "category": category,
          "brand": brand,
          "symbol": symbol,
          "quantity": quantity,
          "price": price,
          "title": title,
          "description": desc,
          "createdAt": DateTime.now(),
          "updatedAt": DateTime.now(),
          "imageUrl": imageUrl,
        })
        .then((value) => log("Product Added"))
        .catchError((error) => log("Failed to add Product: $error"));

    setState(() {
      _selectCategory = null;
      _selectSymbol = null;
      _selectBrand = null;
      _price.clear();
      _title.clear();
      _description.clear();
      _quantity.clear();
    });
  }

  final List<String> _symbols = const [
    'Box',
    'Kilo',
    'Dorzen',
    'Cartoon',
    'Quantity'
  ];

  final List<String> _categories = const [
    "Biscuit",
    "Supari",
    "Toffees",
    "Cake",
    "Chocklates",
    "Snackes",
    "Waffers",
    "Bubbles"
  ];

  final List<String> _brands = const [
    "Hilal foods",
    "Cadbury",
    "kiran",
    "Giggly",
    "Peakfeerence",
    "LU",
    "Bisconni",
    "Candiland"
  ];
}

class InputDescription extends StatelessWidget {
  const InputDescription({
    Key? key,
    required TextEditingController description,
  })  : _description = description,
        super(key: key);

  final TextEditingController _description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: _description,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(hintText: "Description"),
      ),
    );
  }
}

class _InputQuantity extends StatelessWidget {
  const _InputQuantity({
    Key? key,
    required TextEditingController quantity,
  })  : _quantity = quantity,
        super(key: key);

  final TextEditingController _quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: _quantity,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: "Quantity"),
      ),
    );
  }
}

class InputTitle extends StatelessWidget {
  const InputTitle({
    Key? key,
    required TextEditingController title,
  })  : _title = title,
        super(key: key);

  final TextEditingController _title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: _title,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(hintText: "Title"),
      ),
    );
  }
}

class _InputPrice extends StatelessWidget {
  const _InputPrice({
    Key? key,
    required TextEditingController price,
  })  : _price = price,
        super(key: key);

  final TextEditingController _price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: _price,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: "Price"),
      ),
    );
  }
}
