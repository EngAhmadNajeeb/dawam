import 'package:dawam/blocs/login_bloc.dart';
import 'package:dawam/utilities/app_colors.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = true;
  FocusNode? _usernameFocusNode;
  FocusNode? _passwordFocusNode;
  final LoginBloc _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _usernameFocusNode!.dispose();
    _passwordFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: AppColors.gradientColors),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        AppLocalizations.of(context)!.trans('AgriLogistics'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 4.0),
                              blurRadius: 5.0,
                              color: AppColors.amber,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Image.asset("assets/images/bg.png", scale: 5),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (phone) {
                        _bloc.username = phone;
                      },
                      onFieldSubmitted: (enteredUsername) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s"))
                      ],
                      focusNode: _usernameFocusNode,
                      cursorColor: AppColors.app,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.trans("username"),
                        hintStyle:
                            const TextStyle(fontSize: 13, color: AppColors.app),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.app)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    TextFormField(
                      onChanged: (password) {
                        _bloc.password = password;
                      },
                      cursorColor: AppColors.app,
                      focusNode: _passwordFocusNode,
                      obscureText: !_passwordVisible,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.trans("password"),
                        hintStyle:
                            const TextStyle(fontSize: 13, color: AppColors.app),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.app)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.amber,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      child: Text(
                        AppLocalizations.of(context)!.trans("forget_password"),
                        style:
                            const TextStyle(color: AppColors.black, fontSize: 12),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: AppColors.white,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w900),
                          primary: AppColors.app,
                        ),
                        onPressed: () {
                          _bloc.login(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.trans("sign_in"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!
                                      .trans("if_you_do_not_have_an_account") +
                                  " "),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .trans("sign_up"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.amber),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
