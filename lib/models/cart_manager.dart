import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:michellemirandastore/models/address.dart';
import 'package:michellemirandastore/models/cart_product.dart';
import 'package:michellemirandastore/models/product.dart';
import 'package:michellemirandastore/models/user.dart';
import 'package:michellemirandastore/models/user_manager.dart';
import 'package:michellemirandastore/services/cepaberto_service.dart';

class CartManager extends ChangeNotifier {

  List<CartProduct> items = [];

  User user;
  Address address;
  num productsPrice = 0.0;
  num deliveryPrice;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0 );

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }


  void updateUser(UserManager userManager) {
    user = userManager.user;
    productsPrice = 0.0;
    items.clear();
    removeAddres();
    if (user != null) {
      _loadCartItems();
      _loadUserAddress();

    }
  }

  Future<void> _loadUserAddress() async{
    if(user.address != null && await calculateDelivery(user.address.lat, user.address.long)){
      address = user.address;
      notifyListeners();
    }

  }


  _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    items = cartSnap.documents.map(
            (d) =>
        CartProduct.fromDocument(d)
          ..addListener(_onItemUpdated)
    ).toList();
  }


  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap()).then((doc) =>
      cartProduct.id = doc.documentID);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }

    print(productsPrice);
    notifyListeners();
  }

  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null)
      user.cartReference.document(cartProduct.id).updateData(
          cartProduct.toCartItemMap());
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  // ADDRESS

  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CepAbertoService();
    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);
      // No caso de troca de A P I -> fica mais fácil
      if (cepAbertoAddress != null) {
        address = new Address(
            district: cepAbertoAddress.bairro,
            city: cepAbertoAddress.cidade.nome,
            zipCode: cepAbertoAddress.cep,
            street: cepAbertoAddress.logradouro,
            long: cepAbertoAddress.longitude,
            lat: cepAbertoAddress.latitude,
            state: cepAbertoAddress.estado.sigla

        );
      }
      loading = false;
      print(cepAbertoAddress);
    } catch (e) {
      debugPrint(e);
      loading = false;
      return Future.error('CEP Inválido');

    }
    loading = false; // Já tem um notify dentro do loading.
  }

  Future<void> setAddress(Address address) async{
    loading = true;
    this.address = address; // o This acessa o atributo da classe em si.

    if(await calculateDelivery(address.lat, address.long)){
      user.setAddress(address);
      print('Preço: $deliveryPrice');
      notifyListeners();
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }

  Future<bool> calculateDelivery(double lat, double long) async{
    final DocumentSnapshot doc = await Firestore.instance.document('aux/delivery').get();


    final latStore = doc.data['lat'] as double;
    final longStore = doc.data['long'] as double;
    final maxkm = doc.data['maxkm'] as num;
    final base = doc.data['base'] as num;
    final km = doc.data['km'] as num;

    double dis = await
    Geolocator().distanceBetween(latStore, longStore, lat, long);

    dis /= 1000;
    debugPrint('Distance $dis');
    if(dis > maxkm){
      return false;
    }
    // deliveryPrice = base + dis * km;
    deliveryPrice = 1;
    return true;
  }

  void removeAddres() async {
    address = null; // Fazendo o address obter nullo, e notificando
    deliveryPrice = null;
    notifyListeners();
  }

  void clear() {
    for(CartProduct cartProduct in items) {
      user.cartReference.document(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }


  }







