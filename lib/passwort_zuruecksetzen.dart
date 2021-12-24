import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class passwortvergessen extends StatefulWidget {
  const passwortvergessen({Key? key}) : super(key: key);

  @override
  _passwortvergessenState createState() => _passwortvergessenState();
}

class _passwortvergessenState extends State<passwortvergessen> {

  TextEditingController editController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,

        title: Text(
          'Health is Wealth',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),

            onPressed: () => Navigator.pop(context),
          ),
        ],




      ),
      body: Form(
        key: _key,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Login.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              )
          ),

          child: ListView(
              children: [

                Padding(
                  padding: const EdgeInsets.all(12.0),

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                        EdgeInsets.all(25.0),
                        child: Text(
                          'Welcome to Your Healthy Life',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black,
                              ),
                            ],
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Dieses Field kann nicht leer sein.';
                            } else if (!editController.text.contains("@") || !editController.text.contains(".")){
                              return 'E-mail muss in folgendes Form sein: username@---.---';
                            }
                            return null;
                          },

                          controller: editController,
                          style: TextStyle(
                            color: Colors.white,
                          ),

                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'E-mail',
                              labelStyle:
                              TextStyle(fontSize: 19.0, color: Colors.white),
                              hintText: 'E-Mail-Adresse wie z.B. (name@gmail.de)',
                              hintStyle: TextStyle(color: Colors.white),
                              filled: true),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            resetPassword(context);
                            if (_key.currentState!.validate()) {
                            }

                          },
                          child: Text(
                            'Zuruecksetzen',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),



                    ],
                  ),

                ),]
          ),
        ),
      ),

    );
  }
  void resetPassword(BuildContext context) async {
    if (editController.text.length == 0 || !editController.text.contains("@")||!editController.text.contains(".")) {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: "Falsches Format in der E-Mail Adresse");
      return null;
    }

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        msg:
        "Der Link zum Zuruecksetzen des Passworts wurde an Ihre E-Mail gesendet. Bitte verwenden Sie ihn, um das Passwort zu aendern.");

  }
}