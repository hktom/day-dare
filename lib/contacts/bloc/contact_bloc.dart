// import 'dart:async';
// import 'package:application_challenge/contacts/data/contact_repository.dart';
// import 'package:application_challenge/contacts/data/contact_controller.dart';
// // import 'package:application_challenge/controller/contact/follow_contact.dart';
// import 'package:application_challenge/models/user_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:contacts_service/contacts_service.dart';
// // import 'package:contacts_service/contacts_service.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// part 'contact_event.dart';
// part 'contact_state.dart';

// class ContactBloc extends Bloc<ContactEvent, ContactState> {
//   ContactBloc()
//       : super(ContactState(contact: {
//           "local": [],
//           "synchronized": [],
//           "error": "",
//           "updating": false,
//           "followings": [],
//           "followers": [],
//           "loading": false,
//           "searching": false,
//           "filtering": false,
//           "search": "",
//           "users": [],
//           "results": [],
//         }));
//   ContactRepository contactRepository = ContactRepository();

//   @override
//   Stream<ContactState> mapEventToState(
//     ContactEvent event,
//   ) async* {
//     if (event is OnLoadingFollowings) {
//       yield ContactState(contact: {
//         ...state.contact,
//         "loading": true,
//       });
//       List? followings = await contactRepository.getFollowings(
//           currentUserId: event.currentUserId);
//       if (followings == null) {
//         yield ContactState(contact: {
//           ...state.contact,
//           "loading": false,
//           "error": "Erreur de chargement."
//         });
//         return;
//       }

//       yield ContactState(contact: {
//         ...state.contact,
//         "followings": followings,
//         "loading": false,
//       });
//     }
//     if (event is AddFollower) {
//       bool data = await contactRepository.addFollower(
//           currentUser: event.currentUser,
//           contactId: event.contactId,
//           currentUserId: event.currentUserId);

//       if (data == false) {
//         yield ContactState(contact: {
//           ...state.contact,
//           "error": "Erreur lors de liaison follower"
//         });
//         return;
//       }
//     }

//     if (event is AddFollowing) {
//       bool data = await contactRepository.addFollowing(
//           contact: event.contact,
//           contactId: event.contactId,
//           currentUserId: event.currentUserId);

//       if (data == false) {
//         yield ContactState(contact: {
//           ...state.contact,
//           "error": "Erreur lors de liaison follower"
//         });
//         return;
//       }
//     }

//     if (event is OnLoadingContact) {
//       yield ContactState(
//         contact: {
//           ...state.contact,
//           "updating": true,
//         },
//       );
//       List<Contact>? contacts;
//       List<dynamic>? synchronized;

//       contacts = await getContacts();
//       // contacts = state.contact["local"];
//       if (contacts == false) {
//         yield ContactState(
//           contact: {
//             ...state.contact,
//             "error": "Erreur lors de la recuperation des contacts",
//           },
//         );
//         return;
//       }
//       yield ContactState(
//         contact: {
//           ...state.contact,
//           "local": contacts,
//         },
//       );
//       print('local contact $contacts');
//       // yield ContactState(
//       //   contact: {
//       //     ...state.contact,
//       //     "updating": false,
//       //   },
//       // );

//       List? users = await contactRepository.getUsers();
//       if (users == null) {
//         yield ContactState(
//           contact: {
//             ...state.contact,
//             "error":
//                 "Un problème est survenu, veuillez verifier votre connexion",
//             "updating": false,
//           },
//         );
//         return;
//       }

//       synchronized =
//           await getSynchronizedContact(contactList: contacts, users: users);

//       yield ContactState(
//         contact: {
//           ...state.contact,
//           "synchronized": synchronized,
//           "error": "",
//           "updating": false,
//         },
//       );
//     }

//     if (event is OnSearchFieldChange) {
//       yield ContactState(
//           contact: {...state.contact, "search": event.text, 'filtering': true});
//       List? _results =
//           _filterByTagName(users: state.contact["users"], tagName: event.text);
//       yield ContactState(contact: {
//         ...state.contact,
//         'results': _results ?? [],
//         'filtering': false
//       });
//     }

//     if (event is OnSearchStarting) {
//       yield ContactState(contact: {
//         ...state.contact,
//         "searching": true,
//       });

//       List? _users = await contactRepository.getUsers();
//       if (_users == null) {
//         yield ContactState(contact: {
//           ...state.contact,
//           "error": "Erreur lors du chargement...",
//         });
//         return;
//       }
//       yield ContactState(contact: {
//         ...state.contact,
//         "users": _users,
//       });
//     }

//     // if (event is OnSearchingByTagName) {
//     //   List? _results = _filterByTagName(
//     //       users: state.contact["users"], tagName: event.tagName);
//     //   yield ContactState(
//     //       contact: {...state.contact, 'results': _results ?? []});
//     // }
//   }
// }

// List? _filterByTagName({required List users, required String tagName}) {
//   List? _results = users
//       .where((user) =>
//           user["displayName"].toLowerCase().contains(tagName.toLowerCase()))
//       .toList();
//   return _results;
// }
