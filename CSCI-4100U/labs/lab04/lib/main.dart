import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 04 & 05',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Tweet {
  final String id;
  final String userShortName;
  final String userLongName;
  final DateTime timestamp;
  final String description;
  final String? imageURL;
  int numComments;
  int numRetweets;
  int numLikes;
  bool isLiked;
  bool isRetweeted;
  bool isFavorited;
  bool isHidden;
  final String? parentTweetId;

  Tweet({
    required this.id,
    required this.userShortName,
    required this.userLongName,
    required this.timestamp,
    required this.description,
    this.imageURL,
    this.numComments = 0,
    this.numRetweets = 0,
    this.numLikes = 0,
    this.isLiked = false,
    this.isRetweeted = false,
    this.isFavorited = false,
    this.isHidden = false,
    this.parentTweetId,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tweet> tweets = [];
  int _tweetIdCounter = 0;

  @override
  void initState() {
    super.initState();
    _generateInitialTweets();
  }

  void _generateInitialTweets() {
    tweets = [
      Tweet(
        id: '${_tweetIdCounter++}',
        userShortName: '@user1',
        userLongName: 'User One',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        description: 'This is the first tweet description.',
        imageURL: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Horses.london.750pix.jpg/330px-Horses.london.750pix.jpg',
        numComments: 5,
        numRetweets: 3,
        numLikes: 10,
      ),
      Tweet(
        id: '${_tweetIdCounter++}',
        userShortName: '@user2',
        userLongName: 'User Two',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        description: 'This is the second tweet description.',
        imageURL: null,
        numComments: 7,
        numRetweets: 5,
        numLikes: 12,
      ),
      Tweet(
        id: '${_tweetIdCounter++}',
        userShortName: '@ua',
        userLongName: 'Science Building',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        description: 'Science rules!',
        imageURL: null,
        numComments: 3,
        numRetweets: 8,
        numLikes: 25,
      ),
    ];
  }

  void _addNewTweet(Tweet tweet) {
    setState(() {
      tweets.add(tweet);
    });
  }

  void _toggleLike(String tweetId) {
    setState(() {
      final tweet = tweets.firstWhere((t) => t.id == tweetId);
      if (tweet.isLiked) {
        tweet.numLikes--;
        tweet.isLiked = false;
      } else {
        tweet.numLikes++;
        tweet.isLiked = true;
      }
    });
  }

  void _toggleRetweet(String tweetId) {
    setState(() {
      final tweet = tweets.firstWhere((t) => t.id == tweetId);
      if (tweet.isRetweeted) {
        tweet.numRetweets--;
        tweet.isRetweeted = false;
      } else {
        tweet.numRetweets++;
        tweet.isRetweeted = true;
      }
    });
  }

  void _toggleFavorite(String tweetId) {
    setState(() {
      final tweet = tweets.firstWhere((t) => t.id == tweetId);
      tweet.isFavorited = !tweet.isFavorited;
    });
  }

  void _hideTweet(String tweetId) {
    setState(() {
      final tweet = tweets.firstWhere((t) => t.id == tweetId);
      tweet.isHidden = true;
    });
  }

  void _addReply(String parentTweetId, Tweet reply) {
    setState(() {
      final parentTweet = tweets.firstWhere((t) => t.id == parentTweetId);
      parentTweet.numComments++;
      
      final parentIndex = tweets.indexWhere((t) => t.id == parentTweetId);
      tweets.insert(parentIndex + 1, reply);
    });
  }

  List<Tweet> _getSortedTweets() {
    final visibleTweets = tweets.where((t) => !t.isHidden).toList();
    
    final favorited = visibleTweets.where((t) => t.isFavorited && t.parentTweetId == null).toList();
    final nonFavorited = visibleTweets.where((t) => !t.isFavorited && t.parentTweetId == null).toList();
    
    List<Tweet> result = [];
    
    for (var favTweet in favorited) {
      result.add(favTweet);
      final replies = visibleTweets.where((t) => t.parentTweetId == favTweet.id).toList();
      result.addAll(replies);
    }
    
    for (var tweet in nonFavorited) {
      result.add(tweet);
      final replies = visibleTweets.where((t) => t.parentTweetId == tweet.id).toList();
      result.addAll(replies);
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final sortedTweets = _getSortedTweets();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newTweet = await Navigator.push<Tweet>(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTweetPage(
                    tweetId: '${_tweetIdCounter++}',
                  ),
                ),
              );
              if (newTweet != null) {
                _addNewTweet(newTweet);
              }
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: sortedTweets.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final tweet = sortedTweets[index];
          return TweetWidget(
            tweet: tweet,
            onLike: () => _toggleLike(tweet.id),
            onRetweet: () => _toggleRetweet(tweet.id),
            onFavorite: () => _toggleFavorite(tweet.id),
            onHide: () => _hideTweet(tweet.id),
            onReply: () async {
              final reply = await Navigator.push<Tweet>(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTweetPage(
                    tweetId: '${_tweetIdCounter++}',
                    parentTweetId: tweet.id,
                    replyingTo: tweet.userShortName,
                  ),
                ),
              );
              if (reply != null) {
                _addReply(tweet.id, reply);
              }
            },
          );
        },
      ),
    );
  }
}

