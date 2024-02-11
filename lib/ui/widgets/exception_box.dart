import 'package:flutter/material.dart';
import 'package:nike_shop/utils/exception.dart';

class ExceptionBox extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onPressd;
  const ExceptionBox({
    super.key,
    required this.exception,
    required this.onPressd,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(exception.message),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: onPressd,
              child: const Text('تلاش دوباره'))
        ],
      ),
    );
  }
}
