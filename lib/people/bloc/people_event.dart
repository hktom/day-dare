part of 'people_bloc.dart';

class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List get props => [];
}

class GetPeoples extends PeopleEvent {
  GetPeoples();

  @override
  List get props => [];
}

class GetFollowings extends PeopleEvent {
  final Map user;
  GetFollowings({required this.user});

  @override
  List get props => [user];
}

class ResetPeoples extends PeopleEvent {
  ResetPeoples();

  @override
  List get props => [];
}

class SearchPeoples extends PeopleEvent {
  final String payload;
  SearchPeoples({required this.payload});

  @override
  List get props => [payload];
}

class ToggleInvitation extends PeopleEvent {
  final Map? payload;
  final bool? toggle;
  ToggleInvitation({this.payload, this.toggle});

  @override
  List get props => [payload, toggle];
}

class ToggleFollow extends PeopleEvent {
  final String docId;
  final Map user;
  final Map doc;
  final bool toogle;

  ToggleFollow(
      {required this.user,
      required this.docId,
      required this.toogle,
      required this.doc});

  @override
  List get props => [docId, user, toogle, doc];
}

class SeeProfile extends PeopleEvent {
  final Map? people;

  SeeProfile({required this.people});

  @override
  List get props => [people];
}
