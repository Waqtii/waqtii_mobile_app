import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/components/default_button.dart';
import 'package:waqtii/core/components/default_form.dart';
import 'package:waqtii/features/authentication/forget_password/presentation/views/forget_password_screen.dart';
import 'package:waqtii/features/authentication/login/presentation/login_cubit/cubit.dart';
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
    var width = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false);
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
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
                      ConditionalBuilder(
                        condition: MediaQuery.of(context).size.height > 510,
                        builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        fallback: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                      ),
                      const Text('Login',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w900)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      const Text('Please Sign in to Continue',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      defaultForm(
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
                        height: MediaQuery.of(context).size.height * 0.026,
                      ),
                      defaultForm(
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
                          return null;
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
                        height: MediaQuery.of(context).size.height * 0.026,
                      ),
                      ConditionalBuilder(
                        condition: MediaQuery.of(context).size.height < 570,
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgetPassSreen(),
                                      ));
                                },
                                child: const FittedBox(
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        color: Color(0xfffab94f),
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (BuildContext context) => defaultButton(
                                color: const Color(0xfffab94f),
                                text: 'LOGIN',
                                width: MediaQuery.of(context).size.width * 0.4,
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailcontroller.text,
                                        password: passcontroller.text);
                                  }
                                },
                              ),
                              fallback: (BuildContext context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                        fallback: (context) => Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (BuildContext context) => defaultButton(
                              color: const Color(0xfffab94f),
                              text: 'LOGIN',
                              width: MediaQuery.of(context).size.width * 0.4,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailcontroller.text,
                                      password: passcontroller.text);
                                }
                              },
                            ),
                            fallback: (BuildContext context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      ConditionalBuilder(
                          condition: MediaQuery.of(context).size.height >= 570,
                          builder: (context) => Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.026,
                                  ),
                                  Align(
                                      alignment: AlignmentDirectional.center,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgetPassSreen(),
                                                ));
                                          },
                                          child: const FittedBox(
                                            child: Text(
                                              "Forget Password?",
                                              style: TextStyle(
                                                  color: Color(0xfffab94f),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))),
                                ],
                              ),
                          fallback: null),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ConditionalBuilder(
                                condition:
                                    MediaQuery.of(context).size.height >= 590,
                                builder: (context) => const FittedBox(
                                    child: Text("Don't have an Account?")),
                                fallback: null),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      child: const Text(
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
                                      child: const Text(
                                        'SignUp as Monitor',
                                        style: TextStyle(
                                            color: Color(0xfffab94f),
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
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
