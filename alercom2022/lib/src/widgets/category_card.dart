import 'package:flutter/material.dart';

import 'package:alercom/src/models/category.dart';
import 'package:alercom/src/utils/utils.dart';

class CategoryCard extends StatelessWidget {

  final Category category;

  const CategoryCard({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Globals.backgroundColor;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: EdgeInsets.only( top: 30, bottom: 30 ),
        width: double.infinity,
        height: 250,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _CategoryDetails(
              title: category.name,
              subTitle: category.description,
            ),
            Positioned(
                top: 110,
                right: 20,
                child: Icon(Icons.arrow_forward_ios, color: backgroundColor,)
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
            color: Colors.black12,
            offset: Offset(0,7),
            blurRadius: 10
        )
      ]
  );
}

class _CategoryDetails extends StatelessWidget {

  final String title;
  final String subTitle;

  const _CategoryDetails({
    required this.title,
    required this.subTitle
  });


  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Globals.backgroundColor;
    Color fontColor = Globals.fontColor;

    return Padding(
      padding: EdgeInsets.only( right: 50 ),
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
        width: double.infinity,
        height: 370,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle( fontSize: 20, color: fontColor, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style: TextStyle( fontSize: 15, color: Colors.white ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Color.fromRGBO(148, 32, 131, 1),
      borderRadius: BorderRadius.only( bottomLeft: Radius.circular(25), topRight: Radius.circular(25) )
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage( this.url );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
            ? Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover
        )
            : FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}