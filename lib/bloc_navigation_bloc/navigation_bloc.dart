import 'package:bloc/bloc.dart';
import 'package:brtbus/Pages/news.dart';
import 'package:brtbus/Pages/routes.dart';
import '../Pages/info.dart';
import '../Pages/about.dart';
import 'package:brtbus/Pages/home.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  RoutesPageClickedEvent,
  NewsPageClickedEvent,
  InfoPageClickedEvent,
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
      case NavigationEvents.InfoPageClickedEvent:
        yield InfoPage();
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
