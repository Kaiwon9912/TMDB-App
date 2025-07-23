import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int length;

  const ReadMoreText({required this.text, required this.length});

  @override
  State<ReadMoreText> createState() => ReadMoreTextState();
}

class ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isLong = widget.text.length > widget.length;
    final String displayText = _isExpanded || !isLong
        ? widget.text
        : widget.text.substring(0, widget.length) + '...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(displayText, style: TextStyle(fontSize: 16)),
        if (isLong)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'read less' : 'read more',
              style: TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }
}
