import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


import 'package:alercom/src/providers/login_form_provider.dart';
import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/ui/input_decoration_ui.dart';
import '../screens.dart';

import 'package:alercom/src/utils/utils.dart';

class CategoryScreen extends StatelessWidget {
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if(categoryService.isLoading) return LoadingScreen();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            title: 'Yo reporto',
            icon: Globals.reportIcon,
            onTapAction: ()=>Navigator.pushReplacementNamed(context, 'home'),

        ),
        body: ListView.builder(
            itemCount: categoryService.categories.length,
            itemBuilder: ( BuildContext context, int index ) => GestureDetector(
              onTap: () {
                categoryService.selectedCategory = categoryService.categories[index].copy();
                Navigator.pushNamed(context, 'location');
              },
              child: CategoryCard(
                category: categoryService.categories[index],
              ),
            )
        ),
    );
  }
}
