import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:michellemirandastore/common/custom_icon_button.dart';
import 'package:michellemirandastore/models/store.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  StoreCard(this.store);

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).accentColor;

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
    void showError(){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Este dispositivo não possui essa função"), backgroundColor: Colors.red,));
    }

    void openPhone() async {
      if (await canLaunch('tel: ${store.cleanPhone}')) {
        launch('tel: ${store.cleanPhone}');
      } else {
        showError();
      }
    }



    void openMap() async {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        showModalBottomSheet(
            context: context,
            builder: (_) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                              coords:
                                  Coords(store.address.lat, store.address.long),
                              title: store.name,
                              description: store.addressText);
                          Navigator.of(context).pop();
                        },
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          width: 30,
                          height: 30,
                        ),
                      )
                  ],
                ),
              );
            });
      } catch (e) {
        showError();
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
                Image.network(
                  store.image,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(8))),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                          color: colorForStatus(store.status),
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
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
                      Text(
                        store.name,
                        style: TextStyle(
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
                      color: accentColor,
                      onTap: openMap,
                    ),
                    CustomIconButton(
                      iconData: Icons.phone,
                      color: accentColor,
                      onTap: openPhone,
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
