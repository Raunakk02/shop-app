import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget baseIconWidget;
  final String data;
  Badge({
    @required this.baseIconWidget,
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          baseIconWidget,
          Positioned(
            top: 5,
            right: 2,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: FittedBox(
                child: Text(data),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
