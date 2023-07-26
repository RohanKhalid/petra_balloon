import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  String _scanQrcode = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String qrCodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      qrCodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      qrCodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;

    setState(() {
      _scanQrcode = qrCodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Petra Ballon'),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(170, 4, 4, 1),
        ),
        body: Builder(
          builder: (BuildContext context) {
            double height;
            double width;
            height = MediaQuery.of(context).size.height;
            width = MediaQuery.of(context).size.width;

            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: height / 2,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(170, 4, 4, 1),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Ticket Information:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Text(_scanQrcode),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: height / 9,
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () => scanQR(),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0),
                              side: const BorderSide(
                                color: Color.fromRGBO(170, 4, 4, 1),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(170, 4, 4, 1),
                          ),
                        ),
                        child: const Text(
                          'Scan Ticket',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
