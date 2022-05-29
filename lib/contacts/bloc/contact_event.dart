// part of 'contact_bloc.dart';

// abstract class ContactEvent extends Equatable {
//   const ContactEvent();

//   @override
//   List get props => [];
// }

// // class OnSynchronizedContact extends ContactEvent {}

// class OnLoadingContact extends ContactEvent {
//   final String? currentUserId;
//   OnLoadingContact({this.currentUserId});

//   @override
//   List get props => [currentUserId];
// }

// class AddFollower extends ContactEvent {
//   final String contactId;
//   final Map currentUser;
//   final String currentUserId;
//   AddFollower(
//       {required this.currentUser,
//       required this.currentUserId,
//       required this.contactId});

//   @override
//   List get props => [currentUser, contactId, currentUserId];
// }

// class AddFollowing extends ContactEvent {
//   final String contactId;
//   final Map contact;
//   final String currentUserId;
//   AddFollowing(
//       {required this.contact,
//       required this.currentUserId,
//       required this.contactId});

//   @override
//   List get props => [contact, contactId, currentUserId];
// }

// class OnLoadingFollowings extends ContactEvent {
//   final String currentUserId;
//   OnLoadingFollowings({required this.currentUserId});

//   @override
//   List get props => [currentUserId];
// }

// class OnSearchFieldChange extends ContactEvent {
//   final String text;
//   OnSearchFieldChange({required this.text});
//   @override
//   List get props => [text];
// }

// class OnSearchStarting extends ContactEvent {}

// // class OnSearchingByTagName extends ContactEvent {
// //   final String tagName;
// //   OnSearchingByTagName({required this.tagName});
// //   @override
// //   List get props => [tagName];
// // }
