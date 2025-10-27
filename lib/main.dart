import 'package:connectinno_task/data/local/note/model/note_model.dart';
import 'package:connectinno_task/data/local/note_adapter.dart';
import 'package:connectinno_task/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:connectinno_task/features/home/view_model/home_cubit/home_cubit.dart';
import 'package:connectinno_task/features/notes_add/view_model/notes_add_cubit/notes_add_cubit.dart';
import 'package:connectinno_task/features/profil/view_model/profil_cubit/profil_cubit.dart';
import 'package:connectinno_task/features/register/view_model/register_cubit/register_cubit.dart';
import 'package:connectinno_task/main.reflectable.dart';
import 'package:flutter/material.dart';
import 'package:connectinno_task/core/router_navigation/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectinno_task/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
   await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
    await Hive.openBox<Note>('notes');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => NotesAddCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
