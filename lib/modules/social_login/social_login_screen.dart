import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/components.dart';
import 'package:social_app/modules/social_login/cubit/cubit.dart';
import 'package:social_app/modules/social_login/cubit/states.dart';
import 'package:social_app/modules/social_register/social_register_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/social_layout.dart';


class SocialLoginScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState)
          {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
            ).then((value)
            {
              navigateAndFinish(
                  context,
                  SocialLayout());
            });
          }
        },
        builder: (context,state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Please Enter You Email Address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix:  SocialLoginCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            if(formkey.currentState.validate())
                            {
                              //  SocialLoginCubit.get(context).userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text
                              // );
                            }
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Password is to short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(

                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: ()
                            {
                              if(formkey.currentState.validate())
                              {
                                 SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SocialRegisterScreen(),);
                                },
                                text: 'register')
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
      ),


    );
  }
}
