import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../helpers/hex_color.dart';

import '../widgets/safe_area_widget.dart';

import './setting_screen.dart';

class FeedbackScreen extends StatefulWidget {

  static const routeName = '/feedback-screen';
  
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  int _rating = 0;

  var _isLoading = false;

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });
  }

  String ratingStatus() {
    switch (_rating) {
      case 1:
        return 'This app is terrible';
        break;
      case 2:
        return 'This app is useable';
        break;
      case 3:
        return 'This app is good';
        break;
      case 4:
        return 'This app is great';
        break;
      case 5:
        return 'This app is excellent';
        break;
      default:
        return 'Please rate this app';
    }
  }

  Future<void> submitFeedback(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));

      showPlatformDialog(
        context: context,
        builder: (ctx) => PlatformAlertDialog(
          title: Text(
            'Feedback send',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            'Thanks for the feedback, we appreciated your time to help us improve more',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)),
            )
          ],
        ),
      );
    } catch (err) {
      print(err);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      appBar: PlatformAppBar(
        title: Text('Feedback'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeAreaWidget(
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Your review will help us to give you a better experience. Make it a good one!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 500.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => rate(1),
                            child: Icon(
                              Icons.star,
                              size: 40,
                              color: _rating >= 1
                                  ? Colors.yellow[900]
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => rate(2),
                            child: Icon(
                              Icons.star,
                              size: 40,
                              color: _rating >= 2
                                  ? Colors.yellow[900]
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => rate(3),
                            child: Icon(
                              Icons.star,
                              size: 40,
                              color: _rating >= 3
                                  ? Colors.yellow[900]
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => rate(4),
                            child: Icon(
                              Icons.star,
                              size: 40,
                              color: _rating >= 4
                                  ? Colors.yellow[900]
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => rate(5),
                            child: Icon(
                              Icons.star,
                              size: 40,
                              color: _rating >= 5
                                  ? Colors.yellow[900]
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(ratingStatus()),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: PlatformTextField(
                        key: UniqueKey(),
                        maxLines: 8,
                        android: (_) => MaterialTextFieldData(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                            ),
                            hintText: "Tell us your experience",
                          ),
                        ),
                        ios: (_) => CupertinoTextFieldData(
                            placeholder: 'Tell us your experience',
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonTheme(
                      minWidth: 150,
                      height: 50,
                      child: RaisedButton(
                        color: HexColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: _rating <= 0
                            ? null
                            : () {
                                submitFeedback(context);
                              },
                        key: UniqueKey(),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
