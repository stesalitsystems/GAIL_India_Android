import 'package:flutter/material.dart';
import 'package:gail_india/common/widgets/appbar/appbar.dart';
import 'package:gail_india/common/widgets/sidebar/sidebar.dart';
import 'package:gail_india/features/route_diversion/route_diversion_card.dart';
import 'package:gail_india/features/route_diversion/route_diversion_model.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RouteDiversion extends StatefulWidget {
  const RouteDiversion({super.key});

  @override
  State<RouteDiversion> createState() => _RouteDiversionState();
}

enum _Panel { none, filter, download }

class _RouteDiversionState extends State<RouteDiversion> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  _Panel _openPanel = _Panel.none;

  // Filter controllers
  final _lcvCtrl = TextEditingController();
  final _msCtrl = TextEditingController();
  final _dsCtrl = TextEditingController();
  final _detectedAtCtrl = TextEditingController();

  Future<void> _onRefresh() async {
    // TODO: call your API here
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.refreshCompleted();
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Refreshed')));
  }

  void _togglePanel(_Panel panel) {
    setState(() {
      _openPanel = (_openPanel == panel) ? _Panel.none : panel;
    });
  }

  void _onSearch() {
    // TODO: use the controllers to run your query
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Searching with: LCV=${_lcvCtrl.text}, MS=${_msCtrl.text}, DS=${_dsCtrl.text}, DetectedAt=${_detectedAtCtrl.text}',
        ),
      ),
    );
  }

  void _onClear() {
    _lcvCtrl.clear();
    _msCtrl.clear();
    _dsCtrl.clear();
    _detectedAtCtrl.clear();
    setState(() {});
  }

  void _downloadExcel() {
    // TODO: trigger excel generation
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Downloading Excel…')));
  }

  void _downloadPdf() {
    // TODO: trigger pdf generation
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Downloading PDF…')));
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _lcvCtrl.dispose();
    _msCtrl.dispose();
    _dsCtrl.dispose();
    _detectedAtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(title: 'Route Diversion'),
      drawer: const GSidebar(),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const ClassicHeader(
          refreshingText: 'Refreshing…',
          idleText: 'Pull down to refresh',
          releaseText: 'Release to refresh',
          completeText: 'Refresh complete',
          failedText: 'Refresh failed',
        ),
        onRefresh: _onRefresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  // Filter button
                  Expanded(
                    child: InkWell(
                      onTap: () => _togglePanel(_Panel.filter),
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 12,
                        ),
                        margin: const EdgeInsets.only(
                          right: 8,
                        ), // space between buttons
                        decoration: BoxDecoration(
                          color: GColors.lightgreyContainer,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _openPanel == _Panel.filter
                                ? Colors.black54
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.filter_alt,
                              size: 20,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Download button
                  Expanded(
                    child: InkWell(
                      onTap: () => _togglePanel(_Panel.download),
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: GColors.lightgreyContainer,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: _openPanel == _Panel.download
                                ? Colors.black54
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.download,
                              size: 20,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Download",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Animated panel area (shows either Filter or Download)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _openPanel == _Panel.filter
                  ? _FilterSection(
                      lcvCtrl: _lcvCtrl,
                      msCtrl: _msCtrl,
                      dsCtrl: _dsCtrl,
                      detectedAtCtrl: _detectedAtCtrl,
                      onSearch: _onSearch,
                      onClear: _onClear,
                    )
                  : _openPanel == _Panel.download
                  ? _DownloadSection(
                      onExcel: _downloadExcel,
                      onPdf: _downloadPdf,
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 0),
                itemBuilder: (context, index) {
                  return RouteDiversionCard(item: _items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.lcvCtrl,
    required this.msCtrl,
    required this.dsCtrl,
    required this.detectedAtCtrl,
    required this.onSearch,
    required this.onClear,
  });

  final TextEditingController lcvCtrl;
  final TextEditingController msCtrl;
  final TextEditingController dsCtrl;
  final TextEditingController detectedAtCtrl;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    Widget field(String label, TextEditingController ctrl) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            controller: ctrl,
            decoration: InputDecoration(
              labelText: label,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: LCV + MS
          Row(
            children: [
              field('LCV Number', lcvCtrl),
              field('Mother Station', msCtrl),
            ],
          ),
          const SizedBox(height: 12),

          // Row 2: DS + Detected At
          Row(
            children: [
              field('Daughter Station', dsCtrl),
              field('Detected At', detectedAtCtrl),
            ],
          ),
          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              ElevatedButton(
                onPressed: onSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                child: const Text('Search'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: onClear,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                child: const Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DownloadSection extends StatelessWidget {
  const _DownloadSection({required this.onExcel, required this.onPdf});

  final VoidCallback onExcel;
  final VoidCallback onPdf;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('download'),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          ElevatedButton.icon(
            onPressed: onExcel,
            icon: const Icon(Icons.grid_on),
            label: const Text('Download Excel'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          ElevatedButton.icon(
            onPressed: onPdf,
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Download PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

final List<RouteDiversionItem> _items = [
  RouteDiversionItem(
    lcvNumber: 'LCV-1024',
    motherStation: 'MS – North Hub',
    daughterStation: 'DBS – Sector 21',
    latitude: 28.6139,
    longitude: 77.2090,
    detectedAt: '2025-09-01 10:24',
    resolvedAt: '2025-09-01 11:05',
  ),
  RouteDiversionItem(
    lcvNumber: 'LCV-2048',
    motherStation: 'MS – East Yard',
    daughterStation: 'DBS – Green Park',
    latitude: 19.0760,
    longitude: 72.8777,
    detectedAt: '2025-09-01 09:40',
    resolvedAt: '2025-09-01 10:15',
  ),
];
