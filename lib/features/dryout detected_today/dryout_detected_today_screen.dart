import 'package:flutter/material.dart';
import 'package:gail_india/common/widgets/appbar/appbar.dart';
import 'package:gail_india/common/widgets/sidebar/sidebar.dart';
import 'package:gail_india/features/dryout%20detected_today/dryout_detected_today_card.dart';
import 'package:gail_india/features/dryout%20detected_today/dryout_detected_today_model.dart';
import 'package:gail_india/features/no_dryout_detected_dbs/no_dry_out_detected_dbs_card.dart';
import 'package:gail_india/features/no_dryout_detected_dbs/no_dry_out_detected_dbs_model.dart';
import 'package:gail_india/features/route_diversion/route_diversion_card.dart';
import 'package:gail_india/features/route_diversion/route_diversion_model.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DryOutDetectedTodayDbs extends StatefulWidget {
  const DryOutDetectedTodayDbs({super.key});

  @override
  State<DryOutDetectedTodayDbs> createState() => _DryOutDetectedTodayDbsState();
}

enum _Panel { none, filter, download }

class _DryOutDetectedTodayDbsState extends State<DryOutDetectedTodayDbs> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  _Panel _openPanel = _Panel.none;

  // Filter controllers
  final dbsName = TextEditingController();
  final msName = TextEditingController();
  final gaName = TextEditingController();
  // final _detectedAtCtrl = TextEditingController();

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
          'Searching with: LCV=${gaName.text}, MS=${msName.text}, DS=${dbsName.text},',
        ),
      ),
    );
  }

  void _onClear() {
    msName.clear();
    dbsName.clear();
    gaName.clear();
    // _detectedAtCtrl.clear();
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
    dbsName.dispose();
    msName.dispose();
    gaName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(title: 'Dry-Out Detected DBS'),
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
                          borderRadius: BorderRadius.circular(2),
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
                      dbsName: dbsName,
                      msName: msName,
                      gaName: gaName,
                      // detectedAtCtrl: _detectedAtCtrl,
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
                  return DryOutDetectedTodayDbsCard(item: _items[index]);
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
    required this.dbsName,
    required this.gaName,
    required this.msName,

    required this.onSearch,
    required this.onClear,
  });

  final TextEditingController dbsName;
  final TextEditingController gaName;
  final TextEditingController msName;

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
              field('DBS Name', dbsName),
              field('Mother Station', msName),
            ],
          ),
          const SizedBox(height: 12),

          // Row 2: DS + Detected At
          Row(
            children: [
              field('Geographical Area', gaName),
              // field('Detected At', detectedAtCtrl),
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

final List<DryOutDetectedToday> _items = [
  DryOutDetectedToday(
    gaName: 'Delhi NSR',
    motherStation: 'MS Dhwarka',
    daughterStation: 'DBS Utam nagar',
    currentStock: 188.8,
    tripStatus: 'Started',
    dispatchedAt: '2024-10-01 10:00',
    arrivedAt: '2024-10-01 14:00',
    nextDispatchAt: '2024-10-01 14:00',
    statusLcv: 'Active',
  ),
  DryOutDetectedToday(
    gaName: 'Delhi NSR',
    motherStation: 'MS Dhwarka',
    daughterStation: 'DBS Utam nagar',
    currentStock: 188.8,
    tripStatus: 'Started',
    dispatchedAt: '2024-10-01 10:00',
    arrivedAt: '2024-10-01 14:00',
    nextDispatchAt: '2024-10-01 14:00',
    statusLcv: 'Active',
  ),
];
