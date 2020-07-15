import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworking/Widgets/post.dart';
class PostScreen extends StatefulWidget {
  final String postId;
  final String userId;
  @override
  _PostScreenState createState() => _PostScreenState();
  PostScreen({this.postId,this.userId});
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.postId);
    print(widget.userId);
    return PickupLayout(
      currentUser: widget.currentUser,
      scaffold: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.clear),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text("Post",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Firestore.instance.collection('posts').document(widget.userId).collection('UsersPost').document(widget.postId).get(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          if(snapshot.hasError){
            return Container(
              child: Icon(Icons.error),
            );
          }
          return Post(
            postId: snapshot.data['postId'],
            username: snapshot.data['username'],
            ownerId: snapshot.data['ownerId'],
            mediaUrl: snapshot.data['mediaUrl'],
            location: snapshot.data['location'],
            likes: snapshot.data['likes'],
            description: snapshot.data['caption'],
          );
        },
      ),
    ),);
  }
}
