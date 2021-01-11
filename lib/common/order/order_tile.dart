import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/order/export_address_dialog.dart';
import 'package:michellemirandastore/models/order.dart';

import 'cancel_order_dialog.dart';

import 'order_product_tile.dart';



class OrderTile extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  OrderTile({this.order, this.showControls, this.scaffoldKey});
  final Order order;
  final bool showControls;
  Widget build(BuildContext context) {
    final primaryCollor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.formattedId,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryCollor,
                ),
                ),
                Text('R\$ ${order.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 14,
                ),
                ),
              ],
            ),
            Text('${order.statusText}',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: order.status == Status.canceled ? Colors.red :primaryCollor,
              fontSize: 14
            ),)
          ],
        ),
        children: [
          Column(
            children:
              order.items.map((e){
                return OrderProductTile(cartProduct: e,);
              }).toList(),
          ),
          if(showControls && order.status != Status.canceled)
          SizedBox(
            height: 50,
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(

                border: Border.all(
               color: Colors.pinkAccent,

                )
              ),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  FlatButton(onPressed: (){
                    showDialog(context: context,
                    builder: (_) => CancelOrderDialog(order,),
                    );
                  },
                      child: const Text("Cancelar", style: TextStyle(color: Colors.red),),
                  ),
                  FlatButton(onPressed: order.back,
                    child: const Text("Recuar",),
                  ),
                  FlatButton(onPressed: order.advance,
                    child: const Text("Avançar",),
                  ),
                  FlatButton(onPressed: (){
                    showDialog(context: context,
                      builder: (_) => ExportAddressDialog(address: order.address,scaffoldKey: scaffoldKey,),
                    );
                  },
                    child: Text("Endereço", style: TextStyle(color: Theme.of(context).primaryColor),),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
