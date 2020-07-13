import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:crud_app/ui/product_screen.dart';//en estos tres imports traemos los 3 archivos que creamos
import 'package:crud_app/ui/produtc_information.dart';
import 'package:crud_app/model/product.dart';
import 'package:flutter/services.dart';

class ListViewProduct extends StatefulWidget {
  @override
  _ListViewProductState createState() => _ListViewProductState();
}

final productReference = FirebaseDatabase.instance.reference().child('product'); //instancia que generea la tabla con el nombre product

class _ListViewProductState extends State<ListViewProduct> {
  List<Product> items;
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _onProductAddedSubscription = productReference.onChildAdded.listen(_onProductAdded); //creo las insracias al final
    _onProductChangedSubscription = productReference.onChildChanged.listen(_onProductUpdate);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onProductAddedSubscription.cancel();//para tecla cancelar
    _onProductChangedSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sala de Reunion',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Guantex - Reservas'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position){
                return Column(
                  children: <Widget>[
                    Divider(height: 7.0,),
                    Row(
                      children: <Widget>[
                        Expanded(child: ListTile(title: Text('${items[position].name}',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 21.0,
                        ),
                        ),
                          subtitle:
                          Text('${items[position].description}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 21.0,
                            ),
                          ),

                        onTap: () => _navigateToProductInformation(context, items[position])),),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red,),
                            onPressed: () => _deleteProduct(context, items[position], position)),
                        IconButton(
                            icon: Icon(Icons.visibility, color: Colors.blueAccent,),
                            onPressed: () => _navigateToProduct(context, items[position])),

                        ],
                    ),
                  ],
                );
            }, ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.red,
          onPressed: () => _createNewProduct(context),
        ),
      ),
    );
  }
  //funciones de los botones
  void _onProductAdded(Event event){
    setState(() {
      items.add(new Product.fromSnapShot(event.snapshot));
    });
  }
  void _onProductUpdate(Event event){
    var oldProductValue = items.singleWhere((product) => product.id==event.snapshot.key); //para tomar el mismo producto por id
    setState(() {
      items[items.indexOf(oldProductValue)] = new Product.fromSnapShot(event.snapshot);
    });
  }
  void _deleteProduct(BuildContext context, Product product, int position)async{
      await productReference.child(product.id).remove().then((_){
        setState(() {
          items.removeAt(position);
        });
      });
  }
  void _navigateToProductInformation(BuildContext context, Product product)async{
    await Navigator.push(context,
    MaterialPageRoute(builder: (context) => ProductScreen(product)),
    );
  }
  void _navigateToProduct(BuildContext context, Product product)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductInformation(product)),
    );
  }
  void _createNewProduct(BuildContext context)async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductScreen(Product(null,'','',''))),
    );
  }
}


