import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/models/models.dart';


class ReportService extends ChangeNotifier {

  final List<Report> reports = [];
  late Report selectedReport;

  bool isLoading = true;
  bool isSaving = false;
  String location = "150";
  final storage = new FlutterSecureStorage();
  List<Map<String, dynamic>> _items = [];

  ReportService(String location) {
    this.loadReports(location);
  }

  Future<List<Report>> loadReports(String location) async {
    String endpoint = 'api/v1/location/$location/marks';
    notifyListeners();
    this.isLoading = true;
    RequestService service = new RequestService();

    http.Response response = await service.get(endpoint);
    List<dynamic> categoriesList = service.getCollection(response);

    categoriesList.forEach((category) {
      final categoryRow = Report.fromMap( category );
      this.reports.add( categoryRow );
      print(category);
    });

    this.isLoading = false;
    notifyListeners();

    return this.reports;
  }
}