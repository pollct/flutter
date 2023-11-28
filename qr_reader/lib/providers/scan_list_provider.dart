import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans =  [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> newScan(String valor) async {
    final newScan = ScanModel(valor: valor);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;
    if(tipoSeleccionado == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...?scans];
    notifyListeners();
  }

  loadScansByTipo(String tipo) async {
    final scans = await DBProvider.db.getScansByType(tipo);
    this.scans = [...?scans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  eraseAll() async{
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  eraseScanById(int id) async{
    await DBProvider.db.deleteScan(id);
  }
}