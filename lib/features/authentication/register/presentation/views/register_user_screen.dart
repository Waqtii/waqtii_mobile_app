import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/constants.dart';
import 'package:waqtii/core/components/default_button.dart';
import 'package:waqtii/core/components/default_form.dart';
import 'package:waqtii/core/components/dropdown.dart';
import 'package:waqtii/features/authentication/login/presentation/views/login_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/register_cubit/cubit.dart';
import 'package:waqtii/features/authentication/register/presentation/register_cubit/states.dart';

class RegisterUserScreen extends StatelessWidget {
  RegisterUserScreen({super.key});

  var namecontroller = TextEditingController();
  var usernamecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterUserSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) => Scaffold(
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
                      condition: MediaQuery.of(context).size.height > 700,
                      builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      fallback: null,
                    ),
                    const FittedBox(
                      child: Text('Create User Account',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    defaultForm(
                      controller: namecontroller,
                      type: TextInputType.name,
                      label: 'Full Name',
                      preIcon: Icons.person,
                      validate: ((value) {
                        if (value!.isEmpty) {
                          return 'Name Must not be Empty';
                        }
                        return null;
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.026,
                    ),
                    defaultForm(
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
                      suffix: RegisterCubit.get(context).suffixIcon,
                      suffixPressed: () {
                        RegisterCubit.get(context).changePassVis();
                      },
                      isPassword: RegisterCubit.get(context).isPass,
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
                    defaultForm(
                      controller: usernamecontroller,
                      type: TextInputType.name,
                      label: 'User Name',
                      preIcon: Icons.person,
                      validate: ((value) {
                        if (value!.isEmpty) {
                          return 'Name Must not be Empty';
                        }
                        return null;
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.026,
                    ),
                    defaultForm(
                      controller: phonecontroller,
                      type: TextInputType.phone,
                      label: 'Phone Number',
                      preIcon: Icons.phone,
                      validate: ((value) {
                        if (value!.isEmpty) {
                          return 'Phone Must not be Empty';
                        }
                        return null;
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.026,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: defaultDropDown(
                            context: context,
                            hint: 'Choose Gender',
                            items: ['male', 'female'],
                            onChanged: (value) {
                              RegisterCubit.get(context).changeGender(value);
                            },
                            validationText: 'please select gender.',
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterUserLoadingState,
                          builder: (BuildContext context) => defaultButton(
                            // color: const Color(0xfffab94f),
                            text: 'Sign Up',
                            width: MediaQuery.of(context).size.width * 0.4,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailcontroller.text,
                                  fullName: namecontroller.text,
                                  gender:
                                      RegisterCubit.get(context).selectedGender,
                                  password: passcontroller.text,
                                  phoneNumber: phonecontroller.text,
                                  userName: usernamecontroller.text,
                                );
                              }
                            },
                          ),
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an Account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Color(0xfffab94f),
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
