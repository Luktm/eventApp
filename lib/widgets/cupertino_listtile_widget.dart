import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoListTile extends StatefulWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;
  final Function onTap;

  const CupertinoListTile(
      {Key key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap})
      : super(key: key);

  @override
  _StatefulStateCupertino createState() => _StatefulStateCupertino();
}

class _StatefulStateCupertino extends State<CupertinoListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 5.0, // has the effect of softening the shadow
              spreadRadius: 0, // has the effect of extending the shadow
              offset: Offset(
                1.0, // horizontal, move right 10
                1.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.leading != null) widget.leading,
            Text(
              widget.title,
              style: TextStyle(
                color: CupertinoColors.black,
                fontSize: 16,
              ),
            ),
            widget.trailing,
          ],
        ),
      ),
    );
  }
}
