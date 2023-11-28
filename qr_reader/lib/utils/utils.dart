import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

  tryLaunchUrl(BuildContext context,  ScanModel scan) async {
    final url = scan.valor;
    final uri = Uri.parse(url);
    if(scan.tipo == 'http') {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
      else {
        throw Exception('Could not launch $url');
      }
    }
    else {
      Navigator.pushNamed(context, 'map', arguments: scan);
    }
  }