part of 'people_bloc.dart';

class PeopleState extends Equatable {
  final List? peoples;
  final Map? people;
  final List? peoplesOnSearch;
  final List? followers;
  final List? challenges;
  final List? followings;
  final List? groupe;
  final bool? toogleFollow;

  const PeopleState(
      {this.peoples,
      this.groupe,
      this.toogleFollow,
      this.challenges,
      this.people,
      this.peoplesOnSearch,
      this.followers,
      this.followings});

  PeopleState copyWith({
    List? groupe,
    List? peoples,
    List? followings,
    List? followers,
    List? challenges,
    List? peoplesOnSearch,
    Map? people,
    bool? toogleFollow,
  }) {
    return PeopleState(
        groupe: groupe ?? this.groupe,
        toogleFollow: toogleFollow,
        challenges: challenges ?? this.challenges,
        followings: followings ?? this.followings,
        followers: followers ?? this.followers,
        peoples: peoples ?? this.peoples,
        people: people ?? this.people,
        peoplesOnSearch: peoplesOnSearch ?? this.peoplesOnSearch);
  }

  @override
  List get props => [
        groupe,
        toogleFollow,
        challenges,
        peoples,
        people,
        peoplesOnSearch,
        followers,
        followings,
      ];
}
