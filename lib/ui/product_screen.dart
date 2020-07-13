import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crud_app/model/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen(this.product);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ProductScreenState extends State<ProductScreen> {
  List<Product> items;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _durationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.product.name);
    _descriptionController = new TextEditingController(text: widget.product.description);
    _durationController = new TextEditingController(text: widget.product.duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Reserva Sala De Reunion'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        height: 350.0,
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.red),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.red),
                  decoration: InputDecoration(
                      icon: Icon(Icons.today), labelText: 'Fecha'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),

                Divider(),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _durationController,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.red),
                  decoration: InputDecoration(
                      icon: Icon(Icons.access_time), labelText: 'Duracion'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),

                FlatButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      if (widget.product.id != null) {
                        productReference.child(widget.product.id).set({
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                          'duration' : _durationController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        productReference.push().set({
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                          'duration' : _durationController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.product.id != null) ? Text('Actualizar') : Text('Agendar')),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