class TweetWidget extends StatelessWidget {
  final Tweet tweet;
  final VoidCallback onLike;
  final VoidCallback onRetweet;
  final VoidCallback onFavorite;
  final VoidCallback onHide;
  final VoidCallback onReply;

  const TweetWidget({
    super.key,
    required this.tweet,
    required this.onLike,
    required this.onRetweet,
    required this.onFavorite,
    required this.onHide,
    required this.onReply,
  });

  String _getTimeString(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  void _showHideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hide Tweet'),
          content: const Text('Do you wish to hide this tweet?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onHide();
                Navigator.of(context).pop();
              },
              child: const Text('Hide'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: tweet.parentTweetId != null ? 56.0 : 12.0,
        right: 12.0,
        top: 12.0,
        bottom: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue,
            child: Text(
              tweet.userLongName[0],
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            tweet.userLongName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tweet.userShortName,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '· ${_getTimeString(tweet.timestamp)}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showHideDialog(context),
                      child: Icon(
                        Icons.expand_more,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tweet.description,
                  style: const TextStyle(fontSize: 15),
                ),
                if (tweet.imageURL != null) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      tweet.imageURL!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      Icons.chat_bubble_outline,
                      tweet.numComments,
                      Colors.grey,
                      onReply,
                    ),
                    _buildActionButton(
                      tweet.isRetweeted ? Icons.repeat : Icons.repeat,
                      tweet.numRetweets,
                      tweet.isRetweeted ? Colors.green : Colors.grey,
                      onRetweet,
                    ),
                    _buildActionButton(
                      tweet.isLiked ? Icons.favorite : Icons.favorite_border,
                      tweet.numLikes,
                      tweet.isLiked ? Colors.red : Colors.grey,
                      onLike,
                    ),
                    _buildActionButton(
                      tweet.isFavorited ? Icons.bookmark : Icons.bookmark_border,
                      0,
                      tweet.isFavorited ? Colors.blue : Colors.grey,
                      onFavorite,
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

  Widget _buildActionButton(IconData icon, int count, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Text(
              _formatNumber(count),
              style: TextStyle(color: color, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }

  String _formatNumber(int num) {
    if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(1)}K';
    }
    return num.toString();
  }
}

class CreateTweetPage extends StatefulWidget {
  final String tweetId;
  final String? parentTweetId;
  final String? replyingTo;

  const CreateTweetPage({
    super.key,
    required this.tweetId,
    this.parentTweetId,
    this.replyingTo,
  });

  @override
  State<CreateTweetPage> createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  final _formKey = GlobalKey<FormState>();
  final _userLongNameController = TextEditingController();
  final _userShortNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageURLController = TextEditingController();

  @override
  void dispose() {
    _userLongNameController.dispose();
    _userShortNameController.dispose();
    _descriptionController.dispose();
    _imageURLController.dispose();
    super.dispose();
  }

  void _submitTweet() {
    if (_formKey.currentState!.validate()) {
      final tweet = Tweet(
        id: widget.tweetId,
        userShortName: _userShortNameController.text.startsWith('@')
            ? _userShortNameController.text
            : '@${_userShortNameController.text}',
        userLongName: _userLongNameController.text,
        timestamp: DateTime.now(),
        description: _descriptionController.text,
        imageURL: _imageURLController.text.isEmpty ? null : _imageURLController.text,
        parentTweetId: widget.parentTweetId,
      );
      Navigator.pop(context, tweet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.replyingTo != null ? 'Reply' : 'Create Tweet'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _submitTweet,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Tweet'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (widget.replyingTo != null) ...[
                Text(
                  'Replying to ${widget.replyingTo}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _userLongNameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a display name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _userShortNameController,
                decoration: const InputDecoration(
                  labelText: 'Username (e.g., user123)',
                  border: OutlineInputBorder(),
                  prefixText: '@',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Tweet Text',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tweet text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageURLController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}