import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../helpers/hex_color.dart';

import '../widgets/scaffold_widget.dart';
import '../widgets/logo_widget.dart';

class HomeScreen extends StatelessWidget {
  final Color announcmentTitleColor = HexColor('#3C3C3C');
  final Color lineColor = HexColor('#DBDBDB');

  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Home',
      hasAppbar: true,
      appbarButton: <Widget>[],
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: LogoWidget(
              height: 100,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Text(
                  'Announcement',
                  style: TextStyle(
                    color: announcmentTitleColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    ),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: entries.length,
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (ctx, i) => Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 5.0,
                margin: EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(100),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.notifications_none,
                          color: HexColor.accentColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In dignissim.',
                            style: TextStyle(
                              fontSize: 13,
                              color: HexColor.accentColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
