import '../../data/repositories/job_repository.dart';
import '../entities/job.dart';


class GetJobsUseCase {
  final JobRepository repository;

  GetJobsUseCase(this.repository);

  Future<List<Job>> call() => repository.getJobs();
}
