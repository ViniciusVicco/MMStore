import 'package:flutter/material.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/models/store.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  StoreCard(this.store);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme
        .of(context)
        .primaryColor;

    Color colorForStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.closed:
          return Colors.red;
        case StoreStatus.open:
          return Colors.green[600];
        case StoreStatus.closing:
          return Colors.orange;
        default:
          return Colors.green;
      }
    }


    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          Container(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(store.image, fit: BoxFit.cover,),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))
                    ),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                          color: colorForStatus(store.status),
                        fontSize: 16,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 140,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(store.name, style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                      ),
                      Text(
                        store.addressText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        store.openingText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      iconData: Icons.map,
                      color: primaryColor,
                      onTap: () {},
                    ),
                    CustomIconButton(
                      iconData: Icons.phone,
                      color: primaryColor,
                      onTap: () {},
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
