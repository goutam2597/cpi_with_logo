import 'package:flutter/material.dart';
import 'package:logo_circular_progress_indicator/logo_circular_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo Circular Progress Indicator Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _showFullScreenLoader = false;

  void _showLoader() {
    setState(() => _showFullScreenLoader = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showFullScreenLoader = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logo Circular Progress Indicator')),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Loader Styles with Logo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'All variations use the same logo from assets/icon.png',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),

                // Gradient Style
                _buildExample(
                  'Gradient Style',
                  'Rotating gradient with smooth transitions',
                  const CustomLoader(
                    size: 70,
                    color: Colors.blue,
                    style: LoaderStyle.gradient,
                    logoAsset:
                        'packages/logo_circular_progress_indicator/assets/icon.png',
                  ),
                ),

                // Dotted Circle Style
                _buildExample(
                  'Dotted Circle Style',
                  'Animated dots forming a circle',
                  const CustomLoader(
                    size: 70,
                    color: Colors.purple,
                    style: LoaderStyle.dottedCircle,
                    logoAsset:
                        'packages/logo_circular_progress_indicator/assets/icon.png',
                  ),
                ),

                // Dual Ring Style
                _buildExample(
                  'Dual Ring Style',
                  'Two counter-rotating arcs',
                  const CustomLoader(
                    size: 70,
                    color: Colors.green,
                    style: LoaderStyle.dualRing,
                    logoAsset:
                        'packages/logo_circular_progress_indicator/assets/icon.png',
                  ),
                ),

                // Wave Style
                _buildExample(
                  'Wave Style',
                  'Pulsing waves radiating outward',
                  const CustomLoader(
                    size: 70,
                    color: Colors.orange,
                    style: LoaderStyle.wave,
                    logoAsset:
                        'packages/logo_circular_progress_indicator/assets/icon.png',
                  ),
                ),

                // Spinning Arcs Style
                _buildExample(
                  'Spinning Arcs Style',
                  'Multiple arcs spinning together',
                  const CustomLoader(
                    size: 70,
                    color: Colors.red,
                    style: LoaderStyle.spinningArcs,
                    logoAsset:
                        'packages/logo_circular_progress_indicator/assets/icon.png',
                  ),
                ),

                const Divider(height: 48),
                const Text(
                  'Different Sizes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Size variations
                _buildExample(
                  'Small (40px)',
                  'Perfect for inline loading states',
                  const CustomLoader(
                    size: 40,
                    color: Colors.teal,
                    style: LoaderStyle.gradient,
                    logoAsset:
                        'packages/logo_circular_progress_indicator/assets/icon.png',
                  ),
                ),

                _buildExample(
                  'Large (100px)',
                  'Great for prominent loading screens',
                  const CustomLoader(
                    size: 100,
                    color: Colors.indigo,
                    style: LoaderStyle.dualRing,
                    strokeWidth: 5.0,
                    logoAsset:
                        'packages/logo_circular_progress_indicator/assets/icon.png',
                  ),
                ),

                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _showLoader,
                    icon: const Icon(Icons.fullscreen),
                    label: const Text('Show Full Screen Loader'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Full screen loader overlay
          if (_showFullScreenLoader)
            const FullScreenLoader(
              message: 'Loading your content...',
              size: 80,
              style: LoaderStyle.gradient,
              logoAsset:
                  'packages/logo_circular_progress_indicator/assets/icon.png',
            ),
        ],
      ),
    );
  }

  Widget _buildExample(String title, String description, Widget loader) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          Center(child: loader),
        ],
      ),
    );
  }
}
