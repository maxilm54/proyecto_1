import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Product {
  String _id;
  String _name;
  String _description;
  String _duration;

  Product(this._id, this._name, this._description, this._duration);

  Product.map(dynamic obj){
    this._name = obj['name'];
    this._description = obj['description'];
    this._duration = obj['duration'];
  }

  String get id => _id;
  String get name => _name;
  String get description=> _description;
  String get duration=> _duration;

  Product.fromSnapShot(DataSnapshot snapshot){ //creamos una tabla en firebase, desde un archivo hacemos el mapeo y mos crea la estructura
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _description = snapshot.value['description'];
    _duration = snapshot.value['duration'];
  }
}