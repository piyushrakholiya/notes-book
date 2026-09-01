import 'package:go_router/go_router.dart';
import 'package:notes/screens/add_notes.dart';
import 'package:notes/screens/all_notes.dart';
import 'package:notes/screens/home_screen.dart';
import 'package:notes/screens/login_screen.dart';
import 'package:notes/screens/note_detail_screen.dart';
import 'package:notes/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',

  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    final bool isLoggingIn = state.matchedLocation == '/login';
    final bool isSigningUp = state.matchedLocation == '/signup';

    if (!isLoggedIn && !isLoggingIn && !isSigningUp) {
      return '/login';
    }

    if (isLoggedIn && (isLoggingIn || isSigningUp)) {
      return '/home';
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: "/home",
      builder: (context, state) {
        return HomeScreen();
      },
    ),

    GoRoute(
      path: '/addNote',
      builder: (context, state) {
        return AddNotes();
      },
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) {
        return LoginScreen();
      },
    ),

    GoRoute(
      path: '/allNote',
      builder: (context, state) {
        return AllNotes();
      },
    ),

    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return SignupScreen();
      },
    ),

    GoRoute(
      path: '/note-detail/:id', // 👉 અહીં :id પેરામીટર છે
      builder: (context, state) {
        final noteId = state.pathParameters['id']!;
        return NoteDetailScreen(noteId: noteId); // 👉 માત્ર id મોકલીએ છીએ
      },
    ),
  ],
);
