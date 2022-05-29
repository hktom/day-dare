import 'package:application_challenge/authentification/data/authentification_repository.dart';
import 'package:application_challenge/bloc.dart';
import 'package:application_challenge/people/data/people_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc() : super(PeopleState());
  PeopleRepository peopleRepository = PeopleRepository();

  @override
  Stream<PeopleState> mapEventToState(PeopleEvent event) async* {
    PeopleState peopleState = new PeopleState(
        people: state.people,
        peoples: state.peoples,
        peoplesOnSearch: state.peoplesOnSearch,
        followers: state.followers,
        challenges: state.challenges,
        followings: state.followings,
        toogleFollow: state.toogleFollow,
        groupe: state.groupe);

    if (event is GetFollowings) {
      List? followings = await peopleRepository.getFollowings(event.user['id']);
      yield peopleState.copyWith(followings: followings);
    }

    if (event is SeeProfile) {
      yield peopleState.copyWith(people: event.people);
      List? followers =
          await peopleRepository.getFollowers(event.people!['id']);

      List? followings =
          await peopleRepository.getFollowings(event.people!['id']);

      List? challlenges =
          await peopleRepository.getChallenges(event.people!['id']);

      yield peopleState.copyWith(
        challenges: challlenges,
        people: event.people,
        followers: followers,
        followings: followings,
        toogleFollow: null,
      );
    }

    if (event is SearchPeoples) {}

    if (event is ToggleInvitation) {
      if (event.payload == null) {
        yield peopleState.copyWith(groupe: []);
        return;
      }

      if (state.groupe == null) {
        yield peopleState.copyWith(groupe: [event.payload]);
        return;
      }

      if (event.toggle!) {
        yield peopleState.copyWith(groupe: [...state.groupe!, event.payload]);
      } else {
        yield peopleState.copyWith(
            groupe: state.groupe!
                .where((element) => element['id'] != event.payload!['id'])
                .toList());
      }
    }

    if (event is GetPeoples) {
      List? peoples = await peopleRepository.getPeoples();
      if (peoples != null && peoples.isNotEmpty)
        yield peopleState.copyWith(peoples: peoples);
    }

    if (event is ToggleFollow) {
      yield peopleState.copyWith(toogleFollow: event.toogle);

      await peopleRepository.toggleFollow(
        docId: event.docId,
        user: event.user,
      );

      await peopleRepository.toggleFollowing(
        docId: event.user['id'],
        user: event.doc,
      );
    }
  }
}
