import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigator_bar.dart';
import 'package:qr_reader/screens/directions_screen.dart';
import 'package:qr_reader/screens/maps_historial_screen.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).eraseAll();
            }, 
            icon: const Icon(Icons.delete_forever)
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //final newScan = new ScanModel(valor: 'https://www.google.com');
    //DBProvider.db.newScan(newScan);
    //DBProvider.db.getScanById(2).then((value) => print(value?.valor));
    //DBProvider.db.getAllScans().then(print);

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch(currentIndex) {
      case 0:
        scanListProvider.loadScansByTipo('geo');
        return const MapsHistorialScreen();
      case 1:
        scanListProvider.loadScansByTipo('http');
        return const DirectionsScreen();
      default:
        return const MapsHistorialScreen();
    }
  }
}