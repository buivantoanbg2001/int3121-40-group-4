import "package:flutter/material.dart";

class TextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  const TextFieldWidget(
      {Key? key, required this.title, required this.controller})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextField(
            decoration: InputDecoration(
          hintText: "Nhắn #kênh-công-chúa",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
        ))
      ],
    );
  }
}
