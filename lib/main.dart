import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ThemeProvider(duration: Duration(milliseconds: 800),initTheme: ThemeData.light(useMaterial3: true).copyWith(primaryColor: Colors.blue,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark
    ),
  )), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Dark Theme',
      debugShowCheckedModeBanner: false,
    theme:  ThemeModelInheritedNotifier.of(context).theme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return Scaffold(
          body: const Center(
            child: Icon(Icons.telegram,color: Colors.blue,size: 150,),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton:Padding(
            padding: const EdgeInsets.all(8.0),
            child: ThemeSwitcher(
              builder: (context) {
            return AnimatedCrossFade(
              reverseDuration:Duration(milliseconds: 800),
              duration: Duration(milliseconds: 800),
              crossFadeState: ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.dark ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: GestureDetector(
                onTap: () {
                  ThemeSwitcher.of(context).changeTheme(theme: ThemeData.light(useMaterial3: true).copyWith(
                    appBarTheme:  AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark
                      ),
                    ),
                  ),isReversed: true);
                },
                child: Icon(
                  Icons.sunny,
                  size: 32,
                  color:Colors.blue ,
                ),
              ),
              secondChild: GestureDetector(
                onTap: () {
                  ThemeSwitcher.of(context).changeTheme(theme: ThemeData.dark(useMaterial3: true).copyWith(primaryColor: Colors.indigoAccent,
                  appBarTheme:  AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light
                  ),
                  ),),isReversed: false);
                },
                child: Icon(
                  CupertinoIcons.moon_stars,
                  size: 32,
                  color:Colors.blue ,
                ),
              ),
            );
                    },
                    ),
          ),
        );
      }),
    );
  }
}
