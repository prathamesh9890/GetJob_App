import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/job.dart';
import '../cubits/saved_jobs_cubit.dart';
import 'job_details_page.dart';

class SavedJobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedJobs = context.watch<SavedJobsCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text('Saved Jobs')),
      body: savedJobs.isEmpty
          ? Center(child: Text('No saved jobs.'))
          : ListView.builder(
        itemCount: savedJobs.length,
        itemBuilder: (context, index) {
          final job = savedJobs[index];
          return ListTile(
            title: Text(job.title),
            subtitle: Text(job.company),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => JobDetailsPage(job: job),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
