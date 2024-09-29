import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:facebook_feed/routes/routes_name.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController _phoneOrEmailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneOrEmailController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Find Your Account'),
      ),
      body:   Column(
        children: [
          Form(
            key: _formKey,
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val){
                      if(val?.isEmpty??true){
                        return 'Enter email or phone';
                      }else{
                        return null;
                      }
                    },
                      controller: _phoneOrEmailController,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,

                      ),

                      decoration: const InputDecoration(
                        label:   Text('Phone or email'),
                        hintText: 'Phone or email',
                        labelStyle: TextStyle(
                          color: Colors.black54, // Text color
                          fontWeight:
                          FontWeight.w400, // Text weight (bold)
                        ),

                      ),
                      onEditingComplete: () => searchForUserOnDatabase(),

                  ),
                ),
              ],
            ),
          ),
          Gap(3.h),
          Center(
            child: SizedBox(
                width: 80.w,
                child: Text('Please enter your phone number or email to search for your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                   fontWeight: FontWeight.w500,

                ),),),
          ),
        ],
      ),
    );
  }
  void searchForUserOnDatabase(){
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();
    if (isValid) {
      popUpMenu();
    }
  }

  void popUpMenu() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.green,
              ),
              SizedBox(width: 10),
              Text('Reset Password'),
            ],
          ),
          content:const Text('Please check your email a 6 digits code is send on your email, for resetting password'),
          actions: [
            TextButton(
              onPressed: () async{
              Navigator.of(context).pushNamed(RoutesName.verifyPasswordReset);// Close the dialog
                // Call the provided callback when 'Yes' is pressed
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
