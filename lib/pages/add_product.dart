import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/decoration_class.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _addProduct = GlobalKey<FormState>();
  double? _deviceHeight, _deviceWidth;

  String? _name, _description, _brand, _type;
  num? _age, _price;

  File? _image;

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Add Product"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(
              vertical: _deviceHeight! * 0.05,
              horizontal: _deviceWidth! * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageBox(),
              const SizedBox(
                height: 20,
              ),
              _form()
            ],
          ),
        ),
      )),
    );
  }

  Widget _imageBox() {
    return GestureDetector(
      onTap: _addProductPhoto,
      child: Container(
        width: _deviceHeight! * 0.20,
        height: _deviceHeight! * 0.20,
        decoration: BoxDecoration(
          image: _image != null
              ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover)
              : null,
          color: _image == null ? Colors.grey : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: _image == null
            ? const Center(
                child: Text(
                  "Click to Upload image",
                  textAlign: TextAlign.center,
                ),
              )
            : null,
      ),
    );
  }

  Widget _form() {
    return Form(
        key: _addProduct,
        child: Column(
          children: [
            _inputBox("name", "Product Name"),
            const SizedBox(
              height: 10,
            ),
            _productDescription(),
            const SizedBox(
              height: 10,
            ),
            _inputBox("brand", "Product Brand"),
            const SizedBox(
              height: 10,
            ),
            _inputBox("age", "Enter Age"),
            const SizedBox(
              height: 10,
            ),
            _inputBox("type", "Product type"),
            const SizedBox(
              height: 10,
            ),
            _inputBox("price", "Product price"),
            const SizedBox(
              height: 10,
            ),
            _startButton()
          ],
        ));
  }

  Widget _productDescription() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          onSaved: (_value) {
            setState(() {
              _description = _value;
            });
          },
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          cursorColor: const Color.fromARGB(255, 0, 0, 0),
          decoration: DecorationClass.inputProduct("Product Name"),
          validator: (_value) =>
              _value!.length > 60 ? null : "Enter more than 60 words"),
    );
  }

  Widget _inputBox(String name, String title) {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
          keyboardType: name == "age" || name == "price"
              ? TextInputType.number
              : TextInputType.text,
          onSaved: (_value) {
            setState(() {
              switch (name) {
                case "name":
                  _name = _value;
                  break;
                case "brand":
                  _brand = _value;
                  break;
                case "type":
                  _type = _value;
                  break;
                case "age":
                  _age = num.parse(_value!);
                  break;
                case "price":
                  _price = num.parse(_value!);
                  break;
                default:
                  print("error 1");
              }
            });
          },
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          cursorColor: const Color.fromARGB(255, 0, 0, 0),
          decoration: DecorationClass.inputProduct(title),
          validator: (_value) {
            bool error = false;
            switch (name) {
              case "name":
                _value!.length > 6 ? null : error = true;
                break;
              case "brand":
                _value!.length > 6 ? null : error = true;
                break;
              case "type":
                _value!.length > 6 ? null : error = true;
                break;
              case "age":
                _value!.isNotEmpty ? null : error = true;
                break;
              case "price":
                _value!.isNotEmpty ? null : error = true;
                break;
              default:
            }
            if (error) {
              return "enter valid Data";
            } else {
              return null;
            }
          }),
    );
  }

  Widget _startButton() {
    return Container(
      width: _deviceWidth! * 0.9,
      decoration: DecorationClass.primaryButton(_deviceWidth!),
      child: MaterialButton(
        onPressed: () {
          validDate();
        },
        child: const Text(
          "Get Start",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  _addProductPhoto() async {
    FilePickerResult? _result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if(_result!=null){
      setState(() {
      _image = File(_result.files.first.path!);
    });
    }
    
  }

  validDate() async {
    if (_addProduct.currentState!.validate() && _image != null) {
      _addProduct.currentState!.save();
      bool _result = await _firebaseService!.addProduct(
          name: _name!,
          desc: _description!,
          brand: _brand!,
          type: _type!,
          age: _age!,
          price: _price!,
          image: _image!);
      _result ? Navigator.popAndPushNamed(context, "adminpage") : null;
    } else {
      print("object");
    }
  }
}
