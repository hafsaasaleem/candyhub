import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:towermarket/models/order.dart';

import 'pdf_api.dart';

class PdfInvoiceApi {
  static Future<File> generate(Order order) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (_) {
          return [
            buildTitle(order),
          ];
        },
      ),
    );
    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildTitle(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("INVOICE"),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Text(order.products[0].description),
      ],
    );
  }
}
