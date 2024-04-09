import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/services/auth_service.dart';
import 'package:alercom/src/ui/input_decoration_ui.dart';
import 'package:alercom/src/providers/login_form_provider.dart';

class LoginScreen extends StatelessWidget {

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
                    Text('Ingreso', style: Theme.of(context).textTheme.headline4,),
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
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final authService = Provider.of<AuthService>(context, listen: false);
                  final String? response = await authService.loginAnonymous(context);
                  if(response == 'success'){
                    Navigator.pushReplacementNamed(context, 'home');
                  }

                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all( StadiumBorder() ),
                ),
                child: Text('Reportar como anónimo', style: TextStyle(fontSize: 18, color: Colors.purple, decoration: TextDecoration.underline,),),
              ),
              TextButton(
                onPressed: ()=>Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all( StadiumBorder() ),
                ),
                child: Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, color: Colors.black87),),
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
  var _passwordMinLength = 7;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorationUI.authInputDecoration(
                labelText: 'Usuario',
                hintText: '',
                prefixIcon: Icons.account_circle,
              ),
              onChanged: ( value ) => loginForm.username = value,
              validator: ( value ){
                String pattern = r'^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Usuario no válido';
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
              validator: ( value ){
                  return ( value != null && value.length >= _passwordMinLength)
                  ? null
                      :'La contraseña debe tener al menos:\n$_passwordMinLength caracteres,\nuna mayúscula,\nuna minúscula, \nun dígito  y un caracter especial';
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
                  ? 'Ingresando'
                  : 'Ingresar',
                  style: TextStyle( color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading ? null: () async {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                if(!loginForm.isValidForm()) return;
                loginForm.isLoading = true;
                print(loginForm.email);
                final String? response = await authService.login(context,loginForm.username,loginForm.password);
                  if(response == 'success'){
                    Navigator.pushReplacementNamed(context, 'home');
                  }

                loginForm.isLoading = false;
              }
            )
          ],
        ),
      ),
    );
  }
}
