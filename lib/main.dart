import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopLine Certification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late TransformationController _transformationController;

  bool _isLoading = true;
  double _currentZoom = 1.0;

  final List<String> _pageImages = [
    'assets/pages/tnpl_page-0001.jpg',
    'assets/pages/tnpl_page-0002.jpg',
    'assets/pages/tnpl_page-0003.jpg',
    'assets/pages/tnpl_page-0004.jpg',
    'assets/pages/tnpl_page-0005.jpg',
    'assets/pages/tnpl_page-0006.jpg',
    'assets/pages/tnpl_page-0007.jpg',
    'assets/pages/tnpl_page-0008.jpg',
    'assets/pages/tnpl_page-0009.jpg',
    'assets/pages/tnpl_page-0010.jpg',
    'assets/pages/tnpl_page-0011.jpg',
    'assets/pages/tnpl_page-0012.jpg',
    'assets/pages/tnpl_page-0013.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _transformationController = TransformationController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Simulate loading time
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _fadeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom * 1.2).clamp(0.5, 5.0);
      _transformationController.value = Matrix4.identity()..scale(_currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom / 1.2).clamp(0.5, 5.0);
      _transformationController.value = Matrix4.identity()..scale(_currentZoom);
    });
  }

  void _resetZoom() {
    setState(() {
      _currentZoom = 1.0;
      _transformationController.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildBanner(),
          Expanded(
            child: _isLoading ? _buildLoadingScreen() : _buildPdfViewer(),
          ),
        ],
      ),
      floatingActionButton: _isLoading ? null : _buildZoomControls(),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF840c4c),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 768 ? 24 : 16,
        vertical: MediaQuery.of(context).size.width > 768 ? 16 : 12,
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: MediaQuery.of(context).size.width > 768 ? 60 : 40,
            height: MediaQuery.of(context).size.width > 768 ? 60 : 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/pages/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    child: const Icon(
                      Icons.business,
                      color: Color(0xFF840c4c),
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width > 768 ? 16 : 12),
          // Contact details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Maruthur- Ongallur Road, Pattambi, Palakkad Dist, Kerala - 679306',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width > 768 ? 14 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: MediaQuery.of(context).size.width > 768 ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width > 768 ? 16 : 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'toplinemarketing12@gmail.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width > 768
                              ? 14
                              : 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 40,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Loading Documents...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfViewer() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: 0.5,
        maxScale: 5.0,
        child: ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: _pageImages.length,
          itemBuilder: (context, index) {
            return _buildPage(_pageImages[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildPage(String imagePath, int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 768 ? 40 : 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: MediaQuery.of(context).size.width > 768
              ? BoxFit.contain
              : BoxFit.contain,
          width: double.infinity,
          height: MediaQuery.of(context).size.width > 768
              ? MediaQuery.of(context).size.height * 0.8
              : MediaQuery.of(context).size.height * 0.6,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              color: Colors.grey[50],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load page ${index + 1}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: "zoom_in",
          onPressed: _zoomIn,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 4,
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: "zoom_out",
          onPressed: _zoomOut,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 4,
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          heroTag: "zoom_reset",
          onPressed: _resetZoom,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 4,
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
