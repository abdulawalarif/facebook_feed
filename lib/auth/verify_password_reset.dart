import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../routes/routes_name.dart';

class VerifyPasswordReset extends StatefulWidget {
  const VerifyPasswordReset({Key? key}) : super(key: key);

  @override
  State<VerifyPasswordReset> createState() => _VerifyPasswordResetState();
}

class _VerifyPasswordResetState extends State<VerifyPasswordReset> {
  var otp = '';
  bool authenticationLoadingOnOTPSent = false;

  @override
  void initState() {
    super.initState();
    authenticationLoadingOnOTPSent = false;
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Password Reset',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter the code in the below boxes',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,

                showCursor: true,
                // onCompleted: (pin) => print(pin),
                onChanged: (pin) {
                  otp = pin;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),),),
                    onPressed: () async {
                      if (otp.isEmpty || otp.length < 6) {
                        snackBar(
                            'Please enter the 6 digit code we sent on your email',
                            context,);
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RoutesName.changePassword, (route) => false,);
                      }
                    },
                    child: const Text('Confirm'),),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Edit Phone Number or username?',
                        style: TextStyle(color: Colors.black),
                      ),),
                ],
              )
            ,],
          ),
        ),
      ),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
