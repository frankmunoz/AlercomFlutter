import 'package:alercom/src/services/auth_service.dart';
import 'package:alercom/src/services/profile_service.dart';
import 'package:alercom/src/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:alercom/src/utils/utils.dart';
import 'package:alercom/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false );

    final Singleton singleton = Singleton();
    String username = authService.getProfileValuesByKey('username');
    String name = authService.getProfileValuesByKey('firstName');
    String lastName = authService.getProfileValuesByKey('lastName');
    String email = authService.getProfileValuesByKey('email');
    String contact = authService.getProfileValuesByKey('contact');
    return Scaffold(
        appBar: AppBarWidget(title: 'Mi perfil', icon: Globals.profileIcon, onTapAction: ()=>Navigator.of(context).pop(),),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            _nickname(username, authService),
            const SizedBox(height: 10,),
            _name(name),
            const SizedBox(height: 10,),
            _lastname(lastName),
            const SizedBox(height: 10,),
            _email(email),
            const SizedBox(height: 10,),
            _contact(contact),
            const SizedBox(height: 10,),
            buildMaterialButton(context, singleton),
            const SizedBox(
              height: 50.0,
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ));
  }

  Widget _nickname(String? username, AuthService authService) {
    _usernameController.text = username!;
    return TextFormField(
      controller: _usernameController,
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        hintText: 'Nombre de Usuario',
        labelText: 'Nombre de Usuario',
        helperText: 'Este campo es obligatorio',
        suffixIcon: Icon(
          Icons.supervised_user_circle_outlined,
          color: backgroundColor,
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (value) => _usernameController.text = value
    );
  }

  Widget _email(String? email) {
    _emailController.text = email!;
    return TextFormField(
      controller: _emailController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        hintText: 'Correo Electronico',
        labelText: 'Correo Electronico',
        helperText: 'Este campo es obligatorio',
        suffixIcon: Icon(
          Icons.alternate_email,
          color: backgroundColor,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (value) => _emailController.text = value
    );
  }

  Widget _name(String? name) {
    _firstNameController.text = name!;
    return TextFormField(
      controller: _firstNameController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        hintText: 'Nombre',
        labelText: 'Nombre',
        helperText: 'Este campo es obligatorio',
        suffixIcon: Icon(
          Icons.assignment_ind_rounded,
          color: backgroundColor,
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (value) =>  _firstNameController.text = value
    );
  }

  Widget _lastname(String? lastName) {
    _lastNameController.text = lastName!;
    return TextFormField(
        controller: _lastNameController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        hintText: 'Apellido',
        labelText: 'Apellido',
        helperText: 'Este campo es obligatorio',
        suffixIcon: Icon(
          Icons.assignment_ind_rounded,
          color: backgroundColor,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (value) => _lastNameController.text = value
    );
  }

  Widget _contact(String? contact) {
    _contactController.text = contact!;
    return TextFormField(
        controller: _contactController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          hintText: 'En caso de perdida',
          labelText: 'Datos de Contacto',
          helperText: '',
          suffixIcon: Icon(
            Icons.assignment_ind_rounded,
            color: backgroundColor,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        onChanged: (value) => _contactController.text = value
    );
  }

  MaterialButton buildMaterialButton(BuildContext context, Singleton singleton)  {
    _usernameController.addListener(() { _usernameController.text;});
    _firstNameController.addListener(() { _firstNameController.text;});
    _lastNameController.addListener(() { _lastNameController.text;});
    _emailController.addListener(() { _emailController.text;});
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: const Text(
          "Actualizar Información",
          style: TextStyle( color: Colors.white),
        ),
      ),
      onPressed: () async {
        final profileService = Provider.of<ProfileService>(context, listen: false);
        final String? response = await profileService.updateUser(
            context,
            singleton.token,
            singleton.userId,
            _emailController.text,
            _usernameController.text,
            _firstNameController.text,
            _lastNameController.text
        ).then((response){
          if(response == 'success'){
          }
        });

      },
    );
  }
}
