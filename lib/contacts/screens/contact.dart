// import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
// import 'package:application_challenge/contacts/bloc/contact_bloc.dart';
// import 'package:application_challenge/contacts/data/contact_controller.dart';
// import 'package:application_challenge/contacts/screens/views/contact_item.dart';
// import 'package:application_challenge/widgets/header/header_without_return_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../bloc.dart';

// class Contacts extends StatefulWidget {
//   Contacts({Key? key}) : super(key: key);

//   @override
//   _ContactsState createState() => _ContactsState();
// }

// class _ContactsState extends State<Contacts>
//     with AutomaticKeepAliveClientMixin {
//   final _formKey = GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     getFollowings();
//     getSuggestions();
//   }

//   getFollowings() {
//     BlocProvider.of<ContactBloc>(context).add(OnLoadingFollowings(
//         currentUserId: authentificationBloc(context).state.user!.email!));
//   }

//   getSuggestions() {
//     BlocProvider.of<ContactBloc>(context).add(OnLoadingContact());
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: _appBar(_formKey),
//       body: SingleChildScrollView(
//         child: BlocBuilder<ContactBloc, ContactState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 Flex(
//                   direction: Axis.vertical,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   textDirection: TextDirection.ltr,
//                   children: <Widget>[
//                     _head(context),
//                     state.contact["updating"] || state.contact["loading"]
//                         ? Center(child: Center(child: updateLoader()))
//                         : _contactData(context)
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// PreferredSize _appBar(formKey) {
//   return PreferredSize(
//     preferredSize: Size.fromHeight(60),
//     child: HeaderWithoutBackButton(
//       titleScreen: 'Suggestions',
//       key: formKey,
//       isCustom: true,
//       customAction: SizedBox(),
//     ),
//   );
// }

// Widget _head(context) {
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Text(
//         'Vos contacts utilisant ChallengeApp',
//         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//               color: Colors.blueGrey,
//               fontSize: 16,
//               fontWeight: FontWeight.w900,
//             ),
//       ),
//     ),
//   );
// }

// Widget _contactData(context) {
//   return BlocBuilder<ContactBloc, ContactState>(
//     builder: (context, state) {
//       // var localContact = state.contact["local"];
//       var synchronizedContact = state.contact["synchronized"];
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: synchronizedContact.length == 0
//             ? Column(
//                 children: [
//                   Center(
//                     child: Text(
//                       'Pas de contacts utilisant ChallengeApp',
//                       style: Theme.of(context).textTheme.bodyText1,
//                     ),
//                   ),
//                   _shareButton(context),
//                 ],
//               )
//             : Column(
//                 children: [
//                   _contactList(context, contactList: synchronizedContact),
//                   _shareButton(context),
//                 ],
//               ),
//       );
//     },
//   );
// }

// Widget updateLoader() {
//   return Container(
//     height: 40,
//     width: 40,
//     child: _secondaryLoader(),
//   );
// }

// Widget _secondaryLoader() {
//   return Container(
//     width: 30,
//     height: 30,
//     child: CircularProgressIndicator(
//       color: Colors.blue,
//       strokeWidth: 2,
//     ),
//   );
// }

// Widget _shareButton(context) {
//   return ListTile(
//     horizontalTitleGap: 5,
//     contentPadding: EdgeInsets.symmetric(horizontal: 5),
//     onTap: () => onShareApp(context),
//     leading: Icon(
//       Icons.share,
//       color: Colors.blueGrey,
//       size: 18,
//     ),
//     title: Text('Inviter des amis'),
//     subtitle: SizedBox(
//       height: 19,
//     ),
//   );
// }

// Widget _contactList(BuildContext context, {List? contactList}) {
//   return Flex(
//     direction: Axis.vertical,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: contactList!.map<Widget>((contact) {
//       return ContactItem(contact: contact);
//     }).toList(),
//   );
// }
