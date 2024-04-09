import 'package:alercom/src/models/affected_range.dart';
//import 'package:alercom/src/screens/gmap/place_map.dart';
import 'package:flutter/material.dart';

import 'package:alercom/src/providers/providers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/models/models.dart';

import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/utils/globals_util.dart';

class MarkScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    final category = categoryService.selectedCategory;


    return Scaffold(
        appBar: AppBarWidget(
            title: 'Yo reporto',
            icon: Globals.reportIcon,
            onTapAction: ()=>Navigator.pushReplacementNamed(context, 'place'),
        ),
        backgroundColor: Colors.white,
        body: buildSingleChildScrollView(category),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: buildFloatingActionButton(),

    );
  }

  SingleChildScrollView buildSingleChildScrollView(Category category) {
    return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              // Solid text as fill.
              Text("Registro " + category.name, style: TextStyle(color: Globals.backgroundColor, fontWeight: FontWeight.w800, fontSize: 20),),
              Divider(height: 20,),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(category.description, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 12,),
                ),
              ),
              SizedBox( height: 20 ),
              AuthCardContainer(
                child:  Column(
                  children: [
                    ChangeNotifierProvider(
                      create: ( _ ) => MarkFormProvider(),
                      child: _MarkForm(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50,),
            ],
          ),
        );
  }

  Column buildFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Symbol
        SizedBox( height: 100,),
        FloatingActionButton(
            child: new IconTheme(
              data: new IconThemeData(
                  color:  Globals.fontColor
              ),
              child: new Icon(Icons.camera_alt),
            ),
            backgroundColor: Globals.backgroundColor,
            onPressed: () async{


            }
        ),
        SizedBox( height: 5,),
        // ZoomIn
        FloatingActionButton(
            child: new IconTheme(
              data: new IconThemeData(
                  color:  Globals.fontColor
              ),
              child: new Icon(Icons.location_on),
            ),
            backgroundColor: Globals.backgroundColor,
            onPressed: (){
              final center = LatLng(4.816179, -74.070894);
              GoogleMap(
                onTap: (LatLng latLng) {
                  final lat = latLng.latitude;
                  final long = latLng.longitude;
                  print("HOLA" + lat.toString());
                },
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 11.0,
                ),
              );

            }
        ),
        SizedBox( height: 5,),

      ],
    );
  }
}

class _MarkForm extends StatefulWidget{
  MarkFormBody createState()=> MarkFormBody();
}

class MarkFormBody extends State<_MarkForm>{

