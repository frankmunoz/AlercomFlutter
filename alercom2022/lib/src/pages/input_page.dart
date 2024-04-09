import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<InputPage> {
  TextEditingController _inputFieldDateController = new TextEditingController();
  String _nombre = '';
  String _email = '';
  String _fecha = '';
  String _password = '';
  String _opcionSeleccionada = 'Volar';
  List<String> _poderes = ['Volar', 'Rayos X', 'Super aliento', 'Super fuerza'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Form'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropDown(),
          Divider(),
          _crearPersona(),
        ],
      ),
    );
  }

  Widget _crearInput(){
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        counter: Text('Cantidad de letras ${ _nombre.length }'),
        hintText: 'Introduzca nombre',
        labelText:  'Nombre',
        helperText:  'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onChanged: (valor){
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _crearEmail(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText:  'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onChanged: (valor){
        setState(() {
          _email = valor;
        });
      },
    );
  }

  Widget _crearPassword(){
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Clave',
        labelText:  'Clave',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onChanged: (valor){
        setState(() {
          _password = valor;
        });
      },
    );
  }

  Widget _crearFecha(BuildContext){
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        hintText: 'Fecha de nacimiento',
        labelText:  'Fecha de nacimiento',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate( context );
      },
      onChanged: (valor){
        setState(() {
          _fecha = valor;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(){
    List<DropdownMenuItem<String>> lista = [];

    _poderes.forEach((poder) {
      lista.add(
        DropdownMenuItem(
          child: Text(poder),
          value: poder,
        )
      );
    });

    return lista;
  }
  //_inputFieldDataController = new TextEditingController();


  Widget _crearDropDown(){
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        DropdownButton(
          value: _opcionSeleccionada,
          items: getOpcionesDropdown(),
          onChanged: (opcion){
            setState(() {
              _opcionSeleccionada = opcion.toString();
            });
          },
        )
      ],
    );
  }

  _selectDate(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2021),
      lastDate: new DateTime(2022),
      locale: Locale('es', 'ES'),
    );

    if(picked != null){
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _crearPersona(){

    return ListTile(
      title: Text('Datos'),
      subtitle: Text(
        'Nombre: $_nombre\n'
        'Email es: $_email \n'
        'Fecha nacimiento: $_fecha'
      ),
      trailing: Text(_opcionSeleccionada),
    );
  }
}
