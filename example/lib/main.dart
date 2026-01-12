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
      title: 'Logo Circular Progress Indicator - Comprehensive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showFullScreenLoader = false;
  LoaderStyle _selectedStyle = LoaderStyle.gradient;
  Color _selectedColor = Colors.blue;
  double _selectedSize = 70.0;
  double _selectedStroke = 3.5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        title: const Text('Logo Circular Progress Indicator'),
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'All Styles'),
            Tab(icon: Icon(Icons.tune), text: 'Playground'),
            Tab(icon: Icon(Icons.grid_on), text: 'Grid View'),
            Tab(icon: Icon(Icons.info_outline), text: 'Info'),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _buildAllStylesTab(),
              _buildPlaygroundTab(),
              _buildGridViewTab(),
              _buildInfoTab(),
            ],
          ),
          if (_showFullScreenLoader)
            FullScreenLoader(
              message: 'Loading your content...',
              size: 80,
              style: _selectedStyle,
              logoAsset:
                  'packages/logo_circular_progress_indicator/assets/icon.png',
            ),
        ],
      ),
    );
  }

  // Tab 1: All Styles Showcase
  Widget _buildAllStylesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Animation Styles',
            'All variations use the same logo from assets/icon.png',
          ),
          const SizedBox(height: 24),

          // Gradient Style
          _buildExample(
            'Gradient Style',
            'Rotating gradient with smooth transitions',
            Colors.blue,
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
            Colors.purple,
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
            Colors.green,
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
            Colors.orange,
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
            Colors.red,
            const CustomLoader(
              size: 70,
              color: Colors.red,
              style: LoaderStyle.spinningArcs,
              logoAsset:
                  'packages/logo_circular_progress_indicator/assets/icon.png',
            ),
          ),

          const Divider(height: 48),
          _buildSectionHeader(
            'Different Sizes',
            'From small inline to large splash screens',
          ),
          const SizedBox(height: 16),

          _buildExample(
            'Tiny (30px)',
            'Minimal inline loader',
            Colors.pink,
            const CustomLoader(
              size: 30,
              color: Colors.pink,
              style: LoaderStyle.gradient,
              strokeWidth: 2.5,
              logoAsset:
                  'packages/logo_circular_progress_indicator/assets/icon.png',
            ),
          ),

          _buildExample(
            'Small (40px)',
            'Perfect for buttons and cards',
            Colors.teal,
            const CustomLoader(
              size: 40,
              color: Colors.teal,
              style: LoaderStyle.dottedCircle,
              logoAsset:
                  'packages/logo_circular_progress_indicator/assets/icon.png',
            ),
          ),

          _buildExample(
            'Medium (70px)',
            'Ideal for general use',
            Colors.indigo,
            const CustomLoader(
              size: 70,
              color: Colors.indigo,
              style: LoaderStyle.dualRing,
              logoAsset:
                  'packages/logo_circular_progress_indicator/assets/icon.png',
            ),
          ),

          _buildExample(
            'Large (100px)',
            'Great for splash screens',
            Colors.deepPurple,
            const CustomLoader(
              size: 100,
              color: Colors.deepPurple,
              style: LoaderStyle.wave,
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
    );
  }

  // Tab 2: Interactive Playground
  Widget _buildPlaygroundTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Interactive Playground',
            'Customize and preview in real-time',
          ),
          const SizedBox(height: 24),

          // Live Preview
          Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: CustomLoader(
                size: _selectedSize,
                color: _selectedColor,
                style: _selectedStyle,
                strokeWidth: _selectedStroke,
                logoAsset:
                    'packages/logo_circular_progress_indicator/assets/icon.png',
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Style Selector
          const Text(
            'Animation Style',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStyleChip('Gradient', LoaderStyle.gradient),
              _buildStyleChip('Dotted', LoaderStyle.dottedCircle),
              _buildStyleChip('Dual Ring', LoaderStyle.dualRing),
              _buildStyleChip('Wave', LoaderStyle.wave),
              _buildStyleChip('Arcs', LoaderStyle.spinningArcs),
            ],
          ),

          const SizedBox(height: 24),

          // Color Selector
          const Text(
            'Color',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildColorChip(Colors.blue),
              _buildColorChip(Colors.purple),
              _buildColorChip(Colors.green),
              _buildColorChip(Colors.orange),
              _buildColorChip(Colors.red),
              _buildColorChip(Colors.pink),
              _buildColorChip(Colors.teal),
              _buildColorChip(Colors.indigo),
              _buildColorChip(Colors.amber),
              _buildColorChip(Colors.deepPurple),
            ],
          ),

          const SizedBox(height: 24),

          // Size Slider
          const Text(
            'Size',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _selectedSize,
                  min: 30,
                  max: 150,
                  divisions: 24,
                  label: '${_selectedSize.round()}px',
                  onChanged: (value) => setState(() => _selectedSize = value),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  '${_selectedSize.round()}px',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Stroke Width Slider
          const Text(
            'Stroke Width',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _selectedStroke,
                  min: 1.5,
                  max: 8.0,
                  divisions: 13,
                  label: _selectedStroke.toStringAsFixed(1),
                  onChanged: (value) => setState(() => _selectedStroke = value),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  _selectedStroke.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Code Preview
          const Text(
            'Code',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              _generateCode(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab 3: Grid View
  Widget _buildGridViewTab() {
    final styles = [
      LoaderStyle.gradient,
      LoaderStyle.dottedCircle,
      LoaderStyle.dualRing,
      LoaderStyle.wave,
      LoaderStyle.spinningArcs,
    ];

    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
      Colors.deepPurple,
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        final style = styles[index % styles.length];
        final color = colors[index % colors.length];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: CustomLoader(
              size: 60,
              color: color,
              style: style,
              logoAsset:
                  'packages/logo_circular_progress_indicator/assets/icon.png',
            ),
          ),
        );
      },
    );
  }

  // Tab 4: Info
  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('About', 'Logo Circular Progress Indicator'),
          const SizedBox(height: 16),
          _buildInfoCard(
            Icons.palette,
            'Customizable',
            'Adjust size, color, stroke width, and animation style to match your brand.',
          ),
          _buildInfoCard(
            Icons.animation,
            '5 Animation Styles',
            'Choose from Gradient, Dotted Circle, Dual Ring, Wave, or Spinning Arcs.',
          ),
          _buildInfoCard(
            Icons.image,
            'Logo Support',
            'Use package assets, your own assets, or custom widgets as the center logo.',
          ),
          _buildInfoCard(
            Icons.mobile_friendly,
            'Responsive',
            'Works seamlessly across all screen sizes and platforms.',
          ),
          const SizedBox(height: 24),
          const Text(
            'Features',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFeatureItem('✨ Beautiful animations with smooth transitions'),
          _buildFeatureItem('🎨 Fully customizable colors and sizes'),
          _buildFeatureItem('📦 Includes built-in icon asset'),
          _buildFeatureItem('🚀 Lightweight and performant'),
          _buildFeatureItem('💼 Perfect for maintaining brand identity'),
          _buildFeatureItem('📱 Full-screen loader overlay included'),
          const SizedBox(height: 24),
          const Text(
            'Usage',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const SelectableText(
              '''CustomLoader(
  size: 70,
  color: Colors.blue,
  style: LoaderStyle.gradient,
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildExample(
    String title,
    String description,
    Color accentColor,
    Widget loader,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 16),
          Center(child: loader),
        ],
      ),
    );
  }

  Widget _buildStyleChip(String label, LoaderStyle style) {
    final isSelected = _selectedStyle == style;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) => setState(() => _selectedStyle = style),
      selectedColor: Colors.blue.shade100,
      checkmarkColor: Colors.blue,
    );
  }

  Widget _buildColorChip(Color color) {
    final isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 8,
                spreadRadius: 2,
              ),
          ],
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 24)
            : null,
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }

  String _generateCode() {
    final styleName = _selectedStyle.toString().split('.').last;
    return '''CustomLoader(
  size: ${_selectedSize.round()},
  color: Colors.${_getColorName(_selectedColor)},
  style: LoaderStyle.$styleName,
  strokeWidth: ${_selectedStroke.toStringAsFixed(1)},
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)''';
  }

  String _getColorName(Color color) {
    if (color == Colors.blue) return 'blue';
    if (color == Colors.purple) return 'purple';
    if (color == Colors.green) return 'green';
    if (color == Colors.orange) return 'orange';
    if (color == Colors.red) return 'red';
    if (color == Colors.pink) return 'pink';
    if (color == Colors.teal) return 'teal';
    if (color == Colors.indigo) return 'indigo';
    if (color == Colors.amber) return 'amber';
    if (color == Colors.deepPurple) return 'deepPurple';
    return 'blue';
  }
}
