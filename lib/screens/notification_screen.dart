import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../models/message.dart';

import '../helpers/hex_color.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notification-screen';

  final Color announcmentTitleColor = HexColor('#3C3C3C');
  final Color lineColor = HexColor('#DBDBDB');

  final List<Message> entries = [
    Message(
        message: 'The Event is stating in 3 hours, see you soon.',
        time: '1hrs'),
    Message(
        message:
            'The lucky draw will be stating soon, please return to your seats',
        time: '2hrs'),
    Message(
        message: 'The event has ended, thank you for participating',
        time: '3hrs'),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Notification'),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     children: <Widget>[
            //       Text(
            //         'Announcement',
            //         style: TextStyle(
            //           color: announcmentTitleColor,
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           child: Divider(
            //             color: Colors.black,
            //             height: 36,
            //           ),
            //           margin: EdgeInsets.only(
            //             left: 10,
            //             right: 20,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Expanded(
              child: ListView.builder(
                // reverse: true,
                shrinkWrap: true,
                itemCount: entries.length,
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                itemBuilder: (ctx, i) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(100),
                      child: Column(
                        children: <Widget>[
                          Row(
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
                                  entries[i].message,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: HexColor.accentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: HexColor.greyColor,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                entries[i].time,
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
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
      ),
    );
  }
}
