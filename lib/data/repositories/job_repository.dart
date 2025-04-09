import 'package:get_job/domain/entities/job.dart';


abstract class JobRepository {
  Future<List<Job>> getJobs();
}
