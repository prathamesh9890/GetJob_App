import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_job/presentation/pages/SavedJobsPage.dart';
import '../cubits/ThemeCubit.dart';
import '../cubits/job_cubit.dart';
import '../../domain/entities/job.dart';
import 'job_details_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Job Board'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.bookmarks),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SavedJobsPage()),
            );
          },
        )
        ,
        actions: [
          Row(
            children: [
              Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              Switch(
                value: isDark,
                onChanged: (val) {
                  context.read<ThemeCubit>().toggleTheme(val);
                },
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is JobLoaded) {
            return ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final Job job = state.jobs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Icon(
                      job.isRemote ? Icons.home : Icons.business,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(job.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job.company),
                        Text(job.location),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailsPage(job: job),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is JobError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No jobs found.'));
        },
      ),
    );
  }
}