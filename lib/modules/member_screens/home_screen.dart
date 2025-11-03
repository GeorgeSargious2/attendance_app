import 'package:attendance_app/shared/components/helpers.dart/spacing.dart';
import 'package:attendance_app/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../models/announcement _model.dart';
import 'member_cubit/attendance_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MobileScannerController? scannerController;
  bool isScanning = false;

  @override
  void dispose() {
    scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceLoaded && state.scanSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Attendance recorded for ${state.lastScan?.meetingName}! +${state.lastScan?.pointsEarned} points'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AttendanceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is! AttendanceLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Spacer(),
                    Logo(),
                  ],
                ),
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQrScannerSection(context),
                  _buildQuestionsSection(context),
                  _buildAddSection(context),
                ],
              ),
              _buildPointsCard(context, state.user?.totalPoints ?? 0),
              _buildAnnouncementsSection(state.announcements),
            ],
          ),
        );
      },
    );
  }

  Widget Logo() {
    return Image(
      width: 80.w,
      height: 80.h,
      image: const AssetImage(
          'assets/WhatsApp_Image_2025-07-12_at_12.41.11_5a2db3da-removebg-preview.png'),
    );
  }

  Widget _buildQrScannerSection(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            children: [
              Text(
                'Scan QR Code',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              verticalSpace(2),
              GestureDetector(
                onTap: () => _showScannerDialog(context),
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.blue, width: 2.sp),
                  ),
                  child: Icon(Icons.qr_code_scanner,
                      size: 30.sp, color: ColorsManager.main),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionsSection(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            children: [
              Text(
                'Your question',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              verticalSpace(2),
              GestureDetector(
                onTap: () => _showScannerDialog(context),
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.blue, width: 2.sp),
                  ),
                  child: Icon(Icons.question_answer_outlined,
                      size: 30.sp, color: ColorsManager.main),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddSection(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            children: [
              Text(
                'Add a photo',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              verticalSpace(2),
              GestureDetector(
                onTap: () => _showScannerDialog(context),
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.blue, width: 2.sp),
                  ),
                  child: Icon(Icons.add_a_photo_outlined,
                      size: 30.sp, color: ColorsManager.main),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointsCard(BuildContext context, int points) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 320.w,
            child: Column(
              children: [
                Text(
                  'Your Points',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                verticalSpace(8),
                Text(
                  points.toString(),
                  style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                verticalSpace(8),
                Text(
                  'Scan QR codes at meetings to earn more points!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementsSection(List<Announcement> announcements) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 320.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Announcements',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                verticalSpace(8),
                announcements.isEmpty
                    ? Container(
                        height: 200.h,
                        alignment: Alignment.center, // Center the text
                        child: Text(
                          'No announcements yet.',
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                      )
                    : SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: announcements.length,
                          itemBuilder: (context, index) {
                            final announcement = announcements[index];
                            return Container(
                              width: 250,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(announcement.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.7),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  announcement.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showScannerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Scan QR Code',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                width: 300,
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.normal,
                    facing: CameraFacing.back,
                    torchEnabled: false,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue != null && !isScanning) {
                        isScanning = true;
                        Navigator.pop(context);
                        context
                            .read<AttendanceCubit>()
                            .scanQrCode(barcode.rawValue!);
                        Future.delayed(const Duration(seconds: 2),
                            () => isScanning = false);
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
