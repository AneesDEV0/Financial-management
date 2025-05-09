// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;
import '../../Feature/add_Financial/data/model/add_financial_model.dart';

Future<void> generateFinancialReportPdf(
    List<AddFinancialModel> financialData) async {
  final pdf = pw.Document();
  final now = DateTime.now();

  // Load the Arabic font
  final fontData = await rootBundle.load("assets/founts/Cairo-Regular.ttf");
  final arabicFont = pw.Font.ttf(fontData);

  // Add a page with right-aligned content
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 10),
              pw.Container(
                height: 30, // Height of the line for signature
                width: 999, // Width of the line for signature
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(
                        width: 1, color: PdfColors.black), // Line for signature
                  ),
                ),
                child: pw.Text(
                  'سجل معاملات مالية',
                  style: pw.TextStyle(font: arabicFont, fontSize: 12),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(8),
                  1: const pw.FlexColumnWidth(2),
                  2: const pw.FlexColumnWidth(3),
                  3: const pw.FlexColumnWidth(3),
                  4: const pw.FlexColumnWidth(2),
                  5: const pw.FlexColumnWidth(3),
                  6: const pw.FlexColumnWidth(2),
                  7: const pw.FlexColumnWidth(2),
                },
                children: [
                  // Header Row
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(
                            0), // Padding around the cell

                        child: pw.Expanded(
                          child: pw.Text('ملاحظات',
                              style:
                                  pw.TextStyle(font: arabicFont, fontSize: 8),
                              textAlign: pw.TextAlign.center),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text('نوع المشروع',
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text('تاريخ المعاملة',
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text('تاريخ الفاتورة',
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text('السعر',
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text('المورد',
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(1),
                        child: pw.Text('الرقم',
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      ),
                    ],
                  ),
                  // Data Rows
                  for (var item in financialData)
                    pw.TableRow(
                      children: [
                        pw.Expanded(
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(1),
                            child: pw.Text(
                              '${item.projectState} : ${item.note == "" ? 'لا توجد' : item.note!}',
                              style:
                                  pw.TextStyle(font: arabicFont, fontSize: 8),
                              textAlign: pw.TextAlign.center,
                              // Limit to one line
                              overflow: pw.TextOverflow
                                  .clip, // Add ellipsis if text overflows
                            ),
                          ),
                        ),

                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.projectType,
                              style:
                                  pw.TextStyle(font: arabicFont, fontSize: 8),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(
                            "${item.financialDate.day}/${item.financialDate.month}/${item.financialDate.year}",
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(
                            "${item.pillDate.day}/${item.pillDate.month}/${item.pillDate.year}",
                            style: pw.TextStyle(font: arabicFont, fontSize: 8),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        // pw.Padding(
                        //   padding: const pw.EdgeInsets.all(1),
                        //   child: pw.Text(item.carance,
                        //       style:
                        //           pw.TextStyle(font: arabicFont, fontSize: 8),
                        //       textAlign: pw.TextAlign.center),
                        // ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text('${item.carance} ${item.price}',
                              style:
                                  pw.TextStyle(font: arabicFont, fontSize: 8),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.supplierName,
                              style:
                                  pw.TextStyle(font: arabicFont, fontSize: 8),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Text(item.funantialNo,
                              style:
                                  pw.TextStyle(font: arabicFont, fontSize: 8),
                              textAlign: pw.TextAlign.center),
                        ),
                      ],
                    ),
                ],
              ),
              pw.SizedBox(height: 20), // Space before the signature area
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    children: [
                      pw.Text('توقيع',
                          style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                      pw.SizedBox(width: 10),
                      pw.Container(
                        height: 15, // Height of the line for signature
                        width: 100, // Width of the line for signature
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(
                                width: 1,
                                color: PdfColors.black), // Line for signature
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                          'تاريخ التقرير: ${now.day}/${now.month}/${now.year} '
                          ' ${now.hour}:${now.minute} ',
                          style: pw.TextStyle(font: arabicFont, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  // Save the PDF to a file on the desktop
  // Save the PDF to a file on the desktop
  String folderName = "full-transactions";
  folderName = "التقارير_الكاملة";
  final userHomeDir = Platform.environment['USERPROFILE'];
  final desktopPath = path.join(userHomeDir!, "Desktop", "reports", folderName,
      "${now.year}-${now.month}-${now.day}");
  final reportDir = Directory(desktopPath);
  if (!await reportDir.exists()) {
    await reportDir.create(recursive: true);
  }

  final formattedDate =
      '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}';
  final file = File(path.join(reportDir.path, 'report-at-$formattedDate.pdf'));
  await file.writeAsBytes(await pdf.save());
}
/*





 */