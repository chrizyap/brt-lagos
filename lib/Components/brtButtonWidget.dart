import 'package:brtbus/Components/brttap.dart';
import 'package:flutter/material.dart';

class BrtButtonWidget extends StatefulWidget {
  final String text;
  final Function onTap;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double height;
  final double width;

  bool loadingState;
  bool danger;

  Color buttonColor;
  Color shadowColor;
  Color textColor;
  BrtButtonWidget(
      {Key key,
      @required this.text,
      @required this.onTap,
      this.loadingState = false,
      this.fontSize = 12,
      this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 80),
      this.height = 45,
      this.width = 100,
      this.buttonColor,
      this.textColor,
      this.shadowColor,
      this.danger = false})
      : super(key: key);

  @override
  _BrtButtonWidget createState() => _BrtButtonWidget();
}

class _BrtButtonWidget extends State<BrtButtonWidget> {
  Widget getLoadingState() {
    if (widget.loadingState) {
      return CircularProgressIndicator(
          valueColor: (!widget.danger)
              ? AlwaysStoppedAnimation<Color>(Colors.blue)
              : AlwaysStoppedAnimation<Color>(Colors.red));
    }
    return BrtTap(
      onTap: () => widget.onTap(),
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.8,
        width: widget.width,
        height: widget.height,
        // padding: widget.padding,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.shadowColor ??
                    ((!widget.danger)
                        ? Color.fromRGBO(1, 103, 246, 0.38)
                        : Color.fromRGBO(235, 12, 12, 0.15)),
                // blurRadius: 5.0, // has the effect of softening the shadow
                spreadRadius: 1, // has the effect of extending the shadow
                // offset: Offset(
                //   0.0, // horizontal, move right 10
                //   1.0, // vertical, move down 10
                // ),
              )
            ],
            borderRadius: BorderRadius.circular(4),
            color: widget.buttonColor ??
                ((widget.danger)
                    ? const Color(0xffEB0C0C)
                    : const Color(0xff0047CC))),
        child: Center(
            child: Text(widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: widget.textColor ?? Colors.white,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    decoration: TextDecoration.none))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: getLoadingState());
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[getLoadingState()],
    // );
  }
}
