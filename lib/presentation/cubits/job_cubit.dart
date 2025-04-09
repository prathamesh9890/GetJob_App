import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/job.dart';
import '../../domain/usecases/get_jobs_usecase.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final GetJobsUseCase useCase;

  JobCubit(this.useCase) : super(JobInitial());

  Future<void> fetchJobs() async {
    emit(JobLoading());
    try {
      final jobs = await useCase();
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}
