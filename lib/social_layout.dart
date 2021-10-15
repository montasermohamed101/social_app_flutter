import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/components.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/styles/iconbroken.dart';

import 'modules/new_post/new_post_screen.dart';

class SocialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context,state)
    {
      if(state is SocialNewPostState)
        {
          navigateTo(context, NewPostScreen());
        }
    },
      builder: (context,state)
      {

        var cubit = SocialCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title:Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(icon: Icon(IconBroken.bell),
                onPressed: (){}
              ),
              IconButton(icon: Icon(IconBroken.search_1),
                onPressed: (){}
                ),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon:
              Icon(
               IconBroken.home_1,
              ),
              label: 'Home'
              ),
              BottomNavigationBarItem(
                icon:
              Icon(
               IconBroken.chat_empty
              ),
                  label: 'Chat'),
              BottomNavigationBarItem(
                icon:
              Icon(
               IconBroken.paper_plane_empty
              ),
                  label: 'Post'),
              BottomNavigationBarItem(
                icon:
              Icon(
               IconBroken.users
              ),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                icon:
              Icon(
               IconBroken.cog
              ),
                  label: 'Settings'),

            ],
          ),
        );
      },
    );
  }
}
