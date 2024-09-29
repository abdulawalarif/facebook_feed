import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:facebook_feed/routes/routes_name.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late FocusNode _fullNameNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordNode;
  late FocusNode _confirmPasswordNode;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _passwordIsVisibile = false;
  bool _confirmPasswordIsVisibile = false;
  bool _emailAlreadyExists = false;
  bool _isLoading = false;
  bool _fullNameTextHasFocus = false;
  bool _emailTextHasFocus = false;
  bool _passwordHasFocus = false;
  bool _confirmPasswordHasFocus = false;

  @override
  void initState() {
    super.initState();
    _fullNameNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();


    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    /// Full Name focus node listener
    _fullNameNode.addListener(() {
      if (_fullNameNode.hasFocus) {
        _fullNameTextHasFocus = true;
      } else {
        _fullNameTextHasFocus = false;
      }
      setState(() {});
    });
    /// Email focus node listener
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        _emailTextHasFocus = true;
      } else {
        _emailTextHasFocus = false;
      }
      setState(() {});
    });

    /// Password focus node listener
    _passwordNode.addListener(() {
      if (_passwordNode.hasFocus) {
        _passwordHasFocus = true;
      } else {
        _passwordHasFocus = false;
      }
      setState(() {});
    });

    /// Confirm Password focus node listener
    _confirmPasswordNode.addListener(() {
      if (_confirmPasswordNode.hasFocus) {
        _confirmPasswordHasFocus = true;
      } else {
        _confirmPasswordHasFocus = false;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _passwordNode.dispose();
    _emailFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Change Password',
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Password TextFormField
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextFormField(
                  controller: _passwordController,
                  key: const ValueKey('Password'),
                  validator: (value) {
                    if (value!.isEmpty && value.length < 6) {
                      return 'Please enter a valid password';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 1,
                  focusNode: _passwordNode,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  //onEditingComplete: _submitForm,
                  obscureText: !_passwordIsVisibile,
                  decoration: InputDecoration(

                    contentPadding:  EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w), // Increase top and bottom padding
                    fillColor: Colors.white,
                    filled: true,
                    label: Text(
                      'Password',
                      style: TextStyle(
                          color: _passwordHasFocus
                              ? Colors.black
                              : Colors.black54),
                    ),
                    hintText: 'Enter your password',
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Set the border radius

                      borderSide:
                      const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Set the border radius

                      borderSide: const BorderSide(
                          color: Colors.black54, width: 1.0),
                    ),

                    suffix: SizedBox(
                      height: 32,
                      width: 28,
                      child: IconButton(
                        onPressed: () => setState(() =>
                        _passwordIsVisibile = !_passwordIsVisibile),
                        splashRadius: 18,
                        iconSize: 18,
                        icon: Icon(
                          _passwordIsVisibile
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_confirmPasswordNode),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextFormField(
                    controller: _confirmPasswordController,
                    key: const ValueKey('Password'),
                    validator: (value) {
                      if (value!.isEmpty && value.length < 6) {
                        return 'Please enter a valid password';
                      }
                      if(value!=_passwordController.text){
                        return 'Please enter a same password';
                      }

                      else {
                        return null;
                      }
                    },
                    maxLines: 1,
                    focusNode: _confirmPasswordNode,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    //onEditingComplete: _submitForm,
                    obscureText: !_confirmPasswordIsVisibile,
                    decoration: InputDecoration(
                      contentPadding:  EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w), // Increase top and bottom padding
                      fillColor: Colors.white,
                      filled: true,
                      label: Text(
                        'Confirm Password',
                        style: TextStyle(
                            color: _confirmPasswordHasFocus
                                ? Colors.black
                                : Colors.black54,),
                      ),
                      hintText: 'Enter password again',
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Set the border radius

                        borderSide:
                     const   BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Set the border radius

                        borderSide:const BorderSide(
                            color: Colors.black54, width: 1.0),
                      ),

                      suffix: SizedBox(
                        height: 32,
                        width: 28,
                        child: IconButton(
                          onPressed: () => setState(() =>
                          _confirmPasswordIsVisibile = !_confirmPasswordIsVisibile),
                          splashRadius: 18,
                          iconSize: 18,
                          icon: Icon(
                            _confirmPasswordIsVisibile
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),
                    onEditingComplete: () => changePassword()
                ),
              ),
              Gap(2.h),
              GestureDetector(
                onTap: (){
                  changePassword();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 6.h,
                  width: 50.w,
                  child: const Center(child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void changePassword(){
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();
    setState(() => _emailAlreadyExists = false);
    if (isValid) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutesName.feedScreen, (route) => false);
    }
  }

}
