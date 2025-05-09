// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;

import '../../Feature/add_Financial/data/model/add_financial_model.dart';

Future<void> generateMultipleTransactionsPdf(
    List<AddFinancialModel> financialDataList) async {
  final pdf = pw.Document();
  final now = DateTime.now();

  // Load the Arabic font
  final fontData = await rootBundle.load("assets/founts/Cairo-Regular.ttf");
  final arabicFont = pw.Font.ttf(fontData);

  // Loop through the list of financial data and create a page for each item
  for (var financialData in financialDataList) {
    // Add a page with right-aligned content for each financial data item
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Container(
                    height: 30, // Height of the line for signature
                    width: 999, // Width of the line for signature
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(
                            width: 1,
                            color: PdfColors.black), // Line for signature
                      ),
                    ),
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'سجل معاملات مالية',
                            style: pw.TextStyle(font: arabicFont, fontSize: 12),
                          ),
                          pw.SizedBox(
                            width: 200,
                            child: pw.Text(
                              'تاريخ التقرير: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} '
                              ' : ${DateTime.now().hour}:${DateTime.now().minute}',
                              style:
                                  pw.TextStyle(font: arabicFont, fontSize: 12),
                            ),
                          ),
                        ])),
                pw.SizedBox(height: 20),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'رقم الفاتورة: ${financialData.funantialNo}',
                        style: pw.TextStyle(font: arabicFont, fontSize: 12),
                      ),
                      pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.SizedBox(
                                width: 200,
                                child: pw.Text(
                                  'تاريخ الفاتورة: ${financialData.pillDate.day}/${financialData.pillDate.month}/${financialData.pillDate.year}',
                                  style: pw.TextStyle(
                                      font: arabicFont, fontSize: 12),
                                ),
                              ),
                            ],
                          )),
                    ]),
                pw.SizedBox(height: 10),
                pw.Text(
                  'المورد: ${financialData.supplierName}',
                  style: pw.TextStyle(font: arabicFont, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'نوع المشروع: ${financialData.projectType}',
                  style: pw.TextStyle(font: arabicFont, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'السعر: ${financialData.carance} ${financialData.price} ',
                  style: pw.TextStyle(font: arabicFont, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'الاجراء المطلوب ${financialData.projectState} ${financialData.note == "" ? 'لا توجد' : financialData.note!}',
                  style: pw.TextStyle(font: arabicFont, fontSize: 12),
                ),
                pw.Text(
                  ' في ${financialData.editFinancialDate.day}/${financialData.editFinancialDate.month}/${financialData.editFinancialDate.year}',
                  style: pw.TextStyle(font: arabicFont, fontSize: 12),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text('الاجراء التالي',
                        style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.normal)),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30),
                      child: pw.Container(
                        height: 10, // Height of the line for signature
                        width: 400, // Width of the line for signature
                        margin: const pw.EdgeInsets.only(right: 20),
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(
                                width: 1,
                                color: PdfColors.black), // Line for signature
                          ),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 200),
                  ],
                ),
                pw.SizedBox(height: 10),
                financialData.projectState == "تحويل"
                    ? pw.Row(
                        children: [
                          pw.Text('التوجيه',
                              style: pw.TextStyle(
                                  font: arabicFont,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.SizedBox(width: 10),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 30),
                            child: pw.Container(
                              height: 10, // Height of the line for signature
                              width: 420, // Width of the line for signature
                              margin: const pw.EdgeInsets.only(right: 20),
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(
                                      width: 1,
                                      color: PdfColors
                                          .black), // Line for signature
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 200),
                        ],
                      )
                    : pw.Container(),
                pw.SizedBox(height: 20),

                // add some checkboxes
                pw.Row(children: [
                  pw.Checkbox(
                      value: false,
                      name: "فاتورة ضريبة",
                      height: 15,
                      width: 15),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    "فاتورة ضريبة",
                    style: pw.TextStyle(font: arabicFont, fontSize: 12),
                  ),
                ]),
                pw.SizedBox(height: 8),
                pw.Row(children: [
                  pw.Checkbox(value: false, name: "عقد", height: 15, width: 15),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    "عقد",
                    style: pw.TextStyle(font: arabicFont, fontSize: 12),
                  ),
                ]),
                pw.SizedBox(height: 8),
                pw.Row(children: [
                  pw.Checkbox(
                      value: false, name: "ارسالية", height: 15, width: 15),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    "ارسالية",
                    style: pw.TextStyle(font: arabicFont, fontSize: 12),
                  ),
                ]),
                pw.SizedBox(height: 8),
                pw.Row(children: [
                  pw.Checkbox(
                      value: false, name: "عروض اسعار", height: 15, width: 15),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    "عروض اسعار",
                    style: pw.TextStyle(font: arabicFont, fontSize: 12),
                  ),
                ]),
                pw.SizedBox(height: 8),
                pw.Row(children: [
                  pw.Checkbox(
                      value: false, name: "عروض اسعار", height: 15, width: 15),
                  pw.SizedBox(width: 8),
                  pw.Text(
                    "امر توريد",
                    style: pw.TextStyle(font: arabicFont, fontSize: 12),
                  ),
                ]),
                pw.SizedBox(height: 8),

                pw.Row(children: [
                  pw.Checkbox(
                      value: false, name: "محضر استلام", height: 15, width: 15),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    "محضر استلام",
                    style: pw.TextStyle(font: arabicFont, fontSize: 12),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }

  // Save the PDF to a file on the desktop
  final userHomeDir = Platform.environment['USERPROFILE'];
  final desktopPath = path.join(
      userHomeDir!,
      "Desktop",
      "reports",
      financialDataList.length == 1
          // ? "single-transaction"
          ? "تقرير_معاملة_واحدة"
          // : "multiple-transactions",
          : "تقارير_عدة_معاملات",
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
  final reportDir = Directory(desktopPath);
  if (!await reportDir.exists()) {
    await reportDir.create(recursive: true);
  }

  final formattedDate =
      '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}';
  final file = File(path.join(reportDir.path, 'report-at-$formattedDate.pdf'));

  await file.writeAsBytes(await pdf.save());
}




// // ignore_for_file: depend_on_referenced_packages

// import 'dart:io';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path/path.dart' as path;

// import '../../Feature/add_Financial/data/model/add_financial_model.dart';

// Future<void> generateSingleTransactionPdf(
//     AddFinancialModel financialData) async {
//   final pdf = pw.Document();
//   final now = DateTime.now();

//   // Load the Arabic font
//   final fontData = await rootBundle.load("assets/founts/Cairo-Regular.ttf");
//   final arabicFont = pw.Font.ttf(fontData);

//   // Add a page with right-aligned content
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Directionality(
//           textDirection: pw.TextDirection.rtl,
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             mainAxisSize: pw.MainAxisSize.min,
//             children: [
//               pw.Container(
//                   height: 30, // Height of the line for signature
//                   width: 999, // Width of the line for signature
//                   decoration: const pw.BoxDecoration(
//                     border: pw.Border(
//                       bottom: pw.BorderSide(
//                           width: 1,
//                           color: PdfColors.black), // Line for signature
//                     ),
//                   ),
//                   child: pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text(
//                           'سجل معاملات مالية',
//                           style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                         ),
//                         pw.SizedBox(
//                           width: 200,
//                           child: pw.Text(
//                             'تاريخ التقرير: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} '
//                             ' : ${DateTime.now().hour}:${DateTime.now().minute}',
//                             style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                           ),
//                         ),
//                       ])),
//               pw.SizedBox(height: 20),
//               pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       'رقم الفاتورة: ${financialData.funantialNo}',
//                       style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                     ),
//                     pw.Align(
//                         alignment: pw.Alignment.centerLeft,
//                         child: pw.Column(
//                           crossAxisAlignment: pw.CrossAxisAlignment.end,
//                           children: [
//                             pw.SizedBox(
//                               width: 200,
//                               child: pw.Text(
//                                 'تاريخ الفاتورة: ${financialData.pillDate.day}/${financialData.pillDate.month}/${financialData.pillDate.year}',
//                                 style: pw.TextStyle(
//                                     font: arabicFont, fontSize: 12),
//                               ),
//                             ),
//                             // pw.SizedBox(height: 5),
//                             // pw.SizedBox(
//                             //   width: 200,
//                             //   child: pw.Text(
//                             //     'تاريخ التقرير: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} '
//                             //     ' : ${DateTime.now().hour}:${DateTime.now().minute}',
//                             //     style: pw.TextStyle(
//                             //         font: arabicFont, fontSize: 12),
//                             //   ),
//                             // )
//                           ],
//                         )),
//                   ]),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'المورد: ${financialData.supplierName}',
//                 style: pw.TextStyle(font: arabicFont, fontSize: 12),
//               ),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'نوع المشروع: ${financialData.projectType}',
//                 style: pw.TextStyle(font: arabicFont, fontSize: 12),
//               ),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'السعر: ${financialData.carance} ${financialData.price} ',
//                 style: pw.TextStyle(font: arabicFont, fontSize: 12),
//               ),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'الاجراء المطلوب ${financialData.projectState} ${financialData.note == "" ? 'لا توجد' : financialData.note!}',
//                 style: pw.TextStyle(font: arabicFont, fontSize: 12),
//               ),
//               pw.Text(
//                 ' في ${financialData.editFinancialDate.day}/${financialData.editFinancialDate.month}/${financialData.editFinancialDate.year}',
//                 style: pw.TextStyle(font: arabicFont, fontSize: 12),
//               ),
//               pw.SizedBox(height: 20),
//               pw.Row(
//                 children: [
//                   pw.Text('الاجراء التالي',
//                       style: pw.TextStyle(
//                           font: arabicFont,
//                           fontSize: 12,
//                           fontWeight: pw.FontWeight.normal)),
//                   pw.Padding(
//                     padding: const pw.EdgeInsets.only(left: 30),
//                     child: pw.Container(
//                       height: 10, // Height of the line for signature
//                       width: 400, // Width of the line for signature
//                       margin: const pw.EdgeInsets.only(right: 20),
//                       decoration: const pw.BoxDecoration(
//                         border: pw.Border(
//                           bottom: pw.BorderSide(
//                               width: 1,
//                               color: PdfColors.black), // Line for signature
//                         ),
//                       ),
//                     ),
//                   ),
//                   pw.SizedBox(width: 200),
//                 ],
//               ),
//               pw.SizedBox(height: 10),
//               financialData.projectState == "تحويل"
//                   ? pw.Row(
//                       children: [
//                         pw.Text('التوجيه',
//                             style: pw.TextStyle(
//                                 font: arabicFont,
//                                 fontSize: 12,
//                                 fontWeight: pw.FontWeight.normal)),
//                         pw.SizedBox(width: 10),
//                         pw.Padding(
//                           padding: const pw.EdgeInsets.only(left: 30),
//                           child: pw.Container(
//                             height: 10, // Height of the line for signature
//                             width: 420, // Width of the line for signature
//                             margin: const pw.EdgeInsets.only(right: 20),
//                             decoration: const pw.BoxDecoration(
//                               border: pw.Border(
//                                 bottom: pw.BorderSide(
//                                     width: 1,
//                                     color:
//                                         PdfColors.black), // Line for signature
//                               ),
//                             ),
//                           ),
//                         ),
//                         pw.SizedBox(width: 200),
//                       ],
//                     )
//                   : pw.Container(),
//               pw.SizedBox(height: 20),

//               // add some cheak boxs
//               pw.Row(children: [
//                 pw.Checkbox(
//                     value: false, name: "فاتورة ضريبة", height: 15, width: 15),
//                 pw.SizedBox(width: 10),
//                 pw.Text(
//                   "فاتورة ضريبة",
//                   style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                 ),
//               ]),
//               pw.SizedBox(height: 8),
//               pw.Row(children: [
//                 pw.Checkbox(value: false, name: "عقد", height: 15, width: 15),
//                 pw.SizedBox(width: 10),
//                 pw.Text(
//                   "عقد",
//                   style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                 ),
//               ]),
//               pw.SizedBox(height: 8),
//               pw.Row(children: [
//                 pw.Checkbox(
//                     value: false, name: "ارسالية", height: 15, width: 15),
//                 pw.SizedBox(width: 8),
//                 pw.Text(
//                   "ارسالية",
//                   style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                 ),
//               ]),
//               pw.SizedBox(height: 8),
//               pw.Row(children: [
//                 pw.Checkbox(
//                     value: false, name: "عروض اسعار", height: 15, width: 15),
//                 pw.SizedBox(width: 8),
//                 pw.Text(
//                   "عروض اسعار",
//                   style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                 ),
//               ]),
//               pw.SizedBox(height: 8),
//               pw.Row(children: [
//                 pw.Checkbox(
//                     value: false, name: "محضر استلام", height: 15, width: 15),
//                 pw.SizedBox(width: 10),
//                 pw.Text(
//                   "محضر استلام",
//                   style: pw.TextStyle(font: arabicFont, fontSize: 12),
//                 ),
//               ]),
//             ],
//           ),
//         );
//       },
//     ),
//   );

//   // Save the PDF to a file on the desktop
//   final userHomeDir = Platform.environment['USERPROFILE'];
//   final desktopPath = path.join(
//       userHomeDir!,
//       "Desktop",
//       "reports",
//       "single-transaction",
//       "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
//   final reportDir = Directory(desktopPath);
//   if (!await reportDir.exists()) {
//     await reportDir.create(recursive: true);
//   }
//   // final output = await getApplicationDocumentsDirectory();
//   // final desktopPath = path.join(output.path, "..", "Desktop", "reports",
//   //     "single-transaction", "${now.year}-${now.month}-${now.day}");
//   // final reportDir = Directory(desktopPath);
//   // if (!await reportDir.exists()) {
//   //   await reportDir.create();
//   // }

//   final formattedDate =
//       '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}';
//   final file = File(path.join(reportDir.path, 'report-at-$formattedDate.pdf'));

//   await file.writeAsBytes(await pdf.save());
// }
