import 'package:flutter/cupertino.dart';

class Address extends ChangeNotifier{

  Address({this.streat, this.number, this.complement, this.district,
      this.zipCode, this.city, this.state, this.lat, this.long, this.error});

  String streat;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;
  bool error;


  @override
  String toString() {
    return 'Address{streat: $streat, number: $number, complement: $complement, district: $district, zipCode: $zipCode, city: $city, state: $state, lat: $lat, long: $long}';
  }

  double lat;
  double long;
}