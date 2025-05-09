// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:edaray_applecation/core/helper_functions/show_error_bart.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../Feature/add_Financial/data/model/add_financial_model.dart';

class SharingData {
  static Future<List<AddFinancialModel>> importJson(
      BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        if (!(file.path.endsWith('.json'))) {
          throw Exception('Invalid file type. Please select a JSON file.');
        }
        final jsonString = await file.readAsString();
        final jsonList = jsonDecode(jsonString) as List;
        jsonList
            .map((json) => AddFinancialModel.fromJson(json))
            .toList()
            .forEach((element) {});
        return jsonList
            .map((json) => AddFinancialModel.fromJson(json))
            .toList();
      }
    } on Exception catch (e) {
      buildErrorBar(context, "يوجد خطا في الملف جاول مجداا\n ${e.toString()}");
    }
    return [];
  }

  static Future<void> exportJson(List<AddFinancialModel> data) async {
    final jsonList = data.map((model) => model.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    final userHomeDir = Platform.environment['USERPROFILE'];
    final desktopPath = path.join(
      userHomeDir!,
      'Desktop',
    );
    Directory directory = Directory(desktopPath);
    final file = File('${directory.path}/financial_data.json');
    await file.writeAsString(jsonString);
  }

  static Future<List<AddFinancialModel>> importExcel(
      BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      String filePath = '';
      if (result != null) {
        filePath = result.files.single.path!;
      }
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);

      List<AddFinancialModel> models = [];
      int i = 0;
      for (var table in excel.tables.keys) {
        final sheet = excel.tables[table]!;
        for (int i = 1; i < sheet.rows.length; i++) {
          // تجاهل الصف الأول (الرؤوس)
          final row = sheet.rows[i];

          models.add(
            AddFinancialModel(
              funantialNo: row[0]?.value.toString() ?? '',
              supplierName: row[1]?.value.toString() ?? '',
              price: row[2]?.value?.toString() ?? '',
              carance: row[3]?.value?.toString() ?? '',
              pillDate: DateTime.tryParse(row[4]?.value.toString() ?? '') ??
                  DateTime.now(),
              financialDate: DateTime.now(),
              projectType: row[5]?.value.toString() ?? '',
              projectState: row[6]?.value.toString() ?? '',
              category: row[7]?.value.toString() ?? '',
              note: row[8]?.value.toString() ?? '',
              editFinancialDate: DateTime.now(),
            ),
          );
        }
        print(models[i].toJson());
        i++;
      }
      return models;
    } catch (e) {
      buildErrorBar(context, "يوجد خطا في الملف جاول مجداا\n ${e.toString()}");
    }
    return [];
  }
}
