import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF', 
          'Cancelar', 
          false, 
          ScanMode.QR
        );
        if(barcodeScanRes == '-1') {
          return;
        }
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.newScan(barcodeScanRes);
        //final barcodeScanRes = 'https://www.google.com';
        //final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        //scanListProvider.newScan(barcodeScanRes);
        //final newScan = await scanListProvider.newScan('geo:-2.192566,-79.879288');
        //tryLaunchUrl(context, newScan);
        
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}