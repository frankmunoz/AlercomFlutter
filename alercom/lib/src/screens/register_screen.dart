import 'package:flutter/material.dart';

import 'package:alercom/src/providers/login_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:alercom/src/services/services.dart';

import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/ui/input_decoration_ui.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 160,),
              // Solid text as fill.
              Text(
                'ALERCOM',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(height: 20,),
              AuthCardContainer(
                child:  Column(
                  children: [
                    SizedBox( height: 10,),
                    Text('Registro de usuario', style: Theme.of(context).textTheme.headline4,),
                    SizedBox(height: 30,),
                    ChangeNotifierProvider(
                        create: ( _ ) => LoginFormProvider(),
                        child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              TextButton(
                onPressed: ()=>Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all( StadiumBorder() ),
                ),
                child: Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.black87),),
              ),
              SizedBox(height: 50,),
            ],
          ),
        )
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
/*
      'user': {
        'username': 'narino_lider21',
        'email': email, [OK]
        'first_name': 'Armando',
        'last_name': 'Problemas',
        'password1': password, [OK]
        'password2': password
      },
      'partner':1,
      'role': 1
* */
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    var _passwordMinLength = 7;
    return Container(
      child: Form(
        key: loginForm.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
/*            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorationUI.authInputDecoration(
                labelText: 'Nombre',
                hintText: '',
                prefixIcon: Icons.account_circle,
              ),
              onChanged: ( value ) => loginForm.first_name = value,
              validator: ( value ){
                String pattern = r'^(?=[a-zA-Z ]{2,30}$)(?!.*[ ]{2})[^_.].*[^_.]$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Nnombre no válido';
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorationUI.authInputDecoration(
                labelText: 'Apellido',
                hintText: '',
                prefixIcon: Icons.account_circle,
              ),
              onChanged: ( value ) => loginForm.last_name = value,
              validator: ( value ){
                String pattern = r'^(?=[a-zA-Z ]{2,30}$)(?!.*[ ]{2})[^_.].*[^_.]$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Apellido ni válido';
              },
            ),*/
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorationUI.authInputDecoration(
                labelText: 'Nombre de usuario',
                hintText: '',
                prefixIcon: Icons.account_circle,
              ),
              onChanged: ( value ) => loginForm.username = value,
              validator: ( value ){
                String pattern = r'^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'No es un nombre de usuario válido';
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorationUI.authInputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'jon.snow@gmail.com',
                prefixIcon: Icons.alternate_email_sharp,
              ),
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value ){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'No es un correo válido';
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorationUI.authInputDecoration(
                labelText: 'Clave',
                hintText: '**********',
                prefixIcon: Icons.lock_clock_outlined,
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ) {
                String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&/*~]).{8,}$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    :'La contraseña de tener al menos:\n$_passwordMinLength caracteres,\nuna mayúscula,\nuna minúscula, \nun dígito  y un caracter especial';
              },

            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorationUI.authInputDecoration(
                labelText: 'Confirmar Clave',
                hintText: '**********',
                prefixIcon: Icons.lock_clock_outlined,
              ),
//              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ){
                return ( value != null && loginForm.password == value)
                    ? null
                    :'Las contraseñas deben coincidir';
              },
            ),
            SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.purple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Creando cuenta'
                  : 'Crear cuenta',
                  style: TextStyle( color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading ? null: () async {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                if(!loginForm.isValidForm()) return;
                loginForm.isLoading = true;
                print(loginForm.email);
                final String? response = await authService.createUser(context,
                    loginForm.email,
                    loginForm.password,
                    loginForm.username
                ).then((response){
                  if(response == 'success'){
                    Navigator.pushReplacementNamed(context, 'login');
                  }
                });

                loginForm.isLoading = false;
              }
            )
          ],
        ),
      ),
    );
  }
}
