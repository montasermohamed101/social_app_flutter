import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/components/components.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/iconbroken.dart';

class FeedsScreen extends StatelessWidget {

  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0,),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-vector/web-development-programmer-engineering-coding-website-augmented-reality-interface-screens-developer-project-engineer-programming-software-application-design-cartoon-illustration_107791-3863.jpg'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.blue
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) =>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder:(context,index) => SizedBox(
                    height: 10.0,
                  ) ,
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                ),

              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model ,context,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                              height:1.0
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption.copyWith(
                          height: 1.4
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon:Icon(Icons.more_horiz,
                  size: 20.0,
                ),
                onPressed: (){

                },
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //       bottom: 10.0,
          //       top: 5.0
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               height: 20.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                   '#software',
          //                   style: Theme.of(context).textTheme.caption.copyWith(
          //                       color: defaultColor,
          //                       fontSize: 14.0
          //                   )
          //               ),),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               height: 20.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                   '#flutter',
          //                   style: Theme.of(context).textTheme.caption.copyWith(
          //                       color: defaultColor,
          //                       fontSize: 14.0
          //                   )
          //               ),),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Container(
              height: 140.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0,),
                image: DecorationImage(
                  image: NetworkImage(
                      '${model.postImage}',
                  ),
                  fit: BoxFit.fill,

                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.heart_empty,
                            size: 18.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.comment_empty,
                            size: 18.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0,),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel.image}',
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            height: 1.4,
                            fontSize: 14.0
                        ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {

                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.heart_empty,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
  // void show( BuildContext context, int index)
  // {
  //  showModalBottomSheet(
  //      context: context,
  //      builder: (context)
  //      {
  //        return Column(
  //          children: [
  //            Row(
  //              children: [
  //                CircleAvatar(
  //                  radius: 16.0,
  //                  backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image}'),
  //                ),
  //                SizedBox(
  //                  width: 5.0,
  //                ),
  //                TextFormField(
  //                  keyboardType: TextInputType.text,
  //                  validator: (value){},
  //                  onFieldSubmitted: (value)
  //                  {
  //                    SocialCubit.get(context).createNewComment(commentController.text,
  //                        SocialCubit.get(context).postsId[index]);
  //                  },
  //                  controller: commentController,
  //                  decoration: InputDecoration(
  //                    fillColor: Colors.white,
  //                    filled: true,
  //                    focusColor: Colors.blue,
  //                    border: OutlineInputBorder(
  //                      borderRadius: BorderRadius.all(
  //                        Radius.circular(90.0),
  //                      ),
  //                      borderSide: BorderSide.none,
  //                    ),
  //                    hintText: 'write your comment ...',
  //                    hintStyle: TextStyle(color: Colors.blue,),
  //                  ),
  //                ),
  //                Conditional.single(
  //                    context: context,
  //                    conditionBuilder: (context) => SocialCubit.get(context).comments.length >0 ,
  //                    widgetBuilder: (context)
  //                    {
  //                      return ListView.separated(
  //                        shrinkWrap: true,
  //                          itemBuilder: (context,index) {
  //                           return buildCommentItem(SocialCubit.get(context).comments[index],context);
  //                          },
  //                          separatorBuilder: (context,index) => Container(height: 1,width: double.infinity,),
  //                          itemCount: SocialCubit.get(context).comments.length);
  //                    },
  //                    fallbackBuilder: (context) => Center(child: Text('No Comments')))
  //              ],
  //            ),
  //          ],
  //        );
  //      }
  //  );
  // }


}
