import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout)),
          )
        ],
        title: const Text("Create Inventry"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 2 / 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: image == null
                    ? TextButton(
                        onPressed: () async {
                          await pickImage();
                        },
                        child: const Text("Select Image"),
                      )
                    : Image.file(image!, fit: BoxFit.contain),
              ),
            ),
            DropdownButton(
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
            DropdownButton(
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
            DropdownButton(
              hint: const Text("Symbol"),
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
            TextField(
              controller: _price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "price"),
            ),
            TextField(
              controller: _title,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: "title"),
            ),
            TextField(
              controller: _quantity,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "quantity available"),
            ),
            TextField(
              controller: _description,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: "description"),
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
    'box',
    'kilo',
    'dorzen',
    'cartoon',
    'quantity'
  ];

  final List<String> _categories = const [
    "biscuit",
    "supari",
    "toffess",
    "cake",
    "chocklates",
    "snackes",
    "waffers",
    "bubbles"
  ];

  final List<String> _brands = const [
    "hilal foods",
    "cadbury",
    "kiran",
    "giggly",
    "peakfeerence",
    "LU",
    "bisconni",
    "candiland"
  ];
}
