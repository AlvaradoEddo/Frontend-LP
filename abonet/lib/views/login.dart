import 'package:abonet/models/login_model.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  late LoginRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Text(
                              "Inicia Sesión",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            new TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) => requestModel.email = input!,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'No puede estar vacio';
                                }
                                if (!text.contains("@")) {
                                  return 'No ingreso un correo válido';
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                  hintText: "Correo electrónico",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor),
                                  ),
                                  prefixIcon: Icon(Icons.email,
                                      color: Theme.of(context).accentColor)),
                            ),
                            SizedBox(height: 20),
                            new TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (input) =>
                                  requestModel.password = input!,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'No puede estar vacio';
                                }
                                if (text.length < 3) {
                                  return 'Contraseña muy corta';
                                }
                                return null;
                              },
                              obscureText: hidePassword,
                              decoration: new InputDecoration(
                                  hintText: "Contraseña",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.2)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor),
                                  ),
                                  prefixIcon: Icon(Icons.lock,
                                      color: Theme.of(context).accentColor),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    icon: Icon(
                                        hidePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.2)),
                                  )),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (validateAndSave()) {
                                  Navigator.pushNamed(context, '/home');
                                }
                              },
                              child: Text("Iniciar Sesión"),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                  primary: Theme.of(context)
                                      .primaryColor, // background
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  minimumSize:
                                      const Size.fromHeight(50) // foreground
                                  ),
                            ),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
