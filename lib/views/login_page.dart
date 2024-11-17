import 'package:flutter/material.dart';
import 'package:new_login_screen/services/authentication_service.dart';
import 'package:new_login_screen/widgets/snack_bar_widget.dart';
import 'package:new_login_screen/widgets/text_field_widget.dart';

AuthenticationService _authService = AuthenticationService();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  // Controla se a senha é visível ou não
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsetsDirectional.all(10),
          child: Column(
            children: [
              // Image.asset("assets/tasks.png", width: 200, height: 200),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: decoration("E-mail"),
                        validator: (value) =>
                            requiredValidator(value, "o email"),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText, // Define se a senha será visível ou não
                        decoration: InputDecoration(
                          labelText: "Senha",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (value) =>
                            requiredValidator(value, "a senha"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              _authService
                                  .loginUser(email: email, password: password)
                                  .then((erro){
                                if (erro != null){
                                  snackBarWidget(context: context, title: erro, isError: true);
                                }
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login'),
                            ],
                          )),
                      TextButton(
                        child: const Text("Ainda não tem conta? Registre-se"),
                        onPressed: () {
                          Navigator.pushNamed(context, "/loginRegister");
                        },
                      )
                    ],
                  ))
            ],
          ),
        )));
  }
}
