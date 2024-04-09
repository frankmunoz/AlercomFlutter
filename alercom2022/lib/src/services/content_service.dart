import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/models/models.dart';


class ContentService extends ChangeNotifier {
  final List<Content> contents = [];
  late Content selectedContent;

  bool isLoading = true;
  bool isSaving = false;
  int id = 0;
  ContentService() {
    this.loadContents();
  }

  Future<List<Content>> loadContents() async {
    String endpoint = '/api/v1/section/contents';



    this.isLoading = true;
    notifyListeners();
    RequestService service = new RequestService();

    http.Response response = await service.get(endpoint);
    List<dynamic> contentsList = service.getCollection(response);

    contentsList.forEach((content) {
      final contentRow = Content.fromMap( content );
      this.contents.add( contentRow );
    });

    this.isLoading = false;
    notifyListeners();

    return this.contents;

  }

  Future<List<Content>> loadContentsBySection(section) async {
    String endpoint = '/api/v1/section/{$section}/contents';



    this.isLoading = true;
    notifyListeners();
    RequestService service = new RequestService();

    http.Response response = await service.get(endpoint);
    List<dynamic> contentsList = service.getCollection(response);

    contentsList.forEach((content) {
      final contentRow = Content.fromMap( content );
      this.contents.add( contentRow );
    });

    this.isLoading = false;
    notifyListeners();

    return this.contents;

  }




}