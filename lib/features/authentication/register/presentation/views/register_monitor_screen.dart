import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/components/default_button.dart';
import 'package:waqtii/core/components/default_form.dart';
import 'package:waqtii/features/authentication/login/presentation/views/login_screen.dart';
import 'package:waqtii/features/authentication/register/presentation/register_cubit/cubit.dart';
import 'package:waqtii/features/authentication/register/presentation/register_cubit/states.dart';

class RegisterMonitorScreen extends StatelessWidget {
  RegisterMonitorScreen({super.key});

  var namecontroller = TextEditingController();
  var usernamecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var likedincontroller = TextEditingController();
  var gitgubcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false,
        );
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
                      condition: MediaQuery.of(context).size.height > 750,
                      builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      fallback: null,
                    ),
                    const FittedBox(
                      child: Text('Create Monitor Account',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ConditionalBuilder(
                      condition: MediaQuery.of(context).size.height > 675,
                      builder: (context) => Column(
                        children: [
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
                            controller: usernamecontroller,
                            type: TextInputType.name,
                            label: 'User Name',
                            preIcon: Icons.person,
                            validate: ((value) {
                              if (value!.isEmpty) {
                                return 'userName Must not be Empty';
                              }
                              return null;
                            }),
                          ),
                        ],
                      ),
                      fallback: (context) => Row(
                        children: [
                          Expanded(
                            child: defaultForm(
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Expanded(
                            child: defaultForm(
                              suffixIconColor: Colors.grey,
                              prefixIconColor: Colors.grey,
                              labelColor: Colors.grey,
                              focusColor: Colors.grey,
                              focusedBorderColor: Colors.grey,
                              controller: usernamecontroller,
                              type: TextInputType.name,
                              label: 'User Name',
                              preIcon: Icons.person,
                              validate: ((value) {
                                if (value!.isEmpty) {
                                  return 'userName Must not be Empty';
                                }
                                return null;
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.026,
                    ),
                    defaultForm(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
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
                    defaultForm(
                      controller: likedincontroller,
                      type: TextInputType.text,
                      label: 'LinkedIn Link',
                      preIcon: Icons.link,
                      validate: ((value) {
                        if (value!.isEmpty) {
                          return 'this field Must not be Empty';
                        }
                        return null;
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.026,
                    ),
                    defaultForm(
                      controller: gitgubcontroller,
                      type: TextInputType.text,
                      label: 'GitHub Link',
                      preIcon: Icons.link,
                      validate: ((value) {
                        if (value!.isEmpty) {
                          return 'this field Must not be Empty';
                        }
                        return null;
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.026,
                    ),
                    ConditionalBuilder(
                        condition: state is! RegisterMonitorLoadingState,
                        builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton(
                                  hint: const FittedBox(
                                      child: Text('Choose Gender')),
                                  items: ["Male", "Female"]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    RegisterCubit.get(context)
                                        .changeGender(val);
                                  },
                                  value:
                                      RegisterCubit.get(context).selectedGender,
                                ),
                                defaultButton(
                                  color: const Color(0xfffab94f),
                                  text: 'Sign Up',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      RegisterCubit.get(context)
                                          .monitorRegister(
                                        email: emailcontroller.text,
                                        fullName: namecontroller.text,
                                        gender: RegisterCubit.get(context)
                                            .selectedGender,
                                        password: passcontroller.text,
                                        phoneNumber: phonecontroller.text,
                                        userName: usernamecontroller.text,
                                        github: gitgubcontroller.text,
                                        linkedin: likedincontroller.text,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator())),
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
