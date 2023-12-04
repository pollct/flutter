import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Login', style: Theme.of(context).textTheme.headlineLarge,),
                    const SizedBox(
                      height: 30,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm()
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text('Create an account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
            ],
          ),
        )
      )
    );
  }
}

class _LoginForm extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return SizedBox(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Incorrect email format'
                  ;
              },
            ),
            const SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 8) 
                  ? null
                  : 'Password lenght must be greater then 8 characters';
              },
            ),
            const SizedBox(height: 40),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromRGBO(13, 71, 161, 1),
              onPressed: loginForm.isLoading ? null : () async {
                final navigator = Navigator.of(context);
                FocusScope.of(context).unfocus();
                if(!loginForm.isValidForm()) return;
                loginForm.isLoading = true;
                await Future.delayed(const Duration(seconds: 2));
                loginForm.isLoading = false;
                navigator.pushReplacementNamed('home');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  loginForm.isLoading 
                  ? 'Please wait...'
                  : 'Login',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}