import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:aerium/values/values.dart';
import 'dart:ui' as ui;
class ProjectDetailDesktop extends StatefulWidget {
  final ProjectDetails? projectDetails;

  ProjectDetailDesktop({required this.projectDetails});

  @override
  _ProjectDetailDesktopState createState() => _ProjectDetailDesktopState();
}

class _ProjectDetailDesktopState extends State<ProjectDetailDesktop> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late PdfViewerController _pdfViewerController;

  late AllPortfolioData allPortfolioData;
  late ProjectDetails currentProject;
  late String currentPdf;

  bool _showInstruction = true; // Flag to control visibility of the text

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();

    _pdfViewerController = PdfViewerController();

    allPortfolioData = Data.allPortfolioData;
    currentProject = widget.projectDetails!;
    currentPdf = currentProject.pdf;

    // Start a timer to hide the instruction after 3 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showInstruction = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _navigateToProjectDetail(String pdf) {
    setState(() {
      currentPdf = pdf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PDF Viewer
          Positioned.fill(
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: Container(
                color: Colors.grey[100],
                child: SfPdfViewer.asset(
                  currentPdf,
                  controller: _pdfViewerController,
                  interactionMode: PdfInteractionMode.pan,
                  initialZoomLevel: 0.5,
                  maxZoomLevel: 4.0,
                ),
              ),
            ),
          ),

          // Back button (top-left)
          Positioned(
            top: 40,
            left: 40,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(159, 22, 22, 22),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 255, 191, 206)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),

          // Instruction text in the center (visible only for 3 seconds)
          if (_showInstruction)
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color:Color.fromARGB(159, 22, 22, 22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Double-tap if you want to zoom in", // Instruction text
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 191, 206),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Navigation buttons (bottom-right)
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildProjectButton(allPortfolioData.title_1, allPortfolioData.pdf_1),
                _buildProjectButton(allPortfolioData.title_2, allPortfolioData.pdf_2),
                _buildProjectButton(allPortfolioData.title_3, allPortfolioData.pdf_3),
                _buildProjectButton(allPortfolioData.title_4, allPortfolioData.pdf_4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectButton(String title, String pdf) {
    bool isCurrentPdf = currentPdf == pdf;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          _navigateToProjectDetail(pdf);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isCurrentPdf ? AppColors.primaryColor : const Color.fromARGB(160, 255, 255, 255),
          padding: EdgeInsets.symmetric(vertical: 15),
          minimumSize: Size(200, 50),
          textStyle: TextStyle(fontSize: isCurrentPdf ? 16 : 14),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isCurrentPdf ? const ui.Color.fromARGB(255, 255, 191, 206) : Colors.black,
          ),
        ),
      ),
    );
  }
}
