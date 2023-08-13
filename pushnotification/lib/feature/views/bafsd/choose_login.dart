import 'package:flutter/material.dart';

class ChooseLogin extends StatefulWidget {
  const ChooseLogin({Key? key}) : super(key: key);

  @override
  State<ChooseLogin> createState() => _ChooseLoginState();
}

class _ChooseLoginState extends State<ChooseLogin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/image/bg_pattern.png')
          ),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/school_logo.png',height: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Education-restraint-Discipline'),
            )
            
          ],
        ),
      ),
    );
  }
}
