import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';
import 'package:social_app/network/end_points.dart';
import 'package:social_app/network/remote/dio_helper.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);




  void userRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,
})
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      // print(value.user.email);
      // print(value.user.uid);
      userCreate(
        uId: value.user.uid,
        phone: phone,
        email: email,
        name: name,
      );
    }
    ).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });


  }

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
})
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      cover: 'https://image.freepik.com/free-vector/bedouins-walk-egypt-pyramids-camel-night-desert_107791-4619.jpg',
      image: 'https://image.freepik.com/free-photo/attractive-laughing-guy-having-fun-smiling-happy_176420-18839.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection('users')
        .doc(uId)
        .set(model.toMap()
    ).then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));

    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword= true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityStates());
  }




}