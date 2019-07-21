import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';

class DropdownComponent extends StatefulWidget {
  final double width, height;
  final String hintText, selected;
  final EdgeInsetsGeometry contentPadding;
  final List<String> options;
  final ValueChanged<String> onChanged;

  DropdownComponent(
      {this.width = 300,
      this.height = 60,
      this.hintText,
      this.contentPadding =
          const EdgeInsets.only(left: 25, top: 5, bottom: 5, right: 5),
      this.options,
      this.selected = "",
      this.onChanged});

  @override
  _DropdownComponentState createState() => _DropdownComponentState();
}

class _DropdownComponentState extends State<DropdownComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColor.light_gray,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.light_gray,
                ),
                child: Container(
                  width: widget.width,
                  padding: EdgeInsets.only(left: 25),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: widget.selected,
                      hint: Text(widget.hintText, style: TextStyle(color: AppColor.text_color),),
                      onChanged: widget.onChanged,
                      isExpanded: true,
                      items: widget.options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
