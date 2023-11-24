import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/common/colors.dart';
import 'package:radio_app/features/auth/views/view_sign_in/bloc/sign_in_bloc.dart';
import 'package:radio_app/routes/app_route.dart';

@RoutePage()
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocBuilder<AuthBloc, SignInState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      alignment: Alignment.topRight,
                      image: AssetImage("assets/images/microphone.png"),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: tittleColor, fontSize: 24),
                        ),
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: MaterialButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SignInEvent(
                                emailController.text, passwordController.text));
                            context.router.push(HomeRoute());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          color: buttonColor,
                          minWidth: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: containerColor),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(color: textButtonColor),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't haven't an account ?",
                                style: TextStyle(color: textButtonColorLight),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.router.push(SignUpRoute());
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: buttonColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
