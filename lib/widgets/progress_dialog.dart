import 'package:flutter/material.dart';

class ProgressDialog extends StatefulWidget {
//  const ProgressDialog({this.msg})
  ProgressDialog({this.message});
  String? message;

  @override
  State<ProgressDialog> createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
              const SizedBox(
                width: 26,
              ),
              Text(
                widget.message!,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
