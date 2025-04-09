import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/job.dart';
import '../cubits/saved_jobs_cubit.dart';

class JobDetailsPage extends StatelessWidget {
  final Job job;

  const JobDetailsPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final savedJobsCubit = context.watch<SavedJobsCubit>();
    final isSaved = savedJobsCubit.isJobSaved(job);

    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${job.company} • ${job.location}',
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Text(
              'Job Description',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  job.description,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (isSaved) {
                  context.read<SavedJobsCubit>().removeJob(job);
                } else {
                  context.read<SavedJobsCubit>().saveJob(job);
                }
              },
              icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              label: Text(isSaved ? "Saved" : "Save Job"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
