import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:facebook_feed/routes/routes_name.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late FocusNode _userNameNode;
  late FocusNode _passwordNode;
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _passwordIsVisibile = true;
  bool _passworVisibilityIcon = false;
  bool _wrongEmailorPassword = false;
  bool _isLoading = false;
  bool _emailTextHasFocus = false;
  bool _passwordHasFocus = false;
  bool showCrossIcons = false;

  @override
  void initState() {
    super.initState();
    _passwordNode = FocusNode();
    _userNameNode = FocusNode();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    /// Email focus node listener
    _userNameNode.addListener(() {
      if (_userNameNode.hasFocus) {
        _emailTextHasFocus = true;
        if (_userNameController.text.isNotEmpty) {
          showCrossIcons = true;
        }
      } else {
        _emailTextHasFocus = false;

        showCrossIcons = false;
      }
      setState(() {});
    });

    /// Password focus node listener
    _passwordNode.addListener(() {
      if (_passwordNode.hasFocus) {
        _passwordHasFocus = true;
        if (_passwordController.text.isNotEmpty) {
          setState(() {
            _passworVisibilityIcon = true;
          });
        } else {
          setState(() {
            _passworVisibilityIcon = false;
          });
        }
      } else {
        _passwordHasFocus = false;
        if (_passwordController.text.isNotEmpty) {
          setState(() {
            _passworVisibilityIcon = true;
          });
        } else {
          setState(() {
            _passworVisibilityIcon = false;
          });
        }
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _passwordNode.dispose();
    _userNameNode.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Container(
                  height: 65,
                  padding:const EdgeInsets.only(top: 14),
                  child: _wrongEmailorPassword
                      ? const Text(
                          'The email or password you entered did not match our records. Please double check and try again',
                          style: TextStyle(color: Colors.redAccent),
                        )
                      : null,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // username TextFormField

                      Container(
                        height: 8.h,
                        padding: EdgeInsets.only(
                            left: 2.w,
                            right: 2.w,
                            top: showCrossIcons ? 1.8.h : 0.3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                            color: _emailTextHasFocus
                                ? Colors.black
                                : Colors.black54,
                            width: 1.0, // Set the width of the border
                          ),
                        ),
                        child: Center(
                          child: TextFormField(
                            style: const TextStyle(
                              fontWeight: FontWeight
                                  .w600, // Set font weight for user-input text
                            ),
                            onChanged: (val) {
                              if (val.isEmpty ||
                                  val.length == 0 ||
                                  val == null ||
                                  val == "null") {
                                setState(() {
                                  showCrossIcons = false;
                                });
                              } else {
                                if (val.trim().isNotEmpty) {
                                  setState(() {
                                    showCrossIcons = true;
                                  });
                                }
                              }
                            },
                            maxLines: 1,
                            controller: _userNameController,
                            focusNode: _userNameNode,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12),
                              alignLabelWithHint: true,
                              suffix: showCrossIcons
                                  ? SizedBox(
                                      height: 32,
                                      width: 28,
                                      child: IconButton(
                                        onPressed: () {
                                          _userNameController.clear();
                                          setState(() {
                                            showCrossIcons = false;
                                          });
                                        },
                                        splashRadius: 18,
                                        color: Colors.black54,
                                        icon: const Icon(Icons.close),
                                      ),
                                    )
                                  : const SizedBox(),
                              fillColor: Colors.white,
                              filled: true,
                              label: Text(
                                'Mobile number or email',
                                style: TextStyle(
                                    color: _emailTextHasFocus
                                        ? Colors.black
                                        : Colors.black54,

                                    fontWeight: FontWeight.w400,),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordNode),
                          ),
                        ),
                      ),
                      Gap(2.h),
                      // Password TextFormField
                      Container(
                        height: 8.h,
                        padding: EdgeInsets.only(
                            left: 2.w,
                            right: 2.w,
                            top: _passworVisibilityIcon ? 1.8.h : 0.3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                            color: _passwordHasFocus
                                ? Colors.black
                                : Colors.black54,
                            width: 1.0, // Set the width of the border
                          ),
                        ),
                        child: Center(
                          child: TextFormField(
                            obscureText: _passwordIsVisibile,
                            style: const TextStyle(
                              fontWeight: FontWeight
                                  .w600, // Set font weight for user-input text
                            ),

                            onChanged: (val) {
                              if (val.isEmpty ||
                                  val.length == 0 ||
                                  val == null ||
                                  val == "null") {
                                setState(() {
                                  _passworVisibilityIcon = false;
                                });
                              } else {
                                if (val.isNotEmpty) {
                                  setState(() {
                                    _passworVisibilityIcon = true;
                                  });
                                }
                              }
                            },
                            maxLines: 1,
                            controller: _passwordController,
                            focusNode: _passwordNode,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12),
                              alignLabelWithHint: true,
                              suffix: _passworVisibilityIcon
                                  ? SizedBox(
                                      height: 32,
                                      width: 28,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordIsVisibile =
                                                !_passwordIsVisibile;
                                          });
                                        },
                                        splashRadius: 18,

                                        color: Colors.black54,
                                        icon: Icon(
                                          _passwordIsVisibile
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              fillColor: Colors.white,
                              filled: true,
                              label: Text(
                                'Password',
                                style: TextStyle(
                                    color: _passwordHasFocus
                                        ? Colors.black
                                        : Colors.black54,

                                    fontWeight: FontWeight.w400,),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            // onEditingComplete: () => FocusScope.of(context)
                            //     .requestFocus(_passwordNode),
                          ),
                        ),
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),

                      // Log in button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? () {} : onPressOfLoginButton,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text('Log In'),
                              ],),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RoutesName.forgotPassword);
                          },
                          child: const Text(
                            'Forgot password? ',
                            style: TextStyle(
                                color: Colors.black87,

                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child:const  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Expanded(child: Divider(thickness: 1)),
                      Text('  or   ',),
                        Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',

                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesName.registerScreen);
                        },
                        child: const Text('Sign up')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressOfLoginButton() {
    FocusScope.of(context).unfocus();
    if(_passwordController.text.isEmpty || _userNameController.text.isEmpty){

      if(_userNameController.text.isEmpty){
        FocusScope.of(context).requestFocus(_userNameNode);
       }else{
        if(_passwordController.text.isEmpty){
          FocusScope.of(context).requestFocus(_passwordNode);
         }
      }

      }else{


        Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutesName.feedScreen, (route) => false);


    }

  }
}
