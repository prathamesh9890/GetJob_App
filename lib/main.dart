import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_job/presentation/cubits/ThemeCubit.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/job_repository_impl.dart';
import 'domain/usecases/get_jobs_usecase.dart';
import 'presentation/cubits/job_cubit.dart';
import 'presentation/cubits/saved_jobs_cubit.dart';
import 'presentation/pages/home_page.dart';

void main() {
  final dio = Dio();
  final repo = JobRepositoryImpl(dio);
  final useCase = GetJobsUseCase(repo);

  runApp(MyApp(useCase));
}

class MyApp extends StatelessWidget {
  final GetJobsUseCase useCase;

  const MyApp(this.useCase, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => JobCubit(useCase)..fetchJobs()),
        BlocProvider(create: (_) => SavedJobsCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Job App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
