import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Entry point → runs MyApp widget
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Layout Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Campground Layout (Basics Only)')),
        // Scroll in case the phone is small
        body: SingleChildScrollView(
          child: Center(
            // Keep all content in a narrow column for nicer look
            child: Container(
              // Outer margin so content doesn’t touch screen edges
              margin: EdgeInsets.all(16),
              // A white “card-like” background with rounded corners + shadow
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              // The main vertical layout
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // full width
                children: [
                  // =========================
                  // 1) TOP IMAGE
                  // =========================
                  Container(
                    height: 200,
                    // Rounded top corners only (like your screenshot)
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        // Any public image URL you like
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1508261303786-0e0f6f7d77af?q=80&w=1200&auto=format&fit=crop',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Little separator space
                  SizedBox(height: 12),

                  // =========================
                  // 2) TITLE + SUBTITLE + RATING ROW
                  // =========================
                  Container(
                    padding: EdgeInsets.all(12), // inner spacing
                    margin: EdgeInsets.symmetric(horizontal: 12), // outer gap
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      // a thin grey border to highlight this section
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side: title + subtitle (stacked vertically)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Oeschinen Lake Campground',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Kandersteg, Switzerland',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),

                        // Flexible spacer using just SizedBox + Row alignment:
                        // We can push the right-side rating by letting Row
                        // space its children apart.
                        // (Alternative: add SizedBox(width: some big value))
                        // Simpler: set mainAxisAlignment on the Row:
                      ],
                    ),
                  ),

                  // We want the rating on the same line but right-aligned.
                  // Since we’re sticking to basics, we’ll recreate the whole
                  // row so we can control spacing with mainAxisAlignment.
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12).copyWith(top: 8),
                    child: Row(
                      // Spread left group (title box above) and right rating
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Invisible placeholder so the row has two sides.
                        // (We already showed title above; this keeps it simple.)
                        SizedBox(width: 1),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.red),
                            SizedBox(width: 6),
                            Text('41',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // =========================
                  // 3) ACTION BUTTONS ROW (CALL / ROUTE / SHARE)
                  //    Using only Row/Column/Icon/Text + simple Containers
                  // =========================
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Row(
                      // Evenly distribute the 3 button groups
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Button 1
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.call, color: Colors.blue),
                            SizedBox(height: 6),
                            Text('CALL',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),

                        // Button 2
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.near_me, color: Colors.blue),
                            SizedBox(height: 6),
                            Text('ROUTE',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),

                        // Button 3
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.share, color: Colors.blue),
                            SizedBox(height: 6),
                            Text('SHARE',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // =========================
                  // 4) DESCRIPTION TEXT
                  // =========================
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Text(
                      "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. "
                          "Situated 1,578 meters above sea level, it is one of the larger Alpine lakes. "
                          "A gondola ride from Kandersteg, followed by a half-hour walk through pastures "
                          "and pine forest, leads you to the lake, which warms to 20°C in the summer. "
                          "Activities enjoyed here include rowing and riding the summer toboggan run.",
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),

                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[100], // light page background
      ),
    );
  }
}
