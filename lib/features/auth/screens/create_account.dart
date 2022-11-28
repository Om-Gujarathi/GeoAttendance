import 'package:edi/constants/global_variables.dart';
import 'package:edi/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = '/create-account-screen';
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final AuthService authService = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _prnController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        id: _prnController.text);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight / 15,
                    bottom: screenHeight / 20,
                  ),
                  child: Text(
                    "CREATE ACCOUNT",
                    style: TextStyle(
                      fontSize: screenWidth / 18,
                      fontFamily: "NexaBold",
                    ),
                  ),
                ),
                Form(
                  key: _signUpFormKey,
                  child: Container(
                    alignment: Alignment.centerLeft,
                     margin: EdgeInsets.symmetric(
                      horizontal: screenWidth / 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldTitle('Name'),
                        customField("Enter your name", _nameController, false),
                        fieldTitle('PRN'),
                        customField("Enter your prn", _prnController, false),
                        fieldTitle('Email'),
                        customField("Enter your email id", _emailController, false),
                        fieldTitle('Password'),
                        customField("Enter your password", _passwordController, true),
                         GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();
          
                            if (email.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Employee id is still empty!"),
                              ));
                            } else if (password.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Password is still empty!"),
                              ));
                            } else {
                              signUpUser();
                            }
                          },
                          child: Container(
                            height: 60,
                            width: screenWidth,
                            margin: EdgeInsets.only(top: screenHeight / 40),
                            decoration: const BoxDecoration(
                              color: GlobalVariables.violetcolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Center(
                              child: Text(
                                "CREATE",
                                style: TextStyle(
                                  fontFamily: "NexaBold",
                                  fontSize: screenWidth / 26,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: "NexaBold",
        ),
      ),
    );
  }

  Widget customField(
      String hint, TextEditingController controller, bool obscure) {
    return Container(
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth / 6,
            child: Icon(
              Icons.person,
              color: GlobalVariables.violetcolor,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
                obscureText: obscure,
              ),
            ),
          )
        ],
      ),
    );
  }
}
