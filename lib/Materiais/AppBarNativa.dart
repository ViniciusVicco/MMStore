import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarNativa extends StatelessWidget with PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          "${"Michelli Miranda Store"}",
          style: TextStyle(
            fontFamily: "Pacifico",

          ),
        ),
        actions: [
          Container(
            height: 30,
            width: 90,

            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              children: [
                InkWell(
                    onTap: (){print("Logout Pressionado");},
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.call_missed_outgoing,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          Text("Logout",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          )
        ],
      );

  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
