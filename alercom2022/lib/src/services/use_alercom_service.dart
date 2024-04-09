import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/models/models.dart';


class UseAlercomService extends ChangeNotifier {
  final List<Section> sections = [];
  late Section selectedContent;

  bool isLoading = true;
  bool isSaving = false;

  UseAlercomService() {
    this.loadContents();
  }

  Future<List<Section>> loadContents() async {
    String endpoint = '/api/v1/module/2/sections';

    this.isLoading = true;
    notifyListeners();
    RequestService service = new RequestService();

    http.Response response = await service.get(endpoint);
    List<dynamic> sectionsList = service.getCollection(response);

    sectionsList.forEach((section) {
      final contentRow = Section.fromMap( section );
      this.sections.add( contentRow );
    });

    this.isLoading = false;
    notifyListeners();
    return this.sections;

  }




}