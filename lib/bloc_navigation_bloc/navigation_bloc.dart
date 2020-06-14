import 'package:bloc/bloc.dart';
import 'package:brtbus/Pages/news/news.dart';
import 'package:brtbus/Pages/routes/routes.dart';
import 'package:brtbus/Pages/settings/about.dart';
import 'package:brtbus/Pages/map/map.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  RoutesPageClickedEvent,
  NewsPageClickedEvent,
  AboutPageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => MyHomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield MyHomePage();
        break;
      case NavigationEvents.AboutPageClickedEvent:
        yield AboutPage();
        break;

      case NavigationEvents.RoutesPageClickedEvent:
        yield RoutesPage();
        break;
      case NavigationEvents.NewsPageClickedEvent:
        yield NewsPage();
        break;
    }
  }
}
