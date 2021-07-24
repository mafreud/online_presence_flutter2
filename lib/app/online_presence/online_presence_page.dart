import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_presence_flutter2/app/color/custom_colors.dart';
import 'package:online_presence_flutter2/app/online_presence/online_presence_page_view_model.dart';
import 'package:online_presence_flutter2/app/welcome/welcome_page.dart';

class OnlinePresencePage extends ConsumerWidget {
  const OnlinePresencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(onlinePresencePageViewModelProvider);
    viewModel.updateUserPresence();
    return Scaffold(
      backgroundColor: CustomColors.navy,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await viewModel.signOut();
            await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
                (route) => false);
          },
        ),
        title: Text('ユーザーリスト'),
        backgroundColor: CustomColors.navy,
      ),
      body: _UserList(),
    );
  }
}

class _UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final userList = snapshot.data!.docs;

          return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final userData = userList[index];
                return _UserCard(
                  isOnline: userData['isOnline'],
                  displayName: userData['id'],
                  lastSeen: userData['lastSeen'],
                );
              });
        });
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({
    Key? key,
    required this.isOnline,
    required this.displayName,
    required this.lastSeen,
  }) : super(key: key);
  final bool isOnline;
  final String displayName;
  final int lastSeen;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        tileColor: CustomColors.navy,
        leading: Container(
          height: double.infinity,
          child: CircleAvatar(
            backgroundColor:
                isOnline ? CustomColors.onlineGreen : CustomColors.offlineGrey,
            radius: 7,
          ),
        ),
        title: Text(
          displayName,
          style: TextStyle(
              color: CustomColors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        trailing: Text(
          isOnline ? 'オンライン' : 'オフライン',
          style: TextStyle(
            color: isOnline ? CustomColors.onlineGreen : CustomColors.grey,
          ),
        ),
      ),
    );
  }
}
