import 'package:dio/dio.dart';
import 'package:get_job/data/repositories/job_repository.dart';
import 'package:get_job/domain/entities/job.dart';
import 'package:get_job/data/models/job_model.dart';


class JobRepositoryImpl implements JobRepository {
  final Dio dio;

  JobRepositoryImpl(this.dio);

  @override
  Future<List<Job>> getJobs() async {
    try {
      final response = await dio.get('https://test-green-chi-37.vercel.app/test/get');

      // Decode JSON list of jobs
      final List<dynamic> jsonList = response.data;

      // Convert to List<Job>
      final List<Job> jobs = jsonList.map((json) {
        final jobModel =  job_model.fromJson(json);

        return Job(
          id: jobModel.sId ?? '',
          title: jobModel.title ?? '',
          company: jobModel.company ?? '',
          location: jobModel.location ?? '',
          description: jobModel.description ?? '',
          isRemote: jobModel.isRemote ?? false,
          isSaved: jobModel.isSaved ?? false,
        );
      }).toList();

      return jobs;
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }
}