  TextEditingController _inputFieldDataController = new TextEditingController();
  String _dateHappened = '';

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    final category = categoryService.selectedCategory;
    final markForm = Provider.of<MarkFormProvider>(context);
    final storage = new FlutterSecureStorage();
    markForm.category = category.id;
    markForm.location = category.location;
    markForm.person = 2;//await _getPerson(storage);
    return Container(
      child: Form(
        key: markForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            SizedBox( height: 10 ),
            _buildInputWhatHappend(markForm),
            SizedBox( height: 10 ),
            _buildWhenHappend(context, markForm),
            SizedBox( height: 10 ),
            _buildInputWhereHappend(markForm),
            SizedBox( height: 10 ),

            Text("Afectó a: ", style: TextStyle(color: Colors.black54),),
            AffectedType(markForm),
            SizedBox( height: 10 ),

            Text("Número de afectaciones: ", style: TextStyle(color: Colors.black54),),
            SizedBox( height: 10 ),
            AffectedRange(markForm),
            SizedBox( height: 10 ),

            //_buildAffectedRange(markForm),
            //SizedBox( height: 10 ),

            _buildInputObservations(markForm),
            SizedBox(height: 30,),

            buildMaterialButton(markForm, context),
            SizedBox( height: 10 ),
          //  PlaceMap(center: LatLng(45.521563, -122.677433)),

          ],
        ),
      ),
    );
  }


  MaterialButton buildMaterialButton(MarkFormProvider markForm,BuildContext context)  {
  //Future<MaterialButton> buildMaterialButton(MarkFormProvider markForm, BuildContext context) async {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Globals.backgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          markForm.isLoading
              ? 'Guardando Formulario...'
              : 'Enviar formulario',
          style: TextStyle( color: Colors.white),
        ),
      ),
      onPressed: (){
        markForm.isLoading = true;
        showAlertDialog(context, markForm);
      },
      /*
      onPressed: markForm.isLoading ? null: () async {
        FocusScope.of(context).unfocus();
        final markService = Provider.of<MarkService>(context, listen: false);
        if(!markForm.isValidForm()) return;
        markForm.isLoading = true;
        final String? response = await markService.createMark(context,
            markForm.person,
            markForm.category,
            markForm.location,
            markForm.name,
            markForm.whenHappend,
            markForm.whereHappend,
            markForm.affectedsRange,
            markForm.affectedTo,
            markForm.observations,
            markForm.lat,
            markForm.lon,
            markForm.photo
        ).then((response){
          if(response == 'success'){
            Navigator.pushReplacementNamed(context, 'place');
          }
        });

        markForm.isLoading = false;
      }*/
    );
  }


  showAlertDialog(BuildContext context, MarkFormProvider markForm) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed:  ()=>Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: Text("Continuar"),
      onPressed:  markForm.isLoading ? null: () async {
        Navigator.of(context).pop(context);
        FocusScope.of(context).unfocus();
        final markService = Provider.of<MarkService>(context, listen: false);
        if(!markForm.isValidForm()) return;
        final String? response = await markService.createMark(context,
            markForm.person,
            markForm.category,
            markForm.location,
            markForm.name,
            markForm.whenHappend,
            markForm.whereHappend,
            markForm.affectedsRange,
            markForm.affectedTo,
            markForm.observations,
            markForm.lat,
            markForm.lon,
            markForm.photo
        ).then((response){
          if(response == 'success'){
            //Navigator.pushReplacementNamed(context, 'place');
          }
        });
        markForm.isLoading = false;
      }
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmación"),
      content: Text("¿Está seguro de enviar la información? Esta información se enviará una vez este dispositivo tenga acceso a internet"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Widget _buildInputWhatHappend(MarkFormProvider markForm){
    return TextFormField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor,
              width: 2
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),

        ),
        hintText: 'Describa la situación',
        labelText:  '¿Qué ocurrió?',
        helperText:  'Este campo es obligatorio',
        suffixIcon: Icon(Icons.connect_without_contact, color: Globals.backgroundColor,),
        icon: Icon(Icons.circle_notifications, color: Globals.backgroundColor,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onChanged: ( value ) => markForm.name = value,

    );
  }


  Widget _buildWhenHappend(BuildContext context, MarkFormProvider markForm){
    print(markForm.whenHappend);
    return TextFormField(
      controller: _inputFieldDataController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor,
              width: 2
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),

        ),
        hintText: 'Seleccione la fecha del evento',
        labelText:  '¿Cuándo ocurrió?',
        helperText:  'Este campo es obligatorio',
        suffixIcon: Icon(Icons.event_outlined, color: Globals.backgroundColor,),
        icon: Icon(Icons.event, color: Globals.backgroundColor,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate( context, markForm );
      },
      onChanged: ( value ) => markForm.whenHappend = _dateHappened,

    );
  }


  _selectDate(BuildContext context, MarkFormProvider markForm) async{
    DateTime now = new DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: new DateTime(now.year, now.month, now.day-7),
      lastDate: new DateTime(now.year,now.month,now.day),
      locale: Locale('es', 'ES'),
      builder: (context, child) {
        return Theme(
          child: child!,
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Globals.backgroundColor,
            ),
          ),
        );
      },
    );

    if(picked != null){
      _dateHappened = picked.toString();
      _inputFieldDataController.text = _dateHappened;
      markForm.whenHappend = _dateHappened;
    }
  }


  Widget _buildInputWhereHappend(MarkFormProvider markForm){
    return TextFormField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor,
              width: 2
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),

        ),
        hintText: 'Describa el lugar exacto, vereda, corregimiento, barrio',
        labelText:  '¿Dónde ocurrió?',
        helperText:  'Este campo es obligatorio',
        suffixIcon: Icon(Icons.explore_outlined, color: Globals.backgroundColor,),
        icon: Icon(Icons.edit_location, color: Globals.backgroundColor,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onChanged: ( value ) => markForm.whereHappend = value,

    );
  }

  Widget _buildInputObservations(MarkFormProvider markForm){
    return TextField(
      //autofocus: true,
      maxLines: 8,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Globals.backgroundColor,
              width: 2
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),

        ),
        hintText: 'Opcional: Deje su teléfono de contacto',
        labelText:  'Información adicional',
        suffix: Icon(Icons.phone_outlined, color: Globals.backgroundColor,),
        icon: Icon(Icons.edit_notifications , color: Globals.backgroundColor,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onChanged: ( value ) => markForm.observations = value,

    );
  }

}
