import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crud_app/model/product.dart';
import 'package:flutter/services.dart';

class ProductInformation extends StatefulWidget {
  final Product product;
  ProductInformation(this.product);
  @override
  _ProductInformationState createState() => _ProductInformationState();
}
final productReference = FirebaseDatabase.instance.reference().child('product');

class _ProductInformationState extends State<ProductInformation> {
  List<Product> items;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Guatex - Reservas'),
        backgroundColor: Colors.deepOrangeAccent,

      ),
      body: Container(
        height: 190.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text("Nombre : ${widget.product.name}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Fecha : ${widget.product.description}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Duracion (Hs) : ${widget.product.duration}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
              ],
            ) ,
          ),
        ),
      ),
    );
  }
}
