// //yandex задача на исправление ошибок
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:untitled/task_impl.dart';
//
// abstract class ProfileMetrica {
//   static void reportProfileBuildDone() {}
//   static void reportProfileBuildError() {}
// }
//
// abstract class ProfileApi {
//   Future<Profile> getProfile(String userId);
//   Future<List<Post>> getPostsForUser(String userId);
// }
//
// class ProfileState {
//   Profile? profile;
//   List<Post>? posts;
//   bool isLoading = false;
//   bool hasError = false;
// }
//
// class ProfileStateManager {
//   final String userId;
//   final ProfileApi api = ProfileApiImpl();
//   final stateController = StreamController<ProfileState>();
//   ProfileState state;
//   late final StreamSubscription stateSubscription;
//
//   ProfileStateManager(this.userId) : state = ProfileState() {
//     stateSubscription = stateController.stream.listen((state) {
//       this.state = state;
//     });
//   }
//
//   void load() async {
//     stateController.add(
//       state
//         ..isLoading = true
//         ..hasError = false,
//     );
//     try {
//       api.getProfile(userId).then(
//             (value) => stateController.add(state..profile = value),
//       );
//       api.getPostsForUser(userId).then(
//             (value) => stateController.add(state..posts = value),
//       );
//     } catch (e) {
//       stateController.add(
//         state..hasError = true,
//       );
//     } finally {
//       stateController.add(
//         state..isLoading = false,
//       );
//     }
//   }
//
//   void dispose() {
//     stateSubscription.cancel();
//   }
// }
//
// class ProfilePage extends StatelessWidget {
//   final String userId;
//
//   ProfilePage(this.userId);
//
//   late final stateManager = ProfileStateManager(userId);
//
//   @override
//   Widget build(BuildContext context) {
//     try {
//       return MaterialApp(
//         home: StreamBuilder(
//           initialData: stateManager.state,
//           stream: stateManager.stateController.stream.distinct(),
//           builder: (context, snapshot) {
//             final state = snapshot.data as ProfileState;
//             if (state.isLoading) {
//               return Container(
//                 width: MediaQuery.of(context).size.width / 2,
//                 height: MediaQuery.of(context).size.height / 2,
//                 alignment: Alignment.bottomRight,
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state.hasError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Error'),
//                 ),
//               );
//               throw Center(
//                 child: Text('Error'),
//               );
//             }
//             return Scaffold(
//               body: Column(
//                 children: [
//                   Text(state.profile!.name),
//                   Image.network(state.profile!.imageUrl),
//                   ...state.posts!.map(
//                         (post) {
//                       return ListTile(
//                         title: Text(post.title),
//                         subtitle: Text(post.body),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//       ProfileMetrica.reportProfileBuildDone();
//     } catch (e) {
//       ProfileMetrica.reportProfileBuildError();
//     }
//   }
// }
