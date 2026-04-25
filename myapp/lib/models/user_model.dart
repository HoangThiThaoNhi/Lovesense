class User {
  final String id;
  final String name;
  final int age;
  final String bio;
  final String job;
  final List<String> imageUrls;
  final List<Map<String, dynamic>> photos;
  final List<String> interests;
  final int distanceKm;
  final bool isVerified;
  final int points;
  final String currentTitle;
  final int? height;
  final String? purpose;
  final String? livingAt;
  final String? phone;
  final String? email;
  final List<String> lookingFor;
  final String gender;
  final double matchScore;
  final bool isDNAMatch;
  final String? matchReason;
  final double? lat;
  final double? lng;
  
  // DNA Scores
  final int ambitionScore;
  final int personalityScore;
  final int careerScore;
  final int coreValuesScore;
  final int interestsScore;
  final int lifestyleScore;
  final int familyOrientationScore;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.bio,
    required this.job,
    required this.imageUrls,
    required this.photos,
    required this.interests,
    required this.distanceKm,
    this.isVerified = false,
    this.points = 0,
    this.currentTitle = 'Newbie',
    this.height,
    this.purpose,
    this.livingAt,
    this.phone,
    this.email,
    this.lookingFor = const [],
    this.gender = '',
    this.matchScore = 0.0,
    this.isDNAMatch = false,
    this.matchReason,
    this.lat,
    this.lng,
    this.ambitionScore = 0,
    this.personalityScore = 0,
    this.careerScore = 0,
    this.coreValuesScore = 0,
    this.interestsScore = 0,
    this.lifestyleScore = 0,
    this.familyOrientationScore = 0,
  });

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? bio,
    String? job,
    List<String>? imageUrls,
    List<Map<String, dynamic>>? photos,
    List<String>? interests,
    int? distanceKm,
    bool? isVerified,
    int? points,
    String? currentTitle,
    int? height,
    String? purpose,
    String? livingAt,
    String? phone,
    String? email,
    List<String>? lookingFor,
    String? gender,
    double? matchScore,
    bool? isDNAMatch,
    String? matchReason,
    double? lat,
    double? lng,
    int? ambitionScore,
    int? personalityScore,
    int? careerScore,
    int? coreValuesScore,
    int? interestsScore,
    int? lifestyleScore,
    int? familyOrientationScore,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      job: job ?? this.job,
      imageUrls: imageUrls ?? this.imageUrls,
      photos: photos ?? this.photos,
      interests: interests ?? this.interests,
      distanceKm: distanceKm ?? this.distanceKm,
      isVerified: isVerified ?? this.isVerified,
      points: points ?? this.points,
      currentTitle: currentTitle ?? this.currentTitle,
      height: height ?? this.height,
      purpose: purpose ?? this.purpose,
      livingAt: livingAt ?? this.livingAt,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      lookingFor: lookingFor ?? this.lookingFor,
      gender: gender ?? this.gender,
      matchScore: matchScore ?? this.matchScore,
      isDNAMatch: isDNAMatch ?? this.isDNAMatch,
      matchReason: matchReason ?? this.matchReason,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      ambitionScore: ambitionScore ?? this.ambitionScore,
      personalityScore: personalityScore ?? this.personalityScore,
      careerScore: careerScore ?? this.careerScore,
      coreValuesScore: coreValuesScore ?? this.coreValuesScore,
      interestsScore: interestsScore ?? this.interestsScore,
      lifestyleScore: lifestyleScore ?? this.lifestyleScore,
      familyOrientationScore: familyOrientationScore ?? this.familyOrientationScore,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      // Handle interests with safety & cleaning
      List<String> parsedInterests = [];
      final dynamic interestsData = json['interests'];
      if (interestsData != null) {
        if (interestsData is String) {
          // Clean up string if it looks like a JSON array representation
          String cleanStr = interestsData
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('"', '')
              .replaceAll("'", "");
          parsedInterests = cleanStr.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
        } else if (interestsData is List) {
          parsedInterests = interestsData.map((e) {
            String s = e?.toString() ?? '';
            return s.replaceAll('"', '').replaceAll("'", "").trim();
          }).where((e) => e.isNotEmpty).toList();
        }
      }

      // Handle photos with safety
      List<String> images = [];
      List<Map<String, dynamic>> photoObjects = [];
      final dynamic photosData = json['photos'];
      if (photosData != null && photosData is List) {
        photoObjects = photosData.map((p) => Map<String, dynamic>.from(p as Map)).toList();
        images = photoObjects.map((p) => p['image_url']?.toString() ?? '').where((url) => url.isNotEmpty).toList();
      } else {
        final String? mainPhoto = (json['image_url'] ?? json['main_photo'] ?? json['photo_url'])?.toString();
        if (mainPhoto != null && mainPhoto.isNotEmpty) {
          images = [mainPhoto];
        }
      }

      // Handle looking_for with safety & cleaning
      List<String> parsedLookingFor = [];
      final dynamic lookingForData = json['looking_for'];
      if (lookingForData != null) {
        if (lookingForData is String) {
          String cleanStr = lookingForData
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('"', '')
              .replaceAll("'", "");
          parsedLookingFor = cleanStr.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
        } else if (lookingForData is List) {
          parsedLookingFor = lookingForData.map((e) {
            String s = e?.toString() ?? '';
            return s.replaceAll('"', '').replaceAll("'", "").trim();
          }).where((e) => e.isNotEmpty).toList();
        }
      }

      // Boolean safety: Force explicit boolean conversion
      final bool verified = (json['is_verified'] == 1 || json['is_verified'] == true || json['is_verified'] == 'true');
      final bool dnaMatch = (json['is_dna_match'] == 1 || json['is_dna_match'] == true || json['is_dna_match'] == 'true');

      return User(
        id: (json['user_id'] ?? json['id'] ?? '').toString(),
        name: (json['display_name'] ?? json['name'] ?? 'User').toString(),
        age: (json['age'] as num?)?.toInt() ?? 0,
        bio: (json['bio'] ?? '').toString(),
        job: (json['occupation'] ?? json['job'] ?? '').toString(),
        imageUrls: images,
        photos: photoObjects,
        interests: parsedInterests,
        distanceKm: (json['distance_km'] as num?)?.toInt() ?? (json['distance'] as num?)?.toInt() ?? 0,
        isVerified: verified,
        points: (json['points'] as num?)?.toInt() ?? 0,
        currentTitle: (json['current_title'] ?? 'Newbie').toString(),
        height: (json['height'] as num?)?.toInt(),
        purpose: json['purpose']?.toString(),
        livingAt: json['living_at']?.toString(),
        phone: json['phone']?.toString(),
        email: json['email']?.toString(),
        lookingFor: parsedLookingFor,
        gender: (json['gender'] ?? '').toString(),
        matchScore: double.tryParse(json['match_score']?.toString() ?? '0.0') ?? 0.0,
        isDNAMatch: dnaMatch,
        matchReason: json['match_reason']?.toString(),
        lat: double.tryParse(json['lat']?.toString() ?? ''),
        lng: double.tryParse(json['lng']?.toString() ?? ''),
        ambitionScore: int.tryParse(json['ambition_score']?.toString() ?? '') ?? 0,
        personalityScore: int.tryParse(json['personality_score']?.toString() ?? '') ?? 0,
        careerScore: int.tryParse(json['career_score']?.toString() ?? '') ?? 0,
        coreValuesScore: int.tryParse(json['core_values_score']?.toString() ?? '') ?? 0,
        interestsScore: int.tryParse(json['interests_score']?.toString() ?? '') ?? 0,
        lifestyleScore: int.tryParse(json['lifestyle_score']?.toString() ?? '') ?? 0,
        familyOrientationScore: int.tryParse(json['family_orientation_score']?.toString() ?? '') ?? 0,
      );
    } catch (e) {
      print('CRITICAL ERROR parsing user: $e');
      return User(
        id: 'error',
        name: 'Error User',
        age: 0,
        bio: '',
        job: '',
        imageUrls: [],
        photos: [],
        interests: [],
        distanceKm: 0,
        isVerified: false,
        isDNAMatch: false,
      );
    }
  }
}