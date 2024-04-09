
import 'dart:collection';

import 'package:alercom/src/models/content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


import 'package:alercom/src/providers/login_form_provider.dart';
import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/ui/input_decoration_ui.dart';
import '../screens.dart';

import 'package:alercom/src/utils/utils.dart';

class ContentScreen extends StatelessWidget {
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;


  @override
  Widget build(BuildContext context) {
    final sectionService = Provider.of<SectionService>(context);
    if(sectionService.isLoading) return LoadingScreen();

    final contentService = Provider.of<ContentService>(context);
    if(contentService.isLoading) return LoadingScreen();


    List<Tab> tabs = [];
    List<Widget> tabsContent = [];
    List<Map<int, dynamic>> contentMap =[];
    var sectionLength = sectionService.sections.length;
    var contentLength = contentService.contents.length;


    for (int i = 0; i < sectionLength; i++) {
      var sectionId = sectionService.sections[i].id;
      for (int j = 0; j < contentLength; j++) {
        if(sectionId == contentService.contents[j].section){
          print(contentService.contents[j].name);
          contentMap.add({sectionId: contentService.contents[j]});
        }
      }
    }

    for (int i = 0; i < sectionLength; i++) {
      var sectionId = sectionService.sections[i].id;
      tabs.add(Tab(
        child: Text(
          sectionService.sections[i].name,
          style: TextStyle(color: Colors.white),
        ),
      ));

      if(containsKey(contentMap,sectionId) ){
        tabsContent.add(
            buildListView(getContentBySectionId(contentMap, sectionId))
        );
      }else{
        tabsContent.add(
            buildVoidListView()
        );
      }
    }

    return DefaultTabController(
        length: sectionService.sections.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              bottom: TabBar(
                isScrollable: true,
                tabs: tabs,
              ),
              iconTheme: IconThemeData(color: fontColor),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Image.asset(Globals.dataProtectionIcon , fit: BoxFit.cover, height: 50,),
                  Text(
                      'Protección de datos',
                      style: TextStyle(color: fontColor)
                  ),
                ],
              ),

              elevation: 2.0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      /*Colors.black54,
              Colors.black87,
              Colors.black,
              backgroundColorLite,*/
                      Colors.transparent,
                      backgroundColor,
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.black,
          ),
          /*
          appBar: AppBarWidget(
              title: 'Protección de datos',
              icon: Globals.dataProtectionIcon,
              bottom:  TabBar(
                  isScrollable: true,
                  tabs: tabs,
                ),
          ),*/
        body: buildTabBarView(tabsContent),
      ),
    );
  }

  static bool containsKey(List<Map<int, dynamic>> contentMap, int sectionId) {
    bool found = false;
    contentMap.forEach((contentElement) {
      if(contentElement[sectionId] != null ) {
        found = true;
      }
    });
    return found;
  }

  List<Content> getContentBySectionId(List<Map<int, dynamic>> contentMap, sectionId) {
    List<Content> contents = [];
    contentMap.forEach((contentElement) {
      if(contentElement[sectionId] != null) {
        contents.add(contentElement[sectionId]);
      }
    });

    return contents;
  }


  TabBarView buildTabBarView(List<Widget> tabsContent) {
    return TabBarView(
      physics: BouncingScrollPhysics(),
      dragStartBehavior: DragStartBehavior.down,
      children: tabsContent,
      );
  }

  ListView buildTabsContent(ContentService contentService) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: contentService.contents.length,
        itemBuilder: ( BuildContext context, int index ) => GestureDetector(
          child: ContentCard(
            content: contentService.contents[index],
          ),
        )
    );
  }



  ListView buildListView(List<Content> contentService) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: contentService.length,
        itemBuilder: ( BuildContext context, int index ) => GestureDetector(
          child: ContentCard(
            content: contentService[index],
          ),
        )
    );
  }


  ListView buildVoidListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 0,
        itemBuilder: ( BuildContext context, int index ) => GestureDetector(
          child: null,
        )
    );
  }
}

