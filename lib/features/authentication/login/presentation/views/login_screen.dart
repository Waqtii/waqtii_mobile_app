import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/components/default_button.dart';
import 'package:waqtii/features/authentication/forget_password/presentation/views/forget_password_screen.dart';
import 'package:waqtii/features/authentication/login/presentation/login_cubit/cubit.dart';
import 'package:waqtii/core/components/default_form.dart';
import 'package:waqtii/features/authentication/login/presentation/login_cubit/states.dart';
import 'package:waqtii/features/authentication/register/presentation/views/register_monitor_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/views/register_user_screen.dart';
import 'package:waqtii/features/to_do/presentation/views/home.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false);
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/backgroundImage.png',
                      ),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Text('Login',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w900)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Please Sign in to Continue',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultForm(
                        isPassword: false,
                        controller: emailcontroller,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        preIcon: Icons.email_outlined,
                        validate: ((value) {
                          if (value!.isEmpty) {
                            return 'Email Must not be Empty';
                          }
                          return null;
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultForm(
                        suffix: LoginCubit.get(context).suffixIcon,
                        suffixPressed: () {
                          LoginCubit.get(context).changePassVis();
                        },
                        isPassword: LoginCubit.get(context).isPass,
                        submit: (value) {
                          if (formkey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailcontroller.text,
                                password: passcontroller.text);
                          }
                        },
                        controller: passcontroller,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        preIcon: Icons.lock_outline,
                        validate: ((value) {
                          if (value!.isEmpty) {
                            return 'Password Must not be Empty';
                          }
                          return null;
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) => DefaultButton(
                            color: Color(0xfffab94f),
                            text: 'LOGIN',
                            width: 150,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailcontroller.text,
                                    password: passcontroller.text);
                              }
                            },
                          ),
                          fallback: (BuildContext context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: AlignmentDirectional.center,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgetPassSreen(),
                                    ));
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: Color(0xfffab94f),
                                    fontWeight: FontWeight.bold),
                              ))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.24,
                      ),
                      Column(
                        children: [
                          Text("Don't have an Account?"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterUserScreen(),
                                        ));
                                  },
                                  child: Text(
                                    'SignUp as User',
                                    style: TextStyle(
                                        color: Color(0xfffab94f),
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterMonitorScreen(),
                                        ));
                                  },
                                  child: Text(
                                    'SignUp as Monitor',
                                    style: TextStyle(
                                        color: Color(0xfffab94f),
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
