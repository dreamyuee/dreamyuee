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

  late AllPortfolioData allPortfolioData; // All portfolio data
  late ProjectDetails currentProject; // Current selected project

  late String currentPdf; // Store the current PDF

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

    _controller.forward(); // Start the fade-in animation

    _pdfViewerController = PdfViewerController(); // Initialize PdfViewerController

    // Initialize portfolio data (this is from your static data)
    allPortfolioData = Data.allPortfolioData; // Access the static AllPortfolioData
    currentProject = widget.projectDetails!; // The project passed from PortfolioPage
    currentPdf = currentProject.pdf; // Set the initial PDF from the passed project
  }

  @override
  void dispose() {
    _controller.dispose();
    _pdfViewerController.dispose(); // Dispose PdfViewerController
    super.dispose();
  }

  // Function to handle PDF switching
  void _navigateToProjectDetail(String pdf) {
    setState(() {
      currentPdf = pdf; // Update the current PDF
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
                color: Colors.grey[100], // Background color
                child: SfPdfViewer.asset(
                  currentPdf, // Display the current PDF
                  controller: _pdfViewerController,
                  interactionMode: PdfInteractionMode.pan, // Enable pan
                  initialZoomLevel: 0.5, // Initial zoom level
                  maxZoomLevel: 4.0, // Maximum zoom level
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
                color: const Color.fromARGB(159, 22, 22, 22), // White color with opacity
                shape: BoxShape.circle, // Ensure the button is circular
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 255, 191, 206)),
                onPressed: () {
                  Navigator.of(context).pop(); // Go back to the previous screen
                },
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
                // Buttons for projects
                _buildProjectButton(
                  allPortfolioData.title_1,
                  allPortfolioData.pdf_1,
                ),
                _buildProjectButton(
                  allPortfolioData.title_2,
                  allPortfolioData.pdf_2,
                ),
                _buildProjectButton(
                  allPortfolioData.title_3,
                  allPortfolioData.pdf_3,
                ),
                _buildProjectButton(
                  allPortfolioData.title_4,
                  allPortfolioData.pdf_4,
                ),

               
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the buttons for each project
  Widget _buildProjectButton(String title, String pdf) {
    bool isCurrentPdf = currentPdf == pdf;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          _navigateToProjectDetail(pdf); // Switch to the selected project's PDF
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isCurrentPdf ?  AppColors.primaryColor : const Color.fromARGB(160, 255, 255, 255), // Highlight the selected project
          padding: EdgeInsets.symmetric(vertical: 15), // Keep button height consistent
          minimumSize: Size(200, 50), // Ensure all buttons have the same width and height
          textStyle: TextStyle(fontSize: isCurrentPdf ? 16 : 14),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isCurrentPdf ? const ui.Color.fromARGB(255, 255, 191, 206) : Colors.black, // Change text color based on selection
          ),
        ),
      ),
    );
  }
}