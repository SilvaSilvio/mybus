import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeCreate extends StatefulWidget {
  @override
  _QrCodeCreateState createState() => _QrCodeCreateState();
}

class _QrCodeCreateState extends State<QrCodeCreate> {

  final String data = "123456";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "QrCodeCreate",
            style: TextStyle(
              fontSize: 24,

            ),
            ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          Text("Código gerado com o texto: $data",
          textAlign: TextAlign.center,
          ),
          SizedBox(
              height: 25,
          ),

          QrImage(
            data: data,
            size: 300,
            version: QrVersions.min,
            //foregroundColor: Colors.white,
            //backgroundColor: Colors.black,
            errorCorrectionLevel: QrErrorCorrectLevel.L,
            
          ),
          ],),
        ),
    );
  }
}