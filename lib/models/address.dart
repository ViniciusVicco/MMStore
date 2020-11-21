import 'package:flutter/cupertino.dart';

class Address extends ChangeNotifier {
  Address(
      {this.street,
      this.number,
      this.complement,
      this.district,
      this.zipCode,
      this.city,
      this.state,
      this.lat,
      this.long,
      this.error});

  String street;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;
  bool error;

  @override
  String toString() {
    return 'Address{street: $street, number: $number, complement: $complement, district: $district, zipCode: $zipCode, city: $city, state: $state, lat: $lat, long: $long}';
  }

  double lat;
  double long;

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'complement': complement,
      'district': district,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'lat': lat,
      'long': long,
    };
  }
}
