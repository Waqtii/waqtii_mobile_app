import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/components/default_button.dart';
import 'package:waqtii/core/components/default_form.dart';
import 'package:waqtii/core/components/toast.dart';
import 'package:waqtii/features/authentication/forget_password/presentation/forget_password_cubit/cubit.dart';
import 'package:waqtii/features/authentication/forget_password/presentation/forget_password_cubit/states.dart';
import 'package:waqtii/features/authentication/login/presentation/views/login_screen.dart';

class ForgetPassSreen extends StatelessWidget {
  ForgetPassSreen({Key? key}) : super(key: key);

  var emailcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (BuildContext context, state) {
          if (state is ForgetPasswordSuccessState) {
            Toastt(
              message: state.forgetPasswordModel.status,
              state: ToastStates.SUCCESS,
            );
          }
        },
        builder: (BuildContext context, Object? state) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Forget Password',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    'To reset your password, please enter your email address. You need to check your Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  DefaultForm(
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
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ConditionalBuilder(
                      condition: state is! ForgetPasswordLoadingState,
                      builder: (BuildContext context) => DefaultButton(
                        color: Color(0xfffab94f),
                        text: 'Send',
                        width: 150,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ForgetPasswordCubit.get(context).resetPassword(
                              email: emailcontroller.text,
                            );
                          }
                        },
                      ),
                      fallback: (BuildContext context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
