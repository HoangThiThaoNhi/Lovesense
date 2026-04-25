USE lovesense;

-- Clear existing data to prevent duplicates
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM photos;
DELETE FROM profiles;
DELETE FROM swipes;
DELETE FROM matches;
DELETE FROM surveys;
DELETE FROM notifications;
DELETE FROM users;
SET FOREIGN_KEY_CHECKS = 1;

-- User 1
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0798300753', 0.21, 0.59, 0.52, 0.57, 0.07, '{"ambition":0.21,"family":0.59,"physical_touch":0.52,"introvert_extrovert":0.57,"loyalty":0.07}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 1', 35, 'female', 'Developer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.89968688188914, 10.9915342709292), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 2
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0433871700', 0.35, 0.74, 0.26, 0.44, 0.70, '{"ambition":0.35,"family":0.74,"physical_touch":0.26,"introvert_extrovert":0.44,"loyalty":0.7}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 2', 26, 'other', 'Developer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.52761272633013, 10.693265076089798), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 3
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0416279722', 0.94, 0.31, 0.43, 0.94, 0.16, '{"ambition":0.94,"family":0.31,"physical_touch":0.43,"introvert_extrovert":0.94,"loyalty":0.16}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 3', 32, 'other', 'Giáo viên', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.81560330052, 10.93247773095011), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 4
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0553059285', 1.00, 0.47, 0.59, 0.80, 0.85, '{"ambition":1,"family":0.47,"physical_touch":0.59,"introvert_extrovert":0.8,"loyalty":0.85}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 4', 34, 'other', 'Sinh viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.62183529617684, 10.614698556381612), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 5
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0787283498', 0.04, 0.49, 0.25, 0.22, 0.65, '{"ambition":0.04,"family":0.49,"physical_touch":0.25,"introvert_extrovert":0.22,"loyalty":0.65}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 5', 19, 'other', 'Giáo viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.64884247981965, 10.619216632706891), '["Ẩm thực","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 6
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0945646272', 0.46, 0.85, 0.94, 0.06, 0.57, '{"ambition":0.46,"family":0.85,"physical_touch":0.94,"introvert_extrovert":0.06,"loyalty":0.57}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 6', 31, 'female', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.76782797644309, 10.936399382025707), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 7
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0687221263', 0.24, 0.16, 0.51, 0.28, 0.95, '{"ambition":0.24,"family":0.16,"physical_touch":0.51,"introvert_extrovert":0.28,"loyalty":0.95}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 7', 32, 'male', 'Designer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.69234228643825, 10.563789207503408), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 8
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0235709804', 0.05, 0.03, 0.74, 0.55, 0.20, '{"ambition":0.05,"family":0.03,"physical_touch":0.74,"introvert_extrovert":0.55,"loyalty":0.2}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 8', 34, 'female', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.6602561197666, 10.773420311954716), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 9
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0190898808', 0.16, 0.58, 0.94, 0.20, 0.03, '{"ambition":0.16,"family":0.58,"physical_touch":0.94,"introvert_extrovert":0.2,"loyalty":0.03}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 9', 24, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.49038768595159, 11.011229739445334), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 10
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0628503004', 0.63, 0.80, 0.32, 0.76, 0.27, '{"ambition":0.63,"family":0.8,"physical_touch":0.32,"introvert_extrovert":0.76,"loyalty":0.27}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 10', 28, 'other', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.65878840609568, 10.681730121733267), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 11
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0363673768', 0.72, 0.20, 0.50, 0.10, 0.03, '{"ambition":0.72,"family":0.2,"physical_touch":0.5,"introvert_extrovert":0.1,"loyalty":0.03}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 11', 33, 'female', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.86301387068394, 10.657430254973137), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 12
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0312585295', 0.40, 0.83, 0.49, 0.51, 0.21, '{"ambition":0.4,"family":0.83,"physical_touch":0.49,"introvert_extrovert":0.51,"loyalty":0.21}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 12', 32, 'other', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.57321013780205, 10.86179837184592), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 13
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0227684499', 0.35, 0.08, 0.22, 0.55, 0.57, '{"ambition":0.35,"family":0.08,"physical_touch":0.22,"introvert_extrovert":0.55,"loyalty":0.57}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 13', 32, 'other', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.43396507016945, 10.863502568609647), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 14
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0677029121', 0.15, 0.83, 0.97, 0.48, 0.63, '{"ambition":0.15,"family":0.83,"physical_touch":0.97,"introvert_extrovert":0.48,"loyalty":0.63}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 14', 18, 'female', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.78693265100763, 10.61679806533728), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 15
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0801228194', 0.64, 0.58, 0.60, 0.07, 0.40, '{"ambition":0.64,"family":0.58,"physical_touch":0.6,"introvert_extrovert":0.07,"loyalty":0.4}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 15', 24, 'male', 'Designer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.73534787385883, 10.517033633230717), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 16
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0941272927', 0.26, 0.56, 0.38, 0.04, 0.08, '{"ambition":0.26,"family":0.56,"physical_touch":0.38,"introvert_extrovert":0.04,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 16', 24, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.44565370926529, 10.549976547170738), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 17
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0991522727', 0.75, 0.02, 0.91, 0.16, 0.45, '{"ambition":0.75,"family":0.02,"physical_touch":0.91,"introvert_extrovert":0.16,"loyalty":0.45}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 17', 25, 'other', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.83972367686384, 10.856974376115284), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 18
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0919716165', 0.25, 0.41, 0.67, 0.33, 0.50, '{"ambition":0.25,"family":0.41,"physical_touch":0.67,"introvert_extrovert":0.33,"loyalty":0.5}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 18', 36, 'male', 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.45587082493525, 10.755382877577759), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 19
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0491269714', 0.37, 0.49, 0.59, 0.08, 0.31, '{"ambition":0.37,"family":0.49,"physical_touch":0.59,"introvert_extrovert":0.08,"loyalty":0.31}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 19', 35, 'male', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.61657239946206, 10.527893263757885), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 20
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0765536178', 0.83, 0.40, 0.03, 0.85, 0.75, '{"ambition":0.83,"family":0.4,"physical_touch":0.03,"introvert_extrovert":0.85,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 20', 21, 'female', 'Sinh viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.43127921925533, 10.817739858088789), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 21
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0851090780', 0.40, 0.84, 0.24, 0.46, 0.81, '{"ambition":0.4,"family":0.84,"physical_touch":0.24,"introvert_extrovert":0.46,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 21', 26, 'female', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.67920198620007, 10.52744000178127), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 22
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0471575467', 0.77, 0.89, 0.59, 0.61, 0.26, '{"ambition":0.77,"family":0.89,"physical_touch":0.59,"introvert_extrovert":0.61,"loyalty":0.26}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 22', 32, 'female', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.87574167833769, 10.73466439123499), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 23
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0426400810', 0.57, 0.89, 0.47, 0.61, 0.26, '{"ambition":0.57,"family":0.89,"physical_touch":0.47,"introvert_extrovert":0.61,"loyalty":0.26}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 23', 31, 'female', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.48712365403689, 10.819358643609677), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 24
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0365503660', 0.26, 0.93, 0.81, 0.41, 0.17, '{"ambition":0.26,"family":0.93,"physical_touch":0.81,"introvert_extrovert":0.41,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 24', 29, 'other', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.48228755577257, 10.628955377276101), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 25
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0605868932', 0.09, 0.37, 0.18, 0.31, 0.02, '{"ambition":0.09,"family":0.37,"physical_touch":0.18,"introvert_extrovert":0.31,"loyalty":0.02}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 25', 37, 'female', 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.89624951452811, 10.528258298715043), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 26
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0786762590', 0.11, 0.52, 0.68, 0.37, 0.16, '{"ambition":0.11,"family":0.52,"physical_touch":0.68,"introvert_extrovert":0.37,"loyalty":0.16}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 26', 24, 'female', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.42094010768753, 10.550084087859064), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 27
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0600612912', 0.91, 0.89, 0.66, 0.73, 0.23, '{"ambition":0.91,"family":0.89,"physical_touch":0.66,"introvert_extrovert":0.73,"loyalty":0.23}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 27', 24, 'other', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.78772960537043, 11.005470481786391), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 28
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0390773412', 0.43, 0.93, 0.16, 0.82, 0.23, '{"ambition":0.43,"family":0.93,"physical_touch":0.16,"introvert_extrovert":0.82,"loyalty":0.23}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 28', 24, 'other', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.84641383801039, 10.715166955297255), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 29
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0974261865', 0.91, 0.63, 0.75, 0.82, 0.70, '{"ambition":0.91,"family":0.63,"physical_touch":0.75,"introvert_extrovert":0.82,"loyalty":0.7}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 29', 24, 'male', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.7796696670131, 10.603484102465085), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 30
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0593121849', 0.43, 0.70, 0.11, 0.25, 0.63, '{"ambition":0.43,"family":0.7,"physical_touch":0.11,"introvert_extrovert":0.25,"loyalty":0.63}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 30', 19, 'other', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.83320009586551, 10.678682026614261), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 31
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0136486312', 0.90, 0.06, 0.90, 0.60, 0.13, '{"ambition":0.9,"family":0.06,"physical_touch":0.9,"introvert_extrovert":0.6,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 31', 29, 'female', 'Designer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.90748374808199, 10.973754171102254), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 32
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0625304784', 0.94, 0.93, 0.29, 0.10, 0.91, '{"ambition":0.94,"family":0.93,"physical_touch":0.29,"introvert_extrovert":0.1,"loyalty":0.91}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 32', 38, 'female', 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.86976062325532, 10.752477422551497), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 33
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0412676133', 0.08, 0.24, 0.58, 0.52, 0.96, '{"ambition":0.08,"family":0.24,"physical_touch":0.58,"introvert_extrovert":0.52,"loyalty":0.96}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 33', 33, 'female', 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.73836708607627, 10.952356887008056), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 34
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0770454849', 0.89, 0.79, 0.61, 0.71, 0.35, '{"ambition":0.89,"family":0.79,"physical_touch":0.61,"introvert_extrovert":0.71,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 34', 36, 'other', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.50277930967113, 10.702969181930476), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 35
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0982427373', 0.85, 0.63, 0.46, 0.36, 0.36, '{"ambition":0.85,"family":0.63,"physical_touch":0.46,"introvert_extrovert":0.36,"loyalty":0.36}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 35', 18, 'female', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.60125036286884, 10.936800202076203), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 36
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0292012341', 0.94, 0.15, 0.60, 0.86, 0.72, '{"ambition":0.94,"family":0.15,"physical_touch":0.6,"introvert_extrovert":0.86,"loyalty":0.72}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 36', 33, 'other', 'Designer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.62430793204838, 10.800194655731959), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 37
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0870318152', 0.81, 0.57, 0.61, 0.53, 0.08, '{"ambition":0.81,"family":0.57,"physical_touch":0.61,"introvert_extrovert":0.53,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 37', 31, 'female', 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.41155744545748, 10.64418511663419), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 38
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0457218811', 0.90, 0.79, 0.34, 0.76, 0.65, '{"ambition":0.9,"family":0.79,"physical_touch":0.34,"introvert_extrovert":0.76,"loyalty":0.65}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 38', 20, 'female', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.42004438424325, 10.695374563520572), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 39
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0867384335', 0.25, 0.38, 0.70, 0.42, 0.91, '{"ambition":0.25,"family":0.38,"physical_touch":0.7,"introvert_extrovert":0.42,"loyalty":0.91}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 39', 27, 'other', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.53486968106387, 10.810271245615507), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 40
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0222894646', 0.78, 0.49, 0.97, 0.44, 0.21, '{"ambition":0.78,"family":0.49,"physical_touch":0.97,"introvert_extrovert":0.44,"loyalty":0.21}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 40', 29, 'other', 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.90465527475793, 10.530946122193525), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 41
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0390135719', 0.17, 0.11, 0.93, 0.64, 0.38, '{"ambition":0.17,"family":0.11,"physical_touch":0.93,"introvert_extrovert":0.64,"loyalty":0.38}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 41', 21, 'other', 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.55778178015004, 11.008411880046884), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 42
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0159204244', 0.15, 0.10, 0.96, 0.88, 0.43, '{"ambition":0.15,"family":0.1,"physical_touch":0.96,"introvert_extrovert":0.88,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 42', 34, 'other', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.45156216217416, 10.98299570564809), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 43
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0642846683', 0.43, 0.02, 0.40, 0.27, 0.26, '{"ambition":0.43,"family":0.02,"physical_touch":0.4,"introvert_extrovert":0.27,"loyalty":0.26}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 43', 27, 'male', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.50851083766577, 10.733596687594291), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 44
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0913188061', 0.01, 0.56, 0.87, 0.17, 0.81, '{"ambition":0.01,"family":0.56,"physical_touch":0.87,"introvert_extrovert":0.17,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 44', 32, 'other', 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.66993236460218, 10.954485513607729), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 45
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0465203767', 0.88, 0.95, 0.95, 0.61, 1.00, '{"ambition":0.88,"family":0.95,"physical_touch":0.95,"introvert_extrovert":0.61,"loyalty":1}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 45', 33, 'other', 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.44255463266695, 10.937377439945354), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 46
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0619845396', 0.27, 0.38, 0.05, 0.06, 0.55, '{"ambition":0.27,"family":0.38,"physical_touch":0.05,"introvert_extrovert":0.06,"loyalty":0.55}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 46', 19, 'female', 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.88582983574065, 10.845255515115397), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 47
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0770552791', 0.45, 0.56, 0.84, 0.36, 0.81, '{"ambition":0.45,"family":0.56,"physical_touch":0.84,"introvert_extrovert":0.36,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 47', 39, 'female', 'Bác sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.83694121958155, 10.569590935602095), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 48
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0131760324', 0.88, 0.32, 0.51, 0.27, 0.51, '{"ambition":0.88,"family":0.32,"physical_touch":0.51,"introvert_extrovert":0.27,"loyalty":0.51}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 48', 20, 'female', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.51705957259273, 10.60931788600245), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 49
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0652401034', 0.02, 0.56, 0.76, 0.47, 0.75, '{"ambition":0.02,"family":0.56,"physical_touch":0.76,"introvert_extrovert":0.47,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 49', 26, 'male', 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.7791027030716, 10.653715321579673), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 50
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0148446897', 0.48, 0.24, 0.38, 0.96, 0.88, '{"ambition":0.48,"family":0.24,"physical_touch":0.38,"introvert_extrovert":0.96,"loyalty":0.88}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 50', 31, 'other', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.81357714952976, 10.573338517071956), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 51
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0405211839', 0.70, 0.34, 0.40, 0.08, 0.91, '{"ambition":0.7,"family":0.34,"physical_touch":0.4,"introvert_extrovert":0.08,"loyalty":0.91}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 51', 34, 'female', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.60100875333137, 10.924686866543974), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 52
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0922098840', 0.24, 0.10, 0.04, 0.20, 0.22, '{"ambition":0.24,"family":0.1,"physical_touch":0.04,"introvert_extrovert":0.2,"loyalty":0.22}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 52', 19, 'male', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.82634936971353, 10.678246286227765), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 53
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0700898244', 0.35, 0.15, 0.84, 0.47, 0.80, '{"ambition":0.35,"family":0.15,"physical_touch":0.84,"introvert_extrovert":0.47,"loyalty":0.8}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 53', 35, 'female', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.77046956921411, 10.552893967114455), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 54
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0794735842', 0.68, 0.57, 0.13, 0.05, 0.55, '{"ambition":0.68,"family":0.57,"physical_touch":0.13,"introvert_extrovert":0.05,"loyalty":0.55}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 54', 23, 'female', 'Designer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.69796962459526, 10.525491647623056), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 55
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0167812249', 0.64, 0.93, 0.25, 0.76, 0.39, '{"ambition":0.64,"family":0.93,"physical_touch":0.25,"introvert_extrovert":0.76,"loyalty":0.39}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 55', 32, 'male', 'Bác sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.47782681134348, 10.948232730205211), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 56
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0220263902', 0.77, 0.58, 0.51, 0.89, 0.74, '{"ambition":0.77,"family":0.58,"physical_touch":0.51,"introvert_extrovert":0.89,"loyalty":0.74}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 56', 35, 'male', 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.57815111855085, 10.828300719323526), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 57
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0517463531', 0.60, 0.78, 0.04, 0.65, 0.19, '{"ambition":0.6,"family":0.78,"physical_touch":0.04,"introvert_extrovert":0.65,"loyalty":0.19}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 57', 33, 'female', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.67188982143827, 10.65947807403144), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 58
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0227828909', 0.41, 0.27, 0.52, 0.76, 0.60, '{"ambition":0.41,"family":0.27,"physical_touch":0.52,"introvert_extrovert":0.76,"loyalty":0.6}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 58', 30, 'other', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.77532829707704, 10.547439086823584), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 59
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0574410523', 0.90, 0.75, 0.52, 0.76, 0.69, '{"ambition":0.9,"family":0.75,"physical_touch":0.52,"introvert_extrovert":0.76,"loyalty":0.69}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 59', 35, 'male', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.79805067677891, 10.913742639007564), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 60
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0678739633', 0.84, 0.79, 0.31, 0.77, 0.84, '{"ambition":0.84,"family":0.79,"physical_touch":0.31,"introvert_extrovert":0.77,"loyalty":0.84}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 60', 21, 'male', 'Kinh doanh', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.58850426046641, 10.91399430314704), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 61
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0240416059', 0.94, 0.17, 0.86, 0.92, 0.47, '{"ambition":0.94,"family":0.17,"physical_touch":0.86,"introvert_extrovert":0.92,"loyalty":0.47}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 61', 25, 'male', 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.51390720295353, 10.717633698709262), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 62
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0367482234', 0.91, 0.85, 0.57, 0.69, 0.85, '{"ambition":0.91,"family":0.85,"physical_touch":0.57,"introvert_extrovert":0.69,"loyalty":0.85}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 62', 21, 'male', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.59073848728794, 10.906146311182585), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 63
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0765902684', 0.78, 0.14, 0.54, 0.09, 0.74, '{"ambition":0.78,"family":0.14,"physical_touch":0.54,"introvert_extrovert":0.09,"loyalty":0.74}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 63', 27, 'male', 'Sinh viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.7481415621646, 10.956079669665568), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 64
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0898713335', 0.45, 0.03, 1.00, 0.44, 0.47, '{"ambition":0.45,"family":0.03,"physical_touch":1,"introvert_extrovert":0.44,"loyalty":0.47}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 64', 24, 'other', 'Giáo viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.58803115736022, 10.656114189762855), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 65
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0122002559', 0.82, 0.29, 0.21, 0.77, 0.43, '{"ambition":0.82,"family":0.29,"physical_touch":0.21,"introvert_extrovert":0.77,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 65', 21, 'female', 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.80225352860903, 10.54595753850886), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 66
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0779001315', 0.74, 0.28, 0.66, 0.41, 0.42, '{"ambition":0.74,"family":0.28,"physical_touch":0.66,"introvert_extrovert":0.41,"loyalty":0.42}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 66', 32, 'male', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.44899277951325, 10.829712119490324), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 67
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0956221936', 0.05, 0.84, 0.32, 0.63, 0.42, '{"ambition":0.05,"family":0.84,"physical_touch":0.32,"introvert_extrovert":0.63,"loyalty":0.42}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 67', 19, 'male', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.59649612199148, 10.849111410440937), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 68
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0386214261', 0.71, 0.33, 0.93, 0.45, 0.73, '{"ambition":0.71,"family":0.33,"physical_touch":0.93,"introvert_extrovert":0.45,"loyalty":0.73}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 68', 32, 'other', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.63580905031897, 10.631057749469354), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 69
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0973856621', 0.28, 0.51, 0.82, 0.47, 0.15, '{"ambition":0.28,"family":0.51,"physical_touch":0.82,"introvert_extrovert":0.47,"loyalty":0.15}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 69', 23, 'female', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.44436450225805, 10.847222598798092), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 70
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0310206377', 0.04, 0.59, 0.99, 0.40, 0.78, '{"ambition":0.04,"family":0.59,"physical_touch":0.99,"introvert_extrovert":0.4,"loyalty":0.78}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 70', 30, 'other', 'Developer', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.78837540628908, 10.842983265075002), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 71
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0913750510', 0.85, 0.22, 0.06, 0.64, 0.27, '{"ambition":0.85,"family":0.22,"physical_touch":0.06,"introvert_extrovert":0.64,"loyalty":0.27}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 71', 20, 'other', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.5312572674686, 10.693341126622117), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 72
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0529160525', 0.55, 0.21, 0.36, 0.44, 0.34, '{"ambition":0.55,"family":0.21,"physical_touch":0.36,"introvert_extrovert":0.44,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 72', 24, 'male', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.53803885486039, 10.705101130509117), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 73
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0606280772', 0.35, 0.85, 0.14, 0.75, 0.81, '{"ambition":0.35,"family":0.85,"physical_touch":0.14,"introvert_extrovert":0.75,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 73', 18, 'male', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.72159097716995, 10.542225510036973), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 74
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0589658244', 0.78, 0.29, 0.05, 0.32, 0.93, '{"ambition":0.78,"family":0.29,"physical_touch":0.05,"introvert_extrovert":0.32,"loyalty":0.93}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 74', 37, 'male', 'Developer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.73615060487495, 10.951894366472361), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 75
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0457548179', 0.13, 0.41, 0.27, 0.70, 0.95, '{"ambition":0.13,"family":0.41,"physical_touch":0.27,"introvert_extrovert":0.7,"loyalty":0.95}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 75', 31, 'female', 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.78960428117601, 10.760699198925126), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 76
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0860518501', 0.39, 0.19, 0.77, 0.02, 0.73, '{"ambition":0.39,"family":0.19,"physical_touch":0.77,"introvert_extrovert":0.02,"loyalty":0.73}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 76', 27, 'other', 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.7246563899619, 10.572429103769604), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 77
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0514182505', 0.49, 0.26, 0.65, 0.19, 0.58, '{"ambition":0.49,"family":0.26,"physical_touch":0.65,"introvert_extrovert":0.19,"loyalty":0.58}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 77', 26, 'female', 'Developer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.56579527771811, 10.562290764734868), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 78
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0362198594', 0.47, 0.77, 0.83, 0.40, 0.56, '{"ambition":0.47,"family":0.77,"physical_touch":0.83,"introvert_extrovert":0.4,"loyalty":0.56}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 78', 19, 'female', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.80662403191566, 10.5316294877501), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 79
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0206615132', 0.75, 0.12, 0.35, 0.11, 0.07, '{"ambition":0.75,"family":0.12,"physical_touch":0.35,"introvert_extrovert":0.11,"loyalty":0.07}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 79', 25, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.89215650020316, 10.755408806693477), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 80
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0627335267', 0.45, 0.82, 0.93, 0.92, 0.09, '{"ambition":0.45,"family":0.82,"physical_touch":0.93,"introvert_extrovert":0.92,"loyalty":0.09}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 80', 38, 'male', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.41135764492466, 10.702220038502087), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 81
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0735855521', 0.28, 0.34, 0.59, 0.64, 0.74, '{"ambition":0.28,"family":0.34,"physical_touch":0.59,"introvert_extrovert":0.64,"loyalty":0.74}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 81', 29, 'male', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.68125033362323, 10.776934851040547), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 82
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0133752597', 0.22, 0.30, 0.13, 0.78, 0.35, '{"ambition":0.22,"family":0.3,"physical_touch":0.13,"introvert_extrovert":0.78,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 82', 39, 'other', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.85927609336504, 10.876262466920657), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 83
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0777245352', 0.98, 0.61, 0.34, 0.50, 0.13, '{"ambition":0.98,"family":0.61,"physical_touch":0.34,"introvert_extrovert":0.5,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 83', 38, 'male', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.85388343195145, 10.85037719909543), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 84
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0717906326', 0.73, 0.31, 0.23, 0.29, 0.35, '{"ambition":0.73,"family":0.31,"physical_touch":0.23,"introvert_extrovert":0.29,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 84', 31, 'male', 'Bác sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.52832690758899, 10.710375488687827), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 85
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0147898680', 0.84, 0.04, 0.53, 0.77, 0.01, '{"ambition":0.84,"family":0.04,"physical_touch":0.53,"introvert_extrovert":0.77,"loyalty":0.01}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 85', 26, 'male', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.74096252990392, 10.981220296598872), '["Ẩm thực","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 86
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0300797333', 0.18, 0.19, 0.05, 0.21, 0.95, '{"ambition":0.18,"family":0.19,"physical_touch":0.05,"introvert_extrovert":0.21,"loyalty":0.95}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 86', 24, 'female', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.83803220699832, 10.891540589496932), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 87
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0143841769', 0.30, 0.59, 0.20, 0.67, 0.17, '{"ambition":0.3,"family":0.59,"physical_touch":0.2,"introvert_extrovert":0.67,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 87', 23, 'other', 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.83224972522947, 10.744343265068522), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 88
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0671709810', 0.84, 0.55, 0.65, 0.95, 0.75, '{"ambition":0.84,"family":0.55,"physical_touch":0.65,"introvert_extrovert":0.95,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 88', 39, 'other', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.56695381850086, 10.659389484684057), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 89
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0997525293', 0.26, 0.37, 0.55, 0.17, 0.77, '{"ambition":0.26,"family":0.37,"physical_touch":0.55,"introvert_extrovert":0.17,"loyalty":0.77}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 89', 21, 'other', 'Developer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.90624756619117, 10.846139738737834), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 90
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0786954743', 0.14, 0.15, 0.63, 0.58, 0.99, '{"ambition":0.14,"family":0.15,"physical_touch":0.63,"introvert_extrovert":0.58,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 90', 36, 'other', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.53784300449055, 10.60373978257877), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 91
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0488439378', 0.79, 0.13, 0.24, 0.06, 0.54, '{"ambition":0.79,"family":0.13,"physical_touch":0.24,"introvert_extrovert":0.06,"loyalty":0.54}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 91', 33, 'other', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.51659893561045, 10.693380677113844), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 92
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0859105528', 0.07, 0.72, 0.03, 0.02, 0.96, '{"ambition":0.07,"family":0.72,"physical_touch":0.03,"introvert_extrovert":0.02,"loyalty":0.96}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 92', 31, 'other', 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.90480428677998, 10.887022575138944), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 93
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0254866437', 0.13, 0.33, 0.62, 0.14, 0.77, '{"ambition":0.13,"family":0.33,"physical_touch":0.62,"introvert_extrovert":0.14,"loyalty":0.77}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 93', 39, 'female', 'Developer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.47509696040757, 10.592050958676618), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 94
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0938535778', 0.62, 0.64, 0.27, 0.60, 0.55, '{"ambition":0.62,"family":0.64,"physical_touch":0.27,"introvert_extrovert":0.6,"loyalty":0.55}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 94', 24, 'female', 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.6066913738641, 11.000144571532074), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 95
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0265725725', 0.84, 0.74, 0.34, 0.18, 0.39, '{"ambition":0.84,"family":0.74,"physical_touch":0.34,"introvert_extrovert":0.18,"loyalty":0.39}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 95', 30, 'other', 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.88667191002001, 10.520753539958642), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 96
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0601772429', 0.47, 0.87, 0.00, 0.66, 0.76, '{"ambition":0.47,"family":0.87,"physical_touch":0,"introvert_extrovert":0.66,"loyalty":0.76}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 96', 33, 'other', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.4373420606564, 10.709324045074673), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 97
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0573450902', 0.25, 0.40, 0.51, 0.90, 0.17, '{"ambition":0.25,"family":0.4,"physical_touch":0.51,"introvert_extrovert":0.9,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 97', 26, 'male', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.63233112314659, 10.800513982217685), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 98
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0984414021', 0.37, 0.34, 0.86, 0.45, 0.82, '{"ambition":0.37,"family":0.34,"physical_touch":0.86,"introvert_extrovert":0.45,"loyalty":0.82}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 98', 33, 'female', 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.80149114719012, 10.818526712795405), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 99
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0153879740', 0.32, 0.92, 0.56, 0.28, 0.29, '{"ambition":0.32,"family":0.92,"physical_touch":0.56,"introvert_extrovert":0.28,"loyalty":0.29}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 99', 34, 'male', 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.88206498581334, 10.837438775912398), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 100
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0972444671', 0.87, 0.71, 0.03, 0.87, 0.45, '{"ambition":0.87,"family":0.71,"physical_touch":0.03,"introvert_extrovert":0.87,"loyalty":0.45}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 100', 20, 'male', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.77658595636635, 10.530569488612166), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 101
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0145456329', 0.18, 0.89, 0.69, 0.73, 0.50, '{"ambition":0.18,"family":0.89,"physical_touch":0.69,"introvert_extrovert":0.73,"loyalty":0.5}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 101', 30, 'other', 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.70554661895655, 10.630375103541978), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 102
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0323039699', 0.12, 0.84, 0.79, 0.46, 0.98, '{"ambition":0.12,"family":0.84,"physical_touch":0.79,"introvert_extrovert":0.46,"loyalty":0.98}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 102', 38, 'female', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.54607832011898, 10.926443897536554), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 103
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0712595388', 0.68, 0.44, 0.94, 0.15, 0.34, '{"ambition":0.68,"family":0.44,"physical_touch":0.94,"introvert_extrovert":0.15,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 103', 30, 'other', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.81653388906352, 10.826208901491896), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 104
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0738841215', 0.89, 0.19, 0.43, 0.76, 0.65, '{"ambition":0.89,"family":0.19,"physical_touch":0.43,"introvert_extrovert":0.76,"loyalty":0.65}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 104', 20, 'other', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.59862700571492, 10.891778856270227), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 105
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0119067884', 0.87, 0.37, 0.98, 0.29, 0.51, '{"ambition":0.87,"family":0.37,"physical_touch":0.98,"introvert_extrovert":0.29,"loyalty":0.51}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 105', 25, 'other', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.72199913383561, 10.986900086266965), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 106
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0386489742', 0.79, 0.81, 0.25, 0.99, 0.11, '{"ambition":0.79,"family":0.81,"physical_touch":0.25,"introvert_extrovert":0.99,"loyalty":0.11}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 106', 35, 'other', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.47548846612894, 10.668453809036855), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 107
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0821665847', 0.72, 0.23, 0.17, 0.12, 0.08, '{"ambition":0.72,"family":0.23,"physical_touch":0.17,"introvert_extrovert":0.12,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 107', 30, 'other', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.71079765215151, 10.823340070352394), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 108
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0444967628', 0.03, 0.49, 0.02, 0.33, 0.59, '{"ambition":0.03,"family":0.49,"physical_touch":0.02,"introvert_extrovert":0.33,"loyalty":0.59}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 108', 31, 'female', 'Sinh viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.67849135325542, 10.998213142208911), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 109
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0920180266', 0.67, 0.03, 0.17, 0.19, 0.62, '{"ambition":0.67,"family":0.03,"physical_touch":0.17,"introvert_extrovert":0.19,"loyalty":0.62}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 109', 20, 'male', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.82239673691335, 10.730913022507188), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 110
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0515338212', 0.41, 0.90, 0.15, 0.72, 0.79, '{"ambition":0.41,"family":0.9,"physical_touch":0.15,"introvert_extrovert":0.72,"loyalty":0.79}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 110', 36, 'other', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.74141064038069, 10.53180266097142), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 111
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0226590599', 0.35, 0.05, 0.89, 0.78, 0.43, '{"ambition":0.35,"family":0.05,"physical_touch":0.89,"introvert_extrovert":0.78,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 111', 38, 'male', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.86948123073917, 10.671210137591697), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 112
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0125143206', 0.87, 0.87, 0.82, 0.63, 0.84, '{"ambition":0.87,"family":0.87,"physical_touch":0.82,"introvert_extrovert":0.63,"loyalty":0.84}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 112', 22, 'male', 'Bác sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.60053298051658, 10.9824299039568), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 113
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0540508946', 0.57, 0.75, 0.50, 0.24, 0.81, '{"ambition":0.57,"family":0.75,"physical_touch":0.5,"introvert_extrovert":0.24,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 113', 34, 'female', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.48730010954719, 10.738704315563448), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 114
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0258822047', 0.73, 0.20, 0.39, 0.53, 0.36, '{"ambition":0.73,"family":0.2,"physical_touch":0.39,"introvert_extrovert":0.53,"loyalty":0.36}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 114', 35, 'female', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.4640752017958, 10.773242824089467), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 115
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0303695722', 0.83, 0.43, 0.07, 0.23, 0.68, '{"ambition":0.83,"family":0.43,"physical_touch":0.07,"introvert_extrovert":0.23,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 115', 29, 'other', 'Designer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.5635695309481, 10.92170134557219), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 116
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0409687617', 0.25, 0.72, 0.92, 0.64, 0.38, '{"ambition":0.25,"family":0.72,"physical_touch":0.92,"introvert_extrovert":0.64,"loyalty":0.38}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 116', 28, 'male', 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.8614532634122, 10.698154177825607), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 117
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0956142869', 0.70, 0.51, 0.30, 0.19, 0.57, '{"ambition":0.7,"family":0.51,"physical_touch":0.3,"introvert_extrovert":0.19,"loyalty":0.57}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 117', 39, 'male', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.55576249914195, 10.89613423231839), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 118
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0925954721', 0.86, 0.82, 0.99, 0.17, 0.78, '{"ambition":0.86,"family":0.82,"physical_touch":0.99,"introvert_extrovert":0.17,"loyalty":0.78}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 118', 20, 'male', 'Designer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.55403353928828, 10.537133631935033), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 119
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0835572101', 0.91, 0.26, 0.22, 0.44, 0.81, '{"ambition":0.91,"family":0.26,"physical_touch":0.22,"introvert_extrovert":0.44,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 119', 25, 'male', 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.58543394909758, 10.747655808054617), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 120
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0429187804', 0.89, 0.68, 0.13, 0.18, 0.79, '{"ambition":0.89,"family":0.68,"physical_touch":0.13,"introvert_extrovert":0.18,"loyalty":0.79}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 120', 26, 'male', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.84887969039399, 10.740565500728502), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 121
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0660904443', 0.05, 0.49, 0.88, 0.35, 0.89, '{"ambition":0.05,"family":0.49,"physical_touch":0.88,"introvert_extrovert":0.35,"loyalty":0.89}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 121', 20, 'female', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.83450160588438, 10.679375179259267), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 122
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0978495631', 0.96, 0.49, 0.41, 0.88, 0.01, '{"ambition":0.96,"family":0.49,"physical_touch":0.41,"introvert_extrovert":0.88,"loyalty":0.01}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 122', 34, 'other', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.64711732021884, 10.755699185571869), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 123
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0151891298', 0.97, 0.30, 0.39, 0.24, 0.49, '{"ambition":0.97,"family":0.3,"physical_touch":0.39,"introvert_extrovert":0.24,"loyalty":0.49}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 123', 35, 'male', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.75211593947552, 10.63394565136206), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 124
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0532217834', 0.22, 0.13, 0.86, 0.63, 0.62, '{"ambition":0.22,"family":0.13,"physical_touch":0.86,"introvert_extrovert":0.63,"loyalty":0.62}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 124', 30, 'male', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.53083852823575, 10.717050320293355), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 125
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0200382838', 0.55, 0.66, 0.92, 0.03, 0.88, '{"ambition":0.55,"family":0.66,"physical_touch":0.92,"introvert_extrovert":0.03,"loyalty":0.88}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 125', 22, 'other', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.45551029262155, 10.749623710352518), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 126
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0728500201', 0.58, 0.84, 0.55, 0.55, 0.02, '{"ambition":0.58,"family":0.84,"physical_touch":0.55,"introvert_extrovert":0.55,"loyalty":0.02}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 126', 20, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.79190163936264, 10.548429304678777), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 127
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0897645542', 0.11, 0.81, 0.08, 0.66, 0.81, '{"ambition":0.11,"family":0.81,"physical_touch":0.08,"introvert_extrovert":0.66,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 127', 32, 'other', 'Giáo viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.68650971000748, 10.894667378532647), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 128
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0567919611', 0.43, 0.79, 0.49, 0.51, 0.66, '{"ambition":0.43,"family":0.79,"physical_touch":0.49,"introvert_extrovert":0.51,"loyalty":0.66}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 128', 39, 'female', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.45140335127319, 10.973957473228454), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 129
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0130803599', 0.57, 0.05, 0.20, 0.15, 0.21, '{"ambition":0.57,"family":0.05,"physical_touch":0.2,"introvert_extrovert":0.15,"loyalty":0.21}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 129', 35, 'female', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.65809682702323, 10.647663863092411), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 130
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0329764944', 0.26, 1.00, 0.60, 0.78, 0.42, '{"ambition":0.26,"family":1,"physical_touch":0.6,"introvert_extrovert":0.78,"loyalty":0.42}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 130', 38, 'female', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.72643587711366, 10.521647124349203), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 131
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0180501802', 0.42, 0.76, 0.74, 0.12, 0.88, '{"ambition":0.42,"family":0.76,"physical_touch":0.74,"introvert_extrovert":0.12,"loyalty":0.88}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 131', 39, 'other', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.76387198436147, 10.591303229034352), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 132
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0316028582', 0.70, 0.96, 0.98, 0.52, 0.14, '{"ambition":0.7,"family":0.96,"physical_touch":0.98,"introvert_extrovert":0.52,"loyalty":0.14}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 132', 35, 'other', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.56499296561844, 10.824679783263303), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 133
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0534954937', 0.65, 0.01, 0.52, 0.17, 0.13, '{"ambition":0.65,"family":0.01,"physical_touch":0.52,"introvert_extrovert":0.17,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 133', 36, 'male', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.81015500191639, 10.948427477795944), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 134
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0202780081', 0.32, 0.86, 0.68, 0.98, 0.62, '{"ambition":0.32,"family":0.86,"physical_touch":0.68,"introvert_extrovert":0.98,"loyalty":0.62}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 134', 30, 'female', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.63413461687982, 10.959966858834981), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 135
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0265332629', 0.44, 0.63, 0.15, 0.96, 0.40, '{"ambition":0.44,"family":0.63,"physical_touch":0.15,"introvert_extrovert":0.96,"loyalty":0.4}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 135', 39, 'female', 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.90010691754645, 10.895795052558508), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 136
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0943416760', 0.71, 0.91, 0.47, 0.10, 0.23, '{"ambition":0.71,"family":0.91,"physical_touch":0.47,"introvert_extrovert":0.1,"loyalty":0.23}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 136', 23, 'other', 'Designer', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.80413751573495, 10.898603764264173), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 137
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0394041946', 0.88, 0.54, 0.59, 0.76, 0.92, '{"ambition":0.88,"family":0.54,"physical_touch":0.59,"introvert_extrovert":0.76,"loyalty":0.92}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 137', 35, 'other', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.46102814809056, 10.65136891484737), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 138
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0881582394', 0.76, 0.41, 0.29, 0.43, 0.87, '{"ambition":0.76,"family":0.41,"physical_touch":0.29,"introvert_extrovert":0.43,"loyalty":0.87}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 138', 32, 'other', 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.58480105196313, 10.983022519974929), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 139
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0655588665', 0.12, 0.59, 0.58, 0.04, 0.18, '{"ambition":0.12,"family":0.59,"physical_touch":0.58,"introvert_extrovert":0.04,"loyalty":0.18}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 139', 30, 'male', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.74095950558342, 10.933902796462176), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 140
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0290362062', 0.90, 0.93, 0.92, 0.35, 0.48, '{"ambition":0.9,"family":0.93,"physical_touch":0.92,"introvert_extrovert":0.35,"loyalty":0.48}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 140', 22, 'other', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.55051088574103, 10.924230094436618), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 141
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0513861051', 0.07, 0.95, 0.58, 0.82, 0.73, '{"ambition":0.07,"family":0.95,"physical_touch":0.58,"introvert_extrovert":0.82,"loyalty":0.73}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 141', 32, 'other', 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.54759344175146, 10.940116848177082), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 142
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0123869149', 0.07, 0.75, 0.48, 0.88, 0.68, '{"ambition":0.07,"family":0.75,"physical_touch":0.48,"introvert_extrovert":0.88,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 142', 31, 'other', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.62453708274103, 10.826274786894269), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 143
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0911752964', 0.83, 0.57, 0.63, 0.71, 0.24, '{"ambition":0.83,"family":0.57,"physical_touch":0.63,"introvert_extrovert":0.71,"loyalty":0.24}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 143', 32, 'male', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.60733690731487, 10.785981682868698), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 144
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0440909588', 0.41, 0.53, 0.11, 0.29, 0.02, '{"ambition":0.41,"family":0.53,"physical_touch":0.11,"introvert_extrovert":0.29,"loyalty":0.02}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 144', 18, 'other', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.51774562190836, 10.596992873532468), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 145
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0532014314', 0.17, 0.05, 0.34, 0.92, 0.34, '{"ambition":0.17,"family":0.05,"physical_touch":0.34,"introvert_extrovert":0.92,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 145', 39, 'other', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.6824751739408, 10.947633434362139), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 146
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0982614930', 0.26, 0.83, 0.48, 0.45, 0.81, '{"ambition":0.26,"family":0.83,"physical_touch":0.48,"introvert_extrovert":0.45,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 146', 22, 'other', 'Giáo viên', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.57528020547143, 10.763375621809518), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 147
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0113696265', 0.09, 0.31, 0.57, 0.68, 1.00, '{"ambition":0.09,"family":0.31,"physical_touch":0.57,"introvert_extrovert":0.68,"loyalty":1}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 147', 35, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.7988587983922, 10.737180787884677), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 148
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0224346135', 0.75, 0.81, 0.46, 0.09, 0.28, '{"ambition":0.75,"family":0.81,"physical_touch":0.46,"introvert_extrovert":0.09,"loyalty":0.28}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 148', 21, 'other', 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.75840655032358, 10.929626667328543), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 149
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0441542614', 0.74, 0.25, 0.38, 0.23, 0.64, '{"ambition":0.74,"family":0.25,"physical_touch":0.38,"introvert_extrovert":0.23,"loyalty":0.64}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 149', 27, 'female', 'Developer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.7181153901533, 10.748061153874795), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 150
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0542885944', 0.96, 0.22, 0.21, 0.78, 0.52, '{"ambition":0.96,"family":0.22,"physical_touch":0.21,"introvert_extrovert":0.78,"loyalty":0.52}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 150', 38, 'other', 'Developer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.47049777066638, 10.555366473703122), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 151
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0552008019', 0.23, 0.19, 0.72, 0.83, 0.58, '{"ambition":0.23,"family":0.19,"physical_touch":0.72,"introvert_extrovert":0.83,"loyalty":0.58}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 151', 34, 'female', 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.7814119004823, 10.876729946767917), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 152
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0216909121', 0.81, 0.81, 0.71, 0.67, 0.99, '{"ambition":0.81,"family":0.81,"physical_touch":0.71,"introvert_extrovert":0.67,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 152', 35, 'male', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.81858096078983, 10.53525377896295), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 153
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0624785096', 0.46, 0.14, 0.70, 0.16, 0.24, '{"ambition":0.46,"family":0.14,"physical_touch":0.7,"introvert_extrovert":0.16,"loyalty":0.24}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 153', 19, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.46630614664203, 10.889551414011633), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 154
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0548697864', 0.52, 0.84, 0.44, 0.47, 0.82, '{"ambition":0.52,"family":0.84,"physical_touch":0.44,"introvert_extrovert":0.47,"loyalty":0.82}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 154', 28, 'female', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.78157220350202, 10.534787669310493), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 155
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0676217950', 0.98, 0.43, 0.30, 0.93, 0.43, '{"ambition":0.98,"family":0.43,"physical_touch":0.3,"introvert_extrovert":0.93,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 155', 30, 'female', 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.75643060022762, 10.725188409043952), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 156
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0627289798', 0.69, 0.24, 0.62, 0.55, 0.56, '{"ambition":0.69,"family":0.24,"physical_touch":0.62,"introvert_extrovert":0.55,"loyalty":0.56}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 156', 21, 'male', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.4914745288051, 10.566069516962648), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 157
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0777596135', 0.50, 0.74, 0.11, 0.70, 0.47, '{"ambition":0.5,"family":0.74,"physical_touch":0.11,"introvert_extrovert":0.7,"loyalty":0.47}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 157', 27, 'male', 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.67307486302703, 10.840968652629957), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 158
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0635474220', 0.47, 0.89, 0.88, 0.97, 0.72, '{"ambition":0.47,"family":0.89,"physical_touch":0.88,"introvert_extrovert":0.97,"loyalty":0.72}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 158', 24, 'male', 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.70860966039184, 10.548716679928992), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 159
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0498749663', 0.13, 0.12, 0.44, 0.62, 0.28, '{"ambition":0.13,"family":0.12,"physical_touch":0.44,"introvert_extrovert":0.62,"loyalty":0.28}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 159', 33, 'female', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.79720015397689, 10.518706708362336), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 160
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0368904444', 0.96, 0.93, 0.86, 0.66, 0.76, '{"ambition":0.96,"family":0.93,"physical_touch":0.86,"introvert_extrovert":0.66,"loyalty":0.76}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 160', 25, 'female', 'Developer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.5289669281764, 10.793096620825875), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 161
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0675739945', 0.79, 0.10, 0.48, 0.85, 0.03, '{"ambition":0.79,"family":0.1,"physical_touch":0.48,"introvert_extrovert":0.85,"loyalty":0.03}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 161', 29, 'female', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.72437889571802, 10.681931734310108), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 162
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0930960554', 0.92, 0.91, 0.03, 0.87, 0.40, '{"ambition":0.92,"family":0.91,"physical_touch":0.03,"introvert_extrovert":0.87,"loyalty":0.4}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 162', 33, 'male', 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.50218976088088, 10.811386532402357), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 163
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0523413206', 0.71, 0.49, 0.01, 0.10, 0.32, '{"ambition":0.71,"family":0.49,"physical_touch":0.01,"introvert_extrovert":0.1,"loyalty":0.32}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 163', 24, 'female', 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.66397783763647, 10.56876467900384), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 164
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0927932884', 0.10, 0.17, 0.38, 0.23, 0.47, '{"ambition":0.1,"family":0.17,"physical_touch":0.38,"introvert_extrovert":0.23,"loyalty":0.47}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 164', 23, 'female', 'Giáo viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.57380689900134, 10.647365709118896), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 165
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0343893631', 0.84, 0.77, 0.13, 0.94, 0.59, '{"ambition":0.84,"family":0.77,"physical_touch":0.13,"introvert_extrovert":0.94,"loyalty":0.59}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 165', 23, 'female', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(106.85301504008676, 10.878837010504057), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 166
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0266181596', 0.00, 0.47, 0.88, 0.88, 0.29, '{"ambition":0,"family":0.47,"physical_touch":0.88,"introvert_extrovert":0.88,"loyalty":0.29}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 166', 33, 'other', 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.77020291260092, 10.63765826140988), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 167
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0535256816', 0.40, 0.84, 0.80, 0.14, 0.95, '{"ambition":0.4,"family":0.84,"physical_touch":0.8,"introvert_extrovert":0.14,"loyalty":0.95}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 167', 38, 'other', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.85650011972635, 10.613391071723164), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 168
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0565385131', 0.29, 0.53, 0.91, 0.10, 0.20, '{"ambition":0.29,"family":0.53,"physical_touch":0.91,"introvert_extrovert":0.1,"loyalty":0.2}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 168', 38, 'other', 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.61802517398459, 10.739392730580043), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 169
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0411570123', 0.49, 0.34, 0.31, 0.69, 0.91, '{"ambition":0.49,"family":0.34,"physical_touch":0.31,"introvert_extrovert":0.69,"loyalty":0.91}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 169', 25, 'male', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.57805537359849, 10.566896333010561), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 170
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0346734081', 0.66, 0.27, 0.76, 0.20, 0.09, '{"ambition":0.66,"family":0.27,"physical_touch":0.76,"introvert_extrovert":0.2,"loyalty":0.09}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 170', 33, 'male', 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.51125554928595, 10.814746457649404), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 171
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0735252315', 0.30, 0.24, 0.34, 0.56, 0.71, '{"ambition":0.3,"family":0.24,"physical_touch":0.34,"introvert_extrovert":0.56,"loyalty":0.71}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 171', 26, 'male', 'Designer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.61421693599677, 10.600318596799436), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 172
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0166015505', 0.39, 0.99, 0.50, 0.30, 0.83, '{"ambition":0.39,"family":0.99,"physical_touch":0.5,"introvert_extrovert":0.3,"loyalty":0.83}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 172', 37, 'female', 'Bác sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.70801442723946, 10.610708009995653), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 173
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0866889072', 0.25, 0.72, 0.46, 0.08, 0.55, '{"ambition":0.25,"family":0.72,"physical_touch":0.46,"introvert_extrovert":0.08,"loyalty":0.55}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 173', 32, 'male', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.51327173607751, 10.60735149489002), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 174
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0936962513', 0.01, 0.78, 0.01, 0.70, 0.11, '{"ambition":0.01,"family":0.78,"physical_touch":0.01,"introvert_extrovert":0.7,"loyalty":0.11}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 174', 37, 'female', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.47377324061333, 10.950729476371647), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 175
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0107912539', 0.38, 0.95, 0.10, 0.15, 0.99, '{"ambition":0.38,"family":0.95,"physical_touch":0.1,"introvert_extrovert":0.15,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 175', 27, 'other', 'Designer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.45676596991261, 10.872852281827395), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 176
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0958174619', 0.26, 0.98, 0.76, 0.87, 0.55, '{"ambition":0.26,"family":0.98,"physical_touch":0.76,"introvert_extrovert":0.87,"loyalty":0.55}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 176', 26, 'male', 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.55563645688301, 10.623257680698389), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 177
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0386847049', 0.31, 0.63, 0.27, 0.20, 0.30, '{"ambition":0.31,"family":0.63,"physical_touch":0.27,"introvert_extrovert":0.2,"loyalty":0.3}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 177', 35, 'other', 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.78978689457031, 10.891161961724066), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 178
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0796870076', 0.89, 0.49, 0.18, 0.50, 0.72, '{"ambition":0.89,"family":0.49,"physical_touch":0.18,"introvert_extrovert":0.5,"loyalty":0.72}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 178', 20, 'male', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.5653979402882, 10.66611219256101), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 179
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0376608567', 0.39, 0.65, 0.40, 0.08, 0.77, '{"ambition":0.39,"family":0.65,"physical_touch":0.4,"introvert_extrovert":0.08,"loyalty":0.77}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 179', 38, 'male', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.46581546372492, 10.784356291840538), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 180
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0204748716', 0.69, 0.47, 0.07, 0.54, 0.49, '{"ambition":0.69,"family":0.47,"physical_touch":0.07,"introvert_extrovert":0.54,"loyalty":0.49}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 180', 22, 'other', 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.80578400946963, 10.552059081397415), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 181
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0932355117', 0.31, 0.19, 0.14, 0.24, 0.49, '{"ambition":0.31,"family":0.19,"physical_touch":0.14,"introvert_extrovert":0.24,"loyalty":0.49}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 181', 37, 'female', 'Giáo viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.6852825917507, 10.977761936883134), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 182
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0683212310', 0.90, 0.99, 0.51, 0.78, 0.83, '{"ambition":0.9,"family":0.99,"physical_touch":0.51,"introvert_extrovert":0.78,"loyalty":0.83}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 182', 25, 'male', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.67163649921949, 10.991685620897771), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 183
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0655509512', 0.50, 0.66, 0.04, 0.13, 0.44, '{"ambition":0.5,"family":0.66,"physical_touch":0.04,"introvert_extrovert":0.13,"loyalty":0.44}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 183', 38, 'female', 'Designer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.49197151157799, 10.788420380645984), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 184
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0234910476', 0.60, 0.86, 0.79, 0.23, 0.32, '{"ambition":0.6,"family":0.86,"physical_touch":0.79,"introvert_extrovert":0.23,"loyalty":0.32}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 184', 32, 'male', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.87057711783956, 10.7514401399126), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 185
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0994288936', 0.54, 0.01, 0.81, 0.00, 0.27, '{"ambition":0.54,"family":0.01,"physical_touch":0.81,"introvert_extrovert":0,"loyalty":0.27}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 185', 36, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.57491283621412, 10.91488702615423), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 186
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0559605873', 0.21, 0.81, 0.40, 0.64, 0.25, '{"ambition":0.21,"family":0.81,"physical_touch":0.4,"introvert_extrovert":0.64,"loyalty":0.25}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 186', 36, 'male', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.64681646072059, 10.624840606891667), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 187
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0988571259', 0.95, 0.50, 0.89, 0.50, 0.37, '{"ambition":0.95,"family":0.5,"physical_touch":0.89,"introvert_extrovert":0.5,"loyalty":0.37}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 187', 25, 'male', 'Developer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.41232275029188, 10.746339385754414), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 188
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0743060906', 0.13, 0.93, 0.62, 0.96, 0.59, '{"ambition":0.13,"family":0.93,"physical_touch":0.62,"introvert_extrovert":0.96,"loyalty":0.59}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 188', 37, 'male', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.50103638958939, 10.812797501432584), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 189
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0268703732', 0.98, 0.43, 0.43, 0.46, 0.66, '{"ambition":0.98,"family":0.43,"physical_touch":0.43,"introvert_extrovert":0.46,"loyalty":0.66}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 189', 30, 'male', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.8043380151539, 10.555749097838104), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 190
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0557665313', 1.00, 0.59, 0.23, 0.31, 0.65, '{"ambition":1,"family":0.59,"physical_touch":0.23,"introvert_extrovert":0.31,"loyalty":0.65}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 190', 21, 'female', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.61480330110277, 10.830005867798839), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 191
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0932051242', 0.58, 0.86, 0.62, 0.45, 0.60, '{"ambition":0.58,"family":0.86,"physical_touch":0.62,"introvert_extrovert":0.45,"loyalty":0.6}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 191', 33, 'female', 'Developer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.68658595512197, 10.76354959336508), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 192
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0925486327', 0.99, 0.94, 0.88, 0.30, 0.80, '{"ambition":0.99,"family":0.94,"physical_touch":0.88,"introvert_extrovert":0.3,"loyalty":0.8}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 192', 24, 'male', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.62845422113945, 10.85428159782394), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 193
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0769542564', 0.13, 0.43, 0.08, 0.04, 0.43, '{"ambition":0.13,"family":0.43,"physical_touch":0.08,"introvert_extrovert":0.04,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 193', 35, 'female', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.82756663150103, 10.585571920720932), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 194
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0607468419', 0.52, 0.34, 0.94, 0.11, 0.07, '{"ambition":0.52,"family":0.34,"physical_touch":0.94,"introvert_extrovert":0.11,"loyalty":0.07}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 194', 21, 'male', 'Kinh doanh', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.42992451855918, 10.944085196507018), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 195
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0925327676', 0.75, 0.43, 0.06, 0.23, 0.82, '{"ambition":0.75,"family":0.43,"physical_touch":0.06,"introvert_extrovert":0.23,"loyalty":0.82}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 195', 31, 'male', 'Designer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.4460728991679, 10.639290855216625), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 196
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0315405968', 0.68, 0.57, 0.19, 0.42, 0.63, '{"ambition":0.68,"family":0.57,"physical_touch":0.19,"introvert_extrovert":0.42,"loyalty":0.63}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 196', 18, 'other', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.52741568632142, 10.937101075698967), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 197
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0696041956', 0.05, 0.78, 0.85, 0.14, 0.14, '{"ambition":0.05,"family":0.78,"physical_touch":0.85,"introvert_extrovert":0.14,"loyalty":0.14}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 197', 24, 'male', 'Giáo viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.49533176079169, 10.770973176522487), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 198
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0803291902', 0.12, 0.10, 0.75, 0.46, 0.30, '{"ambition":0.12,"family":0.1,"physical_touch":0.75,"introvert_extrovert":0.46,"loyalty":0.3}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 198', 36, 'female', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.58451531595813, 10.880160833275694), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 199
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0487042839', 0.71, 0.54, 0.85, 0.88, 0.24, '{"ambition":0.71,"family":0.54,"physical_touch":0.85,"introvert_extrovert":0.88,"loyalty":0.24}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 199', 39, 'male', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.5700441533793, 10.856214301886716), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 200
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0791219418', 1.00, 0.27, 0.58, 0.46, 0.44, '{"ambition":1,"family":0.27,"physical_touch":0.58,"introvert_extrovert":0.46,"loyalty":0.44}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 200', 19, 'other', 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.76487188887785, 10.635529154058872), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 201
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0581545877', 0.56, 0.81, 0.51, 0.10, 0.44, '{"ambition":0.56,"family":0.81,"physical_touch":0.51,"introvert_extrovert":0.1,"loyalty":0.44}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 201', 33, 'female', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.68420782591797, 10.771802598853064), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 202
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0589107749', 0.66, 1.00, 0.29, 0.96, 0.18, '{"ambition":0.66,"family":1,"physical_touch":0.29,"introvert_extrovert":0.96,"loyalty":0.18}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 202', 30, 'other', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.58737835850694, 10.96784474338112), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 203
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0949592730', 0.81, 0.00, 0.32, 0.36, 0.93, '{"ambition":0.81,"family":0,"physical_touch":0.32,"introvert_extrovert":0.36,"loyalty":0.93}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 203', 31, 'female', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.84260163768941, 10.769847815013494), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 204
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0974435486', 0.61, 0.27, 0.07, 0.02, 0.05, '{"ambition":0.61,"family":0.27,"physical_touch":0.07,"introvert_extrovert":0.02,"loyalty":0.05}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 204', 25, 'male', 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.5322707810974, 10.650517367179454), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 205
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0706432390', 0.63, 0.66, 0.86, 0.28, 0.81, '{"ambition":0.63,"family":0.66,"physical_touch":0.86,"introvert_extrovert":0.28,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 205', 36, 'other', 'Developer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.42166110321556, 10.567057538131474), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 206
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0809004379', 0.30, 0.30, 0.12, 0.65, 0.79, '{"ambition":0.3,"family":0.3,"physical_touch":0.12,"introvert_extrovert":0.65,"loyalty":0.79}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 206', 32, 'female', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.42543824743547, 10.653813744080932), '["Ẩm thực","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 207
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0650955092', 0.29, 0.48, 0.79, 0.44, 0.74, '{"ambition":0.29,"family":0.48,"physical_touch":0.79,"introvert_extrovert":0.44,"loyalty":0.74}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 207', 36, 'female', 'Designer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.86185307879863, 11.012112193703778), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 208
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0139939905', 0.49, 0.82, 0.45, 0.41, 0.96, '{"ambition":0.49,"family":0.82,"physical_touch":0.45,"introvert_extrovert":0.41,"loyalty":0.96}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 208', 31, 'other', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.7494935032034, 11.006951033703757), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 209
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0113892819', 0.41, 0.32, 0.69, 0.13, 0.47, '{"ambition":0.41,"family":0.32,"physical_touch":0.69,"introvert_extrovert":0.13,"loyalty":0.47}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 209', 33, 'female', 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.77916918917408, 10.776988124698358), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 210
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0568863100', 0.17, 0.55, 0.89, 0.31, 0.14, '{"ambition":0.17,"family":0.55,"physical_touch":0.89,"introvert_extrovert":0.31,"loyalty":0.14}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 210', 38, 'other', 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.68708603710259, 10.891436224003563), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 211
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0240998630', 0.03, 0.41, 0.77, 0.16, 0.43, '{"ambition":0.03,"family":0.41,"physical_touch":0.77,"introvert_extrovert":0.16,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 211', 36, 'female', 'Designer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.7236347152162, 10.621928006964598), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 212
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0630096061', 0.00, 0.19, 0.24, 0.79, 0.16, '{"ambition":0,"family":0.19,"physical_touch":0.24,"introvert_extrovert":0.79,"loyalty":0.16}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 212', 22, 'female', 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.75491850417683, 10.664534105658785), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 213
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0342521458', 0.87, 0.25, 0.20, 0.24, 0.56, '{"ambition":0.87,"family":0.25,"physical_touch":0.2,"introvert_extrovert":0.24,"loyalty":0.56}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 213', 27, 'male', 'Developer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.89844566098532, 10.523611291640334), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 214
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0994932355', 0.44, 0.62, 0.33, 0.99, 0.82, '{"ambition":0.44,"family":0.62,"physical_touch":0.33,"introvert_extrovert":0.99,"loyalty":0.82}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 214', 34, 'male', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.45629706922038, 10.590847612371567), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 215
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0501596283', 0.76, 0.99, 0.43, 0.91, 0.58, '{"ambition":0.76,"family":0.99,"physical_touch":0.43,"introvert_extrovert":0.91,"loyalty":0.58}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 215', 28, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.44831357488194, 10.548124100350837), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 216
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0193334174', 0.65, 0.68, 0.35, 0.11, 0.44, '{"ambition":0.65,"family":0.68,"physical_touch":0.35,"introvert_extrovert":0.11,"loyalty":0.44}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 216', 32, 'other', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.69280440923869, 10.58816538001617), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 217
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0309505958', 0.48, 0.25, 0.44, 0.55, 0.85, '{"ambition":0.48,"family":0.25,"physical_touch":0.44,"introvert_extrovert":0.55,"loyalty":0.85}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 217', 33, 'male', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.63737628559213, 10.7384057584167), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 218
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0728219390', 0.15, 0.69, 0.18, 0.85, 0.68, '{"ambition":0.15,"family":0.69,"physical_touch":0.18,"introvert_extrovert":0.85,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 218', 36, 'female', 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.4636242441606, 10.864947323038853), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 219
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0240234284', 0.78, 0.75, 0.73, 0.95, 0.79, '{"ambition":0.78,"family":0.75,"physical_touch":0.73,"introvert_extrovert":0.95,"loyalty":0.79}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 219', 36, 'female', 'Developer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.8880543244402, 10.587569595607642), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 220
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0733084898', 0.46, 0.83, 0.21, 0.60, 0.29, '{"ambition":0.46,"family":0.83,"physical_touch":0.21,"introvert_extrovert":0.6,"loyalty":0.29}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 220', 27, 'male', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.67205635290895, 10.819953668003382), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 221
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0208850806', 0.73, 0.82, 0.49, 0.06, 0.97, '{"ambition":0.73,"family":0.82,"physical_touch":0.49,"introvert_extrovert":0.06,"loyalty":0.97}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 221', 39, 'other', 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.44605152308377, 10.739426736198892), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 222
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0219495671', 0.53, 0.02, 0.17, 0.58, 0.69, '{"ambition":0.53,"family":0.02,"physical_touch":0.17,"introvert_extrovert":0.58,"loyalty":0.69}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 222', 31, 'other', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.48210722528533, 10.604832697793281), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 223
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0104716282', 0.75, 0.50, 0.25, 0.68, 0.17, '{"ambition":0.75,"family":0.5,"physical_touch":0.25,"introvert_extrovert":0.68,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 223', 26, 'other', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.44961367635986, 10.86517774938365), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 224
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0243603346', 0.80, 0.37, 0.27, 0.22, 0.99, '{"ambition":0.8,"family":0.37,"physical_touch":0.27,"introvert_extrovert":0.22,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 224', 23, 'other', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.41101126325441, 10.696284555266255), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 225
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0629611395', 0.17, 0.58, 0.11, 0.48, 0.36, '{"ambition":0.17,"family":0.58,"physical_touch":0.11,"introvert_extrovert":0.48,"loyalty":0.36}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 225', 22, 'male', 'Designer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.46792993743476, 10.558438336544409), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 226
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0155214127', 0.74, 0.04, 0.21, 0.52, 0.38, '{"ambition":0.74,"family":0.04,"physical_touch":0.21,"introvert_extrovert":0.52,"loyalty":0.38}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 226', 35, 'other', 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.69748650450802, 11.005869908748007), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 227
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0554589263', 0.95, 0.80, 0.60, 0.91, 0.82, '{"ambition":0.95,"family":0.8,"physical_touch":0.6,"introvert_extrovert":0.91,"loyalty":0.82}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 227', 39, 'other', 'Developer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.51859001195497, 10.818415079259843), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 228
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0753953330', 0.41, 0.60, 0.75, 0.96, 0.34, '{"ambition":0.41,"family":0.6,"physical_touch":0.75,"introvert_extrovert":0.96,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 228', 37, 'female', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.46730014963033, 10.689901132133313), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 229
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0548808337', 0.38, 0.02, 0.47, 0.50, 0.85, '{"ambition":0.38,"family":0.02,"physical_touch":0.47,"introvert_extrovert":0.5,"loyalty":0.85}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 229', 28, 'other', 'Developer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.61382225689626, 10.868235601674833), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 230
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0703269771', 0.70, 0.36, 0.58, 0.05, 0.60, '{"ambition":0.7,"family":0.36,"physical_touch":0.58,"introvert_extrovert":0.05,"loyalty":0.6}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 230', 26, 'female', 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.7227324888284, 10.660480599964881), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 231
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0395286193', 0.44, 0.21, 0.94, 0.93, 0.28, '{"ambition":0.44,"family":0.21,"physical_touch":0.94,"introvert_extrovert":0.93,"loyalty":0.28}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 231', 27, 'other', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.84946814436516, 10.826523995538228), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 232
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0175447401', 0.49, 0.99, 0.74, 0.79, 0.29, '{"ambition":0.49,"family":0.99,"physical_touch":0.74,"introvert_extrovert":0.79,"loyalty":0.29}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 232', 19, 'female', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.70932837151543, 10.76408687863546), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 233
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0397585594', 0.71, 0.10, 0.12, 0.63, 0.01, '{"ambition":0.71,"family":0.1,"physical_touch":0.12,"introvert_extrovert":0.63,"loyalty":0.01}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 233', 34, 'other', 'Developer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.68452637757018, 10.87527158724733), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 234
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0472845899', 0.05, 0.24, 0.37, 0.21, 0.22, '{"ambition":0.05,"family":0.24,"physical_touch":0.37,"introvert_extrovert":0.21,"loyalty":0.22}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 234', 29, 'female', 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.53177538714564, 11.005714002574532), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 235
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0841967586', 0.31, 0.27, 0.81, 0.54, 0.72, '{"ambition":0.31,"family":0.27,"physical_touch":0.81,"introvert_extrovert":0.54,"loyalty":0.72}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 235', 29, 'other', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.73750958492477, 10.609737234838612), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 236
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0104020142', 0.55, 0.15, 0.12, 0.10, 0.54, '{"ambition":0.55,"family":0.15,"physical_touch":0.12,"introvert_extrovert":0.1,"loyalty":0.54}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 236', 39, 'male', 'Developer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.62434518813211, 10.836474772813471), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 237
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0598200936', 0.37, 0.46, 0.27, 0.52, 0.88, '{"ambition":0.37,"family":0.46,"physical_touch":0.27,"introvert_extrovert":0.52,"loyalty":0.88}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 237', 18, 'other', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.82816518135294, 10.606656219411517), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 238
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0466194376', 0.64, 0.37, 0.26, 0.04, 0.60, '{"ambition":0.64,"family":0.37,"physical_touch":0.26,"introvert_extrovert":0.04,"loyalty":0.6}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 238', 37, 'other', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.87874051544257, 10.549972781006096), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 239
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0707551409', 0.50, 0.71, 0.23, 0.51, 0.40, '{"ambition":0.5,"family":0.71,"physical_touch":0.23,"introvert_extrovert":0.51,"loyalty":0.4}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 239', 33, 'male', 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.48800266181236, 10.674257986020963), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 240
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0699559114', 0.57, 0.90, 0.52, 0.32, 0.04, '{"ambition":0.57,"family":0.9,"physical_touch":0.52,"introvert_extrovert":0.32,"loyalty":0.04}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 240', 23, 'female', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.58380738155242, 10.724662378122712), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 241
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0636078617', 0.56, 0.34, 0.82, 0.47, 0.28, '{"ambition":0.56,"family":0.34,"physical_touch":0.82,"introvert_extrovert":0.47,"loyalty":0.28}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 241', 23, 'female', 'Developer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.54771073843278, 10.62910748679239), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 242
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0180241352', 0.10, 0.66, 0.45, 0.39, 0.13, '{"ambition":0.1,"family":0.66,"physical_touch":0.45,"introvert_extrovert":0.39,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 242', 26, 'other', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.43484489328485, 10.619786488186422), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 243
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0437339823', 0.59, 0.27, 0.29, 0.73, 0.55, '{"ambition":0.59,"family":0.27,"physical_touch":0.29,"introvert_extrovert":0.73,"loyalty":0.55}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 243', 23, 'other', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.8742848393321, 10.516827644393492), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 244
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0731066816', 0.40, 0.31, 0.13, 0.82, 0.30, '{"ambition":0.4,"family":0.31,"physical_touch":0.13,"introvert_extrovert":0.82,"loyalty":0.3}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 244', 24, 'other', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.76130337058206, 10.843770744800283), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 245
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0411307790', 0.52, 0.09, 0.48, 0.03, 0.98, '{"ambition":0.52,"family":0.09,"physical_touch":0.48,"introvert_extrovert":0.03,"loyalty":0.98}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 245', 19, 'male', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.42081647495871, 10.583094067177115), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 246
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0718227415', 0.56, 0.98, 0.49, 0.64, 0.60, '{"ambition":0.56,"family":0.98,"physical_touch":0.49,"introvert_extrovert":0.64,"loyalty":0.6}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 246', 36, 'male', 'Sinh viên', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.61867389765742, 10.749386513021177), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 247
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0553125965', 0.18, 0.55, 0.85, 0.30, 0.46, '{"ambition":0.18,"family":0.55,"physical_touch":0.85,"introvert_extrovert":0.3,"loyalty":0.46}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 247', 23, 'other', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.60886450031653, 10.562001212047562), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 248
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0382676153', 0.45, 0.81, 0.55, 0.89, 0.53, '{"ambition":0.45,"family":0.81,"physical_touch":0.55,"introvert_extrovert":0.89,"loyalty":0.53}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 248', 35, 'female', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.74335702485305, 10.525066981723581), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 249
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0830035529', 0.03, 0.23, 0.80, 0.55, 0.62, '{"ambition":0.03,"family":0.23,"physical_touch":0.8,"introvert_extrovert":0.55,"loyalty":0.62}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 249', 20, 'male', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.69089183145577, 10.613597332595267), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 250
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0922811360', 0.01, 0.53, 0.14, 0.27, 0.05, '{"ambition":0.01,"family":0.53,"physical_touch":0.14,"introvert_extrovert":0.27,"loyalty":0.05}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 250', 31, 'female', 'Bác sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.72177676535587, 10.900002657885524), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 251
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0237360857', 0.96, 0.37, 0.60, 0.92, 0.98, '{"ambition":0.96,"family":0.37,"physical_touch":0.6,"introvert_extrovert":0.92,"loyalty":0.98}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 251', 19, 'male', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.57669137640035, 10.611125066372896), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 252
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0231344006', 0.93, 0.81, 0.59, 0.57, 0.35, '{"ambition":0.93,"family":0.81,"physical_touch":0.59,"introvert_extrovert":0.57,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 252', 27, 'female', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.50487053497636, 10.74387165270224), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 253
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0468186201', 0.26, 0.26, 0.39, 0.32, 0.46, '{"ambition":0.26,"family":0.26,"physical_touch":0.39,"introvert_extrovert":0.32,"loyalty":0.46}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 253', 22, 'female', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.77049539670494, 10.628893907612753), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 254
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0471567504', 0.67, 0.39, 0.69, 0.36, 0.26, '{"ambition":0.67,"family":0.39,"physical_touch":0.69,"introvert_extrovert":0.36,"loyalty":0.26}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 254', 34, 'other', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.4114572451428, 10.596614301879711), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 255
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0160515478', 0.59, 0.05, 0.39, 0.99, 0.39, '{"ambition":0.59,"family":0.05,"physical_touch":0.39,"introvert_extrovert":0.99,"loyalty":0.39}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 255', 30, 'other', 'Designer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.66245817455513, 10.717456217215112), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 256
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0747490056', 0.80, 0.51, 0.99, 0.63, 0.20, '{"ambition":0.8,"family":0.51,"physical_touch":0.99,"introvert_extrovert":0.63,"loyalty":0.2}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 256', 35, 'other', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.8451950562548, 10.955624371115281), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 257
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0720748262', 0.08, 0.47, 0.89, 0.62, 0.35, '{"ambition":0.08,"family":0.47,"physical_touch":0.89,"introvert_extrovert":0.62,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 257', 30, 'female', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.5695113302035, 10.708218203658769), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 258
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0397103535', 0.88, 0.55, 0.64, 0.39, 0.24, '{"ambition":0.88,"family":0.55,"physical_touch":0.64,"introvert_extrovert":0.39,"loyalty":0.24}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 258', 39, 'male', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.52996986782321, 10.519705522543886), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 259
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0602971007', 0.58, 0.16, 0.15, 0.32, 0.84, '{"ambition":0.58,"family":0.16,"physical_touch":0.15,"introvert_extrovert":0.32,"loyalty":0.84}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 259', 35, 'other', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.82374973932332, 10.98730279584435), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 260
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0343091888', 0.80, 0.17, 0.80, 0.13, 0.23, '{"ambition":0.8,"family":0.17,"physical_touch":0.8,"introvert_extrovert":0.13,"loyalty":0.23}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 260', 32, 'other', 'Sinh viên', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.71990386231366, 10.616500071766982), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 261
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0224144747', 0.42, 0.93, 0.69, 0.23, 0.38, '{"ambition":0.42,"family":0.93,"physical_touch":0.69,"introvert_extrovert":0.23,"loyalty":0.38}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 261', 26, 'other', 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.41328651925086, 10.70405642626945), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 262
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0486593821', 0.07, 0.92, 0.91, 0.10, 0.37, '{"ambition":0.07,"family":0.92,"physical_touch":0.91,"introvert_extrovert":0.1,"loyalty":0.37}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 262', 34, 'other', 'Sinh viên', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.6876089564493, 10.831926925400715), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 263
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0518104651', 0.29, 0.53, 0.34, 0.26, 0.50, '{"ambition":0.29,"family":0.53,"physical_touch":0.34,"introvert_extrovert":0.26,"loyalty":0.5}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 263', 37, 'male', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.90652776840474, 10.922235621696881), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 264
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0595890915', 0.51, 0.09, 0.64, 0.95, 0.76, '{"ambition":0.51,"family":0.09,"physical_touch":0.64,"introvert_extrovert":0.95,"loyalty":0.76}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 264', 23, 'other', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.58972477859326, 10.872844480131493), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 265
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0515786355', 0.57, 0.42, 0.48, 0.16, 0.68, '{"ambition":0.57,"family":0.42,"physical_touch":0.48,"introvert_extrovert":0.16,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 265', 26, 'male', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.5626555998098, 10.787269576166148), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 266
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0251605091', 0.66, 0.68, 0.10, 0.94, 0.66, '{"ambition":0.66,"family":0.68,"physical_touch":0.1,"introvert_extrovert":0.94,"loyalty":0.66}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 266', 38, 'other', 'Designer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.56508195472058, 10.909040559414732), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 267
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0188695676', 0.63, 0.63, 0.06, 0.50, 0.48, '{"ambition":0.63,"family":0.63,"physical_touch":0.06,"introvert_extrovert":0.5,"loyalty":0.48}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 267', 20, 'other', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.86157884850527, 10.726944297634468), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 268
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0513458401', 0.69, 0.55, 0.19, 0.95, 0.34, '{"ambition":0.69,"family":0.55,"physical_touch":0.19,"introvert_extrovert":0.95,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 268', 37, 'male', 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.41931305173577, 10.797355585780895), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 269
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0884881615', 0.26, 0.70, 0.85, 0.53, 0.97, '{"ambition":0.26,"family":0.7,"physical_touch":0.85,"introvert_extrovert":0.53,"loyalty":0.97}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 269', 39, 'other', 'Giáo viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.74273096766666, 10.605538494594294), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 270
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0242168125', 0.64, 0.96, 0.73, 0.38, 0.14, '{"ambition":0.64,"family":0.96,"physical_touch":0.73,"introvert_extrovert":0.38,"loyalty":0.14}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 270', 27, 'other', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.53745932425927, 10.971701124253872), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 271
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0570715150', 0.69, 0.87, 0.40, 0.73, 0.11, '{"ambition":0.69,"family":0.87,"physical_touch":0.4,"introvert_extrovert":0.73,"loyalty":0.11}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 271', 30, 'male', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.597462351287, 10.891629864463706), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 272
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0322226009', 0.26, 0.85, 0.78, 0.14, 0.75, '{"ambition":0.26,"family":0.85,"physical_touch":0.78,"introvert_extrovert":0.14,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 272', 25, 'male', 'Bác sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.83778302457027, 10.537859297137185), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 273
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0438043467', 0.91, 0.96, 0.19, 0.15, 0.68, '{"ambition":0.91,"family":0.96,"physical_touch":0.19,"introvert_extrovert":0.15,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 273', 32, 'other', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.64756218430652, 10.71730020750425), '["Ẩm thực","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 274
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0274848300', 0.66, 0.91, 0.16, 0.07, 0.92, '{"ambition":0.66,"family":0.91,"physical_touch":0.16,"introvert_extrovert":0.07,"loyalty":0.92}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 274', 24, 'other', 'Bác sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.63892057212672, 10.87885289860158), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 275
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0786554546', 0.98, 0.06, 0.21, 0.09, 0.31, '{"ambition":0.98,"family":0.06,"physical_touch":0.21,"introvert_extrovert":0.09,"loyalty":0.31}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 275', 38, 'other', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.88192656577725, 10.823785777218601), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 276
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0106419044', 0.39, 0.79, 0.40, 0.56, 0.03, '{"ambition":0.39,"family":0.79,"physical_touch":0.4,"introvert_extrovert":0.56,"loyalty":0.03}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 276', 30, 'male', 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.45037268824451, 10.659404495182656), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 277
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0501731228', 0.14, 0.70, 0.77, 0.39, 0.14, '{"ambition":0.14,"family":0.7,"physical_touch":0.77,"introvert_extrovert":0.39,"loyalty":0.14}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 277', 23, 'female', 'Designer', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.85980255718769, 10.921627227758057), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 278
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0302346363', 0.38, 0.55, 0.56, 0.23, 0.27, '{"ambition":0.38,"family":0.55,"physical_touch":0.56,"introvert_extrovert":0.23,"loyalty":0.27}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 278', 39, 'female', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.44842290889545, 10.771911925145186), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 279
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0310279519', 0.05, 0.43, 0.83, 0.16, 0.22, '{"ambition":0.05,"family":0.43,"physical_touch":0.83,"introvert_extrovert":0.16,"loyalty":0.22}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 279', 29, 'other', 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.53143958271006, 10.81704485749537), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 280
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0994547058', 0.01, 0.64, 0.94, 0.89, 0.59, '{"ambition":0.01,"family":0.64,"physical_touch":0.94,"introvert_extrovert":0.89,"loyalty":0.59}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 280', 31, 'male', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.6054537742491, 10.560707045034633), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 281
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0696427038', 0.13, 0.48, 0.79, 0.19, 0.64, '{"ambition":0.13,"family":0.48,"physical_touch":0.79,"introvert_extrovert":0.19,"loyalty":0.64}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 281', 26, 'male', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.68869010794451, 10.614744942899689), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 282
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0113434216', 0.82, 0.08, 0.81, 0.52, 0.13, '{"ambition":0.82,"family":0.08,"physical_touch":0.81,"introvert_extrovert":0.52,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 282', 36, 'female', 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.48373968129864, 10.846385783802882), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 283
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0273795533', 0.25, 0.22, 0.26, 0.80, 0.81, '{"ambition":0.25,"family":0.22,"physical_touch":0.26,"introvert_extrovert":0.8,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 283', 31, 'male', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.62271221503968, 10.631129283001838), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 284
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0745038579', 0.36, 0.69, 0.66, 0.17, 0.72, '{"ambition":0.36,"family":0.69,"physical_touch":0.66,"introvert_extrovert":0.17,"loyalty":0.72}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 284', 32, 'male', 'Giáo viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.78563615463952, 10.915029026671766), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 285
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0390662173', 0.59, 0.73, 0.46, 0.77, 0.61, '{"ambition":0.59,"family":0.73,"physical_touch":0.46,"introvert_extrovert":0.77,"loyalty":0.61}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 285', 19, 'female', 'Developer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.52748096959354, 10.704506189795435), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 286
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0284826252', 0.17, 0.34, 0.25, 0.45, 0.62, '{"ambition":0.17,"family":0.34,"physical_touch":0.25,"introvert_extrovert":0.45,"loyalty":0.62}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 286', 36, 'other', 'Sinh viên', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.58218813091713, 10.94563695643101), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 287
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0228830980', 0.65, 0.86, 0.51, 0.82, 0.45, '{"ambition":0.65,"family":0.86,"physical_touch":0.51,"introvert_extrovert":0.82,"loyalty":0.45}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 287', 30, 'male', 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.87037475335752, 10.738698225391818), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 288
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0182354916', 0.90, 0.80, 0.07, 0.79, 0.32, '{"ambition":0.9,"family":0.8,"physical_touch":0.07,"introvert_extrovert":0.79,"loyalty":0.32}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 288', 23, 'other', 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.74317945928343, 10.87016786009589), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 289
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0279118702', 0.03, 0.83, 0.58, 0.77, 0.46, '{"ambition":0.03,"family":0.83,"physical_touch":0.58,"introvert_extrovert":0.77,"loyalty":0.46}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 289', 39, 'other', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.44638494101815, 10.754841978842244), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 290
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0391650279', 0.76, 0.96, 0.20, 0.24, 0.08, '{"ambition":0.76,"family":0.96,"physical_touch":0.2,"introvert_extrovert":0.24,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 290', 24, 'female', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.67691927343611, 10.926537833369888), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 291
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0401317392', 0.51, 0.70, 0.06, 0.27, 0.47, '{"ambition":0.51,"family":0.7,"physical_touch":0.06,"introvert_extrovert":0.27,"loyalty":0.47}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 291', 30, 'female', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.58389855776593, 10.798482452529077), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 292
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0714002105', 0.44, 0.28, 0.71, 0.05, 0.07, '{"ambition":0.44,"family":0.28,"physical_touch":0.71,"introvert_extrovert":0.05,"loyalty":0.07}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 292', 27, 'male', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.44641703690674, 10.703947533602264), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 293
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0205137957', 0.10, 0.84, 0.91, 0.00, 0.12, '{"ambition":0.1,"family":0.84,"physical_touch":0.91,"introvert_extrovert":0,"loyalty":0.12}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 293', 32, 'male', 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.74835229294007, 10.967834690139386), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 294
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0849650069', 0.30, 0.69, 0.83, 0.09, 0.58, '{"ambition":0.3,"family":0.69,"physical_touch":0.83,"introvert_extrovert":0.09,"loyalty":0.58}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 294', 22, 'female', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.69865024886809, 10.78183992412789), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 295
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0979451623', 0.75, 0.95, 0.90, 0.29, 0.83, '{"ambition":0.75,"family":0.95,"physical_touch":0.9,"introvert_extrovert":0.29,"loyalty":0.83}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 295', 25, 'other', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(106.70385463910138, 10.986167370788923), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 296
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0381401568', 0.20, 0.24, 0.17, 0.10, 0.06, '{"ambition":0.2,"family":0.24,"physical_touch":0.17,"introvert_extrovert":0.1,"loyalty":0.06}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 296', 39, 'female', 'Bác sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.56924297679404, 10.542114838057056), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 297
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0326077619', 0.07, 0.54, 0.98, 0.34, 0.01, '{"ambition":0.07,"family":0.54,"physical_touch":0.98,"introvert_extrovert":0.34,"loyalty":0.01}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 297', 34, 'male', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.49438577072351, 10.806479890359466), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 298
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0333661905', 0.03, 0.46, 0.32, 0.41, 0.08, '{"ambition":0.03,"family":0.46,"physical_touch":0.32,"introvert_extrovert":0.41,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 298', 18, 'male', 'Developer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.48313709676498, 10.601543054709722), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 299
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0449445607', 0.67, 0.92, 0.84, 0.54, 0.68, '{"ambition":0.67,"family":0.92,"physical_touch":0.84,"introvert_extrovert":0.54,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 299', 34, 'other', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.81298985535126, 10.895383742806073), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 300
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0375510398', 0.10, 0.66, 0.36, 0.28, 0.93, '{"ambition":0.1,"family":0.66,"physical_touch":0.36,"introvert_extrovert":0.28,"loyalty":0.93}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 300', 38, 'male', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.74914688487317, 10.796372741807456), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 301
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0322783452', 0.43, 0.88, 0.00, 0.95, 0.53, '{"ambition":0.43,"family":0.88,"physical_touch":0,"introvert_extrovert":0.95,"loyalty":0.53}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 301', 31, 'male', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.73814730995159, 10.989133371710654), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 302
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0737628611', 0.38, 0.28, 0.41, 0.80, 0.67, '{"ambition":0.38,"family":0.28,"physical_touch":0.41,"introvert_extrovert":0.8,"loyalty":0.67}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 302', 20, 'other', 'Kinh doanh', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.55608079774736, 10.707310966957271), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 303
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0439662972', 0.10, 0.41, 0.47, 0.87, 0.91, '{"ambition":0.1,"family":0.41,"physical_touch":0.47,"introvert_extrovert":0.87,"loyalty":0.91}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 303', 19, 'female', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.55567607383334, 10.846128860386337), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 304
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0287762382', 0.83, 0.12, 0.79, 0.24, 0.41, '{"ambition":0.83,"family":0.12,"physical_touch":0.79,"introvert_extrovert":0.24,"loyalty":0.41}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 304', 29, 'male', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.46840452702978, 10.727085491346811), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 305
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0143928134', 0.90, 0.78, 0.45, 0.76, 0.67, '{"ambition":0.9,"family":0.78,"physical_touch":0.45,"introvert_extrovert":0.76,"loyalty":0.67}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 305', 27, 'other', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.67128999889667, 10.613002657820052), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 306
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0215401917', 0.81, 0.01, 0.21, 0.98, 0.87, '{"ambition":0.81,"family":0.01,"physical_touch":0.21,"introvert_extrovert":0.98,"loyalty":0.87}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 306', 33, 'male', 'Developer', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.55178368367301, 10.784301748136867), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 307
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0185688088', 0.30, 0.37, 0.44, 0.60, 0.03, '{"ambition":0.3,"family":0.37,"physical_touch":0.44,"introvert_extrovert":0.6,"loyalty":0.03}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 307', 24, 'female', 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.66057115999007, 10.670934252132662), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 308
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0309895633', 0.82, 0.57, 0.31, 0.92, 0.63, '{"ambition":0.82,"family":0.57,"physical_touch":0.31,"introvert_extrovert":0.92,"loyalty":0.63}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 308', 22, 'male', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(106.75107896888584, 10.657796326529425), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 309
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0418489473', 0.99, 0.71, 0.14, 0.57, 0.71, '{"ambition":0.99,"family":0.71,"physical_touch":0.14,"introvert_extrovert":0.57,"loyalty":0.71}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 309', 33, 'female', 'Designer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.72881806186491, 10.700386789551604), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 310
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0186454745', 0.91, 0.67, 0.18, 0.90, 0.44, '{"ambition":0.91,"family":0.67,"physical_touch":0.18,"introvert_extrovert":0.9,"loyalty":0.44}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 310', 34, 'female', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.41847305140482, 10.92258571804759), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 311
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0522972289', 0.11, 0.47, 0.07, 0.23, 0.88, '{"ambition":0.11,"family":0.47,"physical_touch":0.07,"introvert_extrovert":0.23,"loyalty":0.88}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 311', 38, 'female', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.54825288088743, 10.51351369068499), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 312
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0907509967', 0.64, 0.63, 0.74, 0.41, 0.10, '{"ambition":0.64,"family":0.63,"physical_touch":0.74,"introvert_extrovert":0.41,"loyalty":0.1}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 312', 31, 'male', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.62605373901592, 10.691449474539606), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 313
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0154734563', 0.42, 0.54, 0.20, 0.25, 0.14, '{"ambition":0.42,"family":0.54,"physical_touch":0.2,"introvert_extrovert":0.25,"loyalty":0.14}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 313', 23, 'female', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.88615761187272, 10.94773421874897), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 314
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0312062839', 0.85, 0.37, 0.43, 1.00, 0.94, '{"ambition":0.85,"family":0.37,"physical_touch":0.43,"introvert_extrovert":1,"loyalty":0.94}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 314', 31, 'male', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.67678691875075, 10.671450002075606), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 315
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0805475611', 0.79, 0.44, 0.98, 0.29, 0.66, '{"ambition":0.79,"family":0.44,"physical_touch":0.98,"introvert_extrovert":0.29,"loyalty":0.66}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 315', 29, 'other', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.73364850823027, 10.647253320771007), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 316
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0352631821', 0.76, 0.06, 0.91, 0.09, 0.25, '{"ambition":0.76,"family":0.06,"physical_touch":0.91,"introvert_extrovert":0.09,"loyalty":0.25}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 316', 19, 'female', 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(106.74293219453375, 10.680177241092327), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 317
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0315813292', 0.81, 0.17, 1.00, 0.91, 0.29, '{"ambition":0.81,"family":0.17,"physical_touch":1,"introvert_extrovert":0.91,"loyalty":0.29}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 317', 31, 'female', 'Developer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.81097118411661, 10.782231331563926), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 318
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0796705943', 0.92, 0.55, 0.21, 0.23, 0.78, '{"ambition":0.92,"family":0.55,"physical_touch":0.21,"introvert_extrovert":0.23,"loyalty":0.78}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 318', 19, 'male', 'Bác sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.4783159869022, 10.800941156443992), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 319
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0710053424', 0.08, 0.89, 0.82, 0.28, 0.73, '{"ambition":0.08,"family":0.89,"physical_touch":0.82,"introvert_extrovert":0.28,"loyalty":0.73}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 319', 29, 'other', 'Developer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.76603375668772, 10.621033120057268), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 320
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0359037130', 0.23, 0.47, 0.40, 0.67, 0.07, '{"ambition":0.23,"family":0.47,"physical_touch":0.4,"introvert_extrovert":0.67,"loyalty":0.07}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 320', 27, 'other', 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.71887940459004, 10.69735998474398), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 321
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0358732219', 0.46, 0.82, 0.51, 0.68, 0.21, '{"ambition":0.46,"family":0.82,"physical_touch":0.51,"introvert_extrovert":0.68,"loyalty":0.21}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 321', 25, 'other', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.75544685559375, 10.897741648845631), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 322
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0105693674', 0.94, 0.12, 0.83, 0.49, 0.74, '{"ambition":0.94,"family":0.12,"physical_touch":0.83,"introvert_extrovert":0.49,"loyalty":0.74}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 322', 24, 'other', 'Designer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.82350211087557, 10.810004140426118), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 323
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0126283473', 0.75, 0.12, 0.78, 0.32, 0.66, '{"ambition":0.75,"family":0.12,"physical_touch":0.78,"introvert_extrovert":0.32,"loyalty":0.66}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 323', 26, 'female', 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.74142299847175, 10.538229810890417), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 324
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0400374815', 0.42, 0.34, 0.25, 0.20, 0.10, '{"ambition":0.42,"family":0.34,"physical_touch":0.25,"introvert_extrovert":0.2,"loyalty":0.1}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 324', 21, 'female', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.73475148260229, 10.713378810488093), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 325
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0238436132', 0.44, 0.32, 0.93, 0.50, 0.71, '{"ambition":0.44,"family":0.32,"physical_touch":0.93,"introvert_extrovert":0.5,"loyalty":0.71}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 325', 22, 'female', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.63498557377417, 10.65432211296953), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 326
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0460767982', 0.13, 0.13, 0.77, 0.30, 0.33, '{"ambition":0.13,"family":0.13,"physical_touch":0.77,"introvert_extrovert":0.3,"loyalty":0.33}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 326', 35, 'female', 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.8256184654769, 10.567836215365901), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 327
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0647323695', 0.48, 0.75, 0.82, 0.36, 0.17, '{"ambition":0.48,"family":0.75,"physical_touch":0.82,"introvert_extrovert":0.36,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 327', 21, 'male', 'Designer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.60228830486083, 10.76594344333922), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 328
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0252052172', 0.60, 0.76, 0.28, 0.69, 0.22, '{"ambition":0.6,"family":0.76,"physical_touch":0.28,"introvert_extrovert":0.69,"loyalty":0.22}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 328', 38, 'male', 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.54274874797869, 10.655234256276264), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 329
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0662536944', 0.73, 0.52, 0.06, 0.22, 0.23, '{"ambition":0.73,"family":0.52,"physical_touch":0.06,"introvert_extrovert":0.22,"loyalty":0.23}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 329', 33, 'female', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.4796697397245, 10.903509615739972), '["Ẩm thực","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 330
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0118097543', 0.88, 0.19, 0.24, 0.73, 0.13, '{"ambition":0.88,"family":0.19,"physical_touch":0.24,"introvert_extrovert":0.73,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 330', 26, 'female', 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.64456844080597, 10.860418010752685), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 331
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0885046217', 0.18, 0.93, 0.73, 0.90, 0.91, '{"ambition":0.18,"family":0.93,"physical_touch":0.73,"introvert_extrovert":0.9,"loyalty":0.91}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 331', 36, 'male', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.5074315634833, 10.629114586481704), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 332
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0656666965', 0.24, 0.96, 0.33, 0.57, 0.84, '{"ambition":0.24,"family":0.96,"physical_touch":0.33,"introvert_extrovert":0.57,"loyalty":0.84}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 332', 21, 'male', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.43111931608011, 10.811915951189368), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 333
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0106661941', 0.20, 0.23, 0.52, 0.05, 0.94, '{"ambition":0.2,"family":0.23,"physical_touch":0.52,"introvert_extrovert":0.05,"loyalty":0.94}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 333', 22, 'female', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.83257331087015, 10.718067317662868), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 334
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0999071311', 0.44, 0.97, 0.89, 0.47, 0.28, '{"ambition":0.44,"family":0.97,"physical_touch":0.89,"introvert_extrovert":0.47,"loyalty":0.28}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 334', 33, 'male', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.64657344146005, 10.526071727523549), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 335
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0628454767', 0.48, 0.93, 0.24, 0.70, 0.50, '{"ambition":0.48,"family":0.93,"physical_touch":0.24,"introvert_extrovert":0.7,"loyalty":0.5}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 335', 22, 'other', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.78473086327234, 10.768402669402823), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 336
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0352216131', 0.46, 0.98, 0.49, 0.31, 0.31, '{"ambition":0.46,"family":0.98,"physical_touch":0.49,"introvert_extrovert":0.31,"loyalty":0.31}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 336', 21, 'female', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.85326380180456, 10.888323957406792), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 337
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0301818968', 0.42, 0.05, 0.34, 0.85, 0.43, '{"ambition":0.42,"family":0.05,"physical_touch":0.34,"introvert_extrovert":0.85,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 337', 30, 'other', 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.77204871718267, 10.708959958433512), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 338
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0660073953', 0.03, 0.77, 0.99, 0.52, 0.99, '{"ambition":0.03,"family":0.77,"physical_touch":0.99,"introvert_extrovert":0.52,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 338', 28, 'female', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.51587786453523, 10.983242485265718), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 339
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0187163739', 0.06, 0.97, 0.21, 0.79, 0.86, '{"ambition":0.06,"family":0.97,"physical_touch":0.21,"introvert_extrovert":0.79,"loyalty":0.86}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 339', 32, 'male', 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.44430547920663, 10.64004427628666), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 340
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0684687194', 0.48, 0.05, 0.34, 0.96, 0.74, '{"ambition":0.48,"family":0.05,"physical_touch":0.34,"introvert_extrovert":0.96,"loyalty":0.74}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 340', 32, 'other', 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.54159554977338, 10.600062083436345), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 341
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0719299017', 0.95, 0.21, 0.92, 0.22, 0.88, '{"ambition":0.95,"family":0.21,"physical_touch":0.92,"introvert_extrovert":0.22,"loyalty":0.88}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 341', 31, 'other', 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.54841727075295, 10.870381902211044), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 342
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0659008651', 0.93, 0.74, 0.83, 0.72, 0.04, '{"ambition":0.93,"family":0.74,"physical_touch":0.83,"introvert_extrovert":0.72,"loyalty":0.04}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 342', 38, 'male', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.77308482436479, 10.636182520695893), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 343
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0478033194', 0.65, 0.88, 0.46, 0.76, 0.34, '{"ambition":0.65,"family":0.88,"physical_touch":0.46,"introvert_extrovert":0.76,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 343', 38, 'other', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.77382554563013, 10.72894411526142), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 344
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0567676920', 0.75, 0.12, 0.62, 0.25, 0.17, '{"ambition":0.75,"family":0.12,"physical_touch":0.62,"introvert_extrovert":0.25,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 344', 35, 'other', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.76407332560427, 10.730816436894546), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 345
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0870274408', 0.60, 0.38, 0.62, 0.07, 0.11, '{"ambition":0.6,"family":0.38,"physical_touch":0.62,"introvert_extrovert":0.07,"loyalty":0.11}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 345', 38, 'other', 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.84287427001084, 10.671462174114602), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 346
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0646472554', 0.44, 0.27, 0.27, 0.01, 0.18, '{"ambition":0.44,"family":0.27,"physical_touch":0.27,"introvert_extrovert":0.01,"loyalty":0.18}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 346', 22, 'female', 'Developer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.49939134004319, 10.825481891146385), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 347
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0670334179', 0.32, 0.43, 0.50, 0.90, 0.83, '{"ambition":0.32,"family":0.43,"physical_touch":0.5,"introvert_extrovert":0.9,"loyalty":0.83}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 347', 31, 'other', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.44944902735314, 10.599486823844554), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 348
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0139357039', 0.80, 0.58, 0.87, 0.56, 0.68, '{"ambition":0.8,"family":0.58,"physical_touch":0.87,"introvert_extrovert":0.56,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 348', 33, 'other', 'Developer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.65762149036462, 10.656348576502005), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 349
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0658832093', 0.41, 0.59, 0.45, 0.09, 0.97, '{"ambition":0.41,"family":0.59,"physical_touch":0.45,"introvert_extrovert":0.09,"loyalty":0.97}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 349', 28, 'male', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.50968986603739, 10.993818679650948), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 350
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0925141834', 0.10, 0.45, 0.91, 0.51, 0.01, '{"ambition":0.1,"family":0.45,"physical_touch":0.91,"introvert_extrovert":0.51,"loyalty":0.01}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 350', 26, 'other', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.83519745832716, 10.886534242065768), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 351
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0221392901', 0.40, 0.49, 0.31, 0.63, 0.72, '{"ambition":0.4,"family":0.49,"physical_touch":0.31,"introvert_extrovert":0.63,"loyalty":0.72}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 351', 31, 'other', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(106.73577772996066, 10.961252121135685), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 352
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0475892866', 0.47, 0.03, 0.46, 0.27, 0.61, '{"ambition":0.47,"family":0.03,"physical_touch":0.46,"introvert_extrovert":0.27,"loyalty":0.61}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 352', 34, 'female', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.60157554396686, 10.898336504216466), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 353
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0494204248', 0.57, 0.22, 0.66, 0.49, 0.05, '{"ambition":0.57,"family":0.22,"physical_touch":0.66,"introvert_extrovert":0.49,"loyalty":0.05}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 353', 23, 'other', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.6322869786743, 10.819611696041026), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 354
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0233156150', 0.35, 0.36, 0.82, 0.57, 0.13, '{"ambition":0.35,"family":0.36,"physical_touch":0.82,"introvert_extrovert":0.57,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 354', 31, 'female', 'Sinh viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.4859304133601, 10.704814672908094), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 355
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0919354095', 0.91, 0.47, 0.02, 0.08, 0.75, '{"ambition":0.91,"family":0.47,"physical_touch":0.02,"introvert_extrovert":0.08,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 355', 28, 'other', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.7032231714285, 10.991150044196536), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 356
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0535947130', 0.36, 0.39, 0.70, 0.35, 0.59, '{"ambition":0.36,"family":0.39,"physical_touch":0.7,"introvert_extrovert":0.35,"loyalty":0.59}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 356', 34, 'other', 'Giáo viên', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.46104637580184, 11.011367714491156), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 357
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0409963043', 0.58, 0.78, 0.86, 0.35, 0.04, '{"ambition":0.58,"family":0.78,"physical_touch":0.86,"introvert_extrovert":0.35,"loyalty":0.04}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 357', 39, 'other', 'Designer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.86596308842364, 10.879886107556171), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 358
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0229310767', 0.91, 0.26, 0.54, 0.76, 0.17, '{"ambition":0.91,"family":0.26,"physical_touch":0.54,"introvert_extrovert":0.76,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 358', 24, 'other', 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.52714102349393, 10.517219452620184), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 359
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0255301083', 0.94, 0.20, 0.64, 0.37, 0.43, '{"ambition":0.94,"family":0.2,"physical_touch":0.64,"introvert_extrovert":0.37,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 359', 24, 'other', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.53040884026134, 10.920778940599172), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 360
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0907818285', 0.11, 0.91, 0.88, 0.96, 0.57, '{"ambition":0.11,"family":0.91,"physical_touch":0.88,"introvert_extrovert":0.96,"loyalty":0.57}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 360', 35, 'male', 'Kinh doanh', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.44888945711655, 10.890466723883092), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 361
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0445658895', 0.90, 0.01, 0.50, 0.56, 0.70, '{"ambition":0.9,"family":0.01,"physical_touch":0.5,"introvert_extrovert":0.56,"loyalty":0.7}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 361', 24, 'male', 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.54797519862193, 10.63506805415073), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 362
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0868360840', 0.50, 0.66, 0.92, 0.98, 0.58, '{"ambition":0.5,"family":0.66,"physical_touch":0.92,"introvert_extrovert":0.98,"loyalty":0.58}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 362', 33, 'other', 'Designer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.85065360503941, 10.525733085414586), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 363
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0147769330', 0.52, 0.44, 0.53, 0.45, 0.85, '{"ambition":0.52,"family":0.44,"physical_touch":0.53,"introvert_extrovert":0.45,"loyalty":0.85}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 363', 37, 'other', 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.52299216583923, 10.809131673038348), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 364
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0248967375', 0.72, 0.81, 0.78, 0.27, 0.95, '{"ambition":0.72,"family":0.81,"physical_touch":0.78,"introvert_extrovert":0.27,"loyalty":0.95}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 364', 29, 'other', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.58076807396209, 10.89324568294344), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 365
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0301616823', 0.42, 0.45, 0.23, 0.94, 0.12, '{"ambition":0.42,"family":0.45,"physical_touch":0.23,"introvert_extrovert":0.94,"loyalty":0.12}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 365', 38, 'female', 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.69634826452871, 10.828679580902634), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 366
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0487636752', 0.73, 0.04, 0.49, 0.63, 0.03, '{"ambition":0.73,"family":0.04,"physical_touch":0.49,"introvert_extrovert":0.63,"loyalty":0.03}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 366', 23, 'male', 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.57706032010793, 10.761216004868368), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 367
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0749319729', 0.37, 0.87, 0.23, 0.11, 0.28, '{"ambition":0.37,"family":0.87,"physical_touch":0.23,"introvert_extrovert":0.11,"loyalty":0.28}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 367', 32, 'other', 'Designer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.43966494365884, 10.672703348529618), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 368
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0898677968', 0.15, 0.07, 0.38, 0.38, 0.34, '{"ambition":0.15,"family":0.07,"physical_touch":0.38,"introvert_extrovert":0.38,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 368', 37, 'female', 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.57929353921692, 10.880587571283225), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 369
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0252896909', 0.33, 0.75, 0.49, 0.81, 0.23, '{"ambition":0.33,"family":0.75,"physical_touch":0.49,"introvert_extrovert":0.81,"loyalty":0.23}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 369', 30, 'male', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(106.71912509755201, 11.008693961740928), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 370
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0885393087', 0.59, 0.47, 0.75, 0.11, 0.04, '{"ambition":0.59,"family":0.47,"physical_touch":0.75,"introvert_extrovert":0.11,"loyalty":0.04}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 370', 24, 'other', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.7526941969787, 10.846919711895334), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 371
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0208110399', 0.58, 0.22, 0.96, 0.34, 0.11, '{"ambition":0.58,"family":0.22,"physical_touch":0.96,"introvert_extrovert":0.34,"loyalty":0.11}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 371', 35, 'other', 'Designer', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.8277693201242, 10.551292376509265), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 372
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0985709680', 0.12, 0.70, 0.99, 0.62, 0.02, '{"ambition":0.12,"family":0.7,"physical_touch":0.99,"introvert_extrovert":0.62,"loyalty":0.02}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 372', 26, 'other', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.41124917420225, 10.708929212135244), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 373
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0370646942', 0.69, 0.59, 0.86, 0.09, 0.93, '{"ambition":0.69,"family":0.59,"physical_touch":0.86,"introvert_extrovert":0.09,"loyalty":0.93}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 373', 36, 'other', 'Developer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.56543216620396, 10.574368449598943), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 374
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0485917227', 0.45, 0.48, 0.00, 0.20, 0.76, '{"ambition":0.45,"family":0.48,"physical_touch":0,"introvert_extrovert":0.2,"loyalty":0.76}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 374', 37, 'other', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.60563828964703, 10.675688350650555), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 375
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0855997460', 0.77, 0.64, 0.48, 0.40, 0.88, '{"ambition":0.77,"family":0.64,"physical_touch":0.48,"introvert_extrovert":0.4,"loyalty":0.88}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 375', 18, 'female', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.46549701113102, 10.818325938623323), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 376
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0916820961', 0.52, 0.58, 0.33, 0.98, 0.85, '{"ambition":0.52,"family":0.58,"physical_touch":0.33,"introvert_extrovert":0.98,"loyalty":0.85}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 376', 26, 'female', 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.44960011181979, 10.569236439201651), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 377
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0550576077', 0.19, 0.77, 0.17, 0.81, 0.60, '{"ambition":0.19,"family":0.77,"physical_touch":0.17,"introvert_extrovert":0.81,"loyalty":0.6}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 377', 30, 'other', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.42476791251853, 10.889322971315), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 378
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0903469678', 0.94, 0.26, 0.02, 0.47, 0.20, '{"ambition":0.94,"family":0.26,"physical_touch":0.02,"introvert_extrovert":0.47,"loyalty":0.2}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 378', 28, 'other', 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.63233415577577, 10.809607513816117), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 379
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0839281106', 0.84, 0.01, 0.60, 0.02, 0.43, '{"ambition":0.84,"family":0.01,"physical_touch":0.6,"introvert_extrovert":0.02,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 379', 34, 'female', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.75209339462567, 10.689386176473688), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 380
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0459367698', 0.54, 0.31, 0.57, 0.75, 0.10, '{"ambition":0.54,"family":0.31,"physical_touch":0.57,"introvert_extrovert":0.75,"loyalty":0.1}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 380', 26, 'female', 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.83338193690356, 10.568211520680704), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 381
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0732667939', 0.20, 0.54, 0.65, 0.58, 0.14, '{"ambition":0.2,"family":0.54,"physical_touch":0.65,"introvert_extrovert":0.58,"loyalty":0.14}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 381', 25, 'male', 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.61901845106783, 10.74836377034874), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 382
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0475255923', 0.34, 0.62, 0.83, 0.77, 0.35, '{"ambition":0.34,"family":0.62,"physical_touch":0.83,"introvert_extrovert":0.77,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 382', 30, 'other', 'Sinh viên', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.89246585271512, 10.871415720273164), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 383
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0490433870', 0.59, 0.43, 0.42, 0.53, 0.92, '{"ambition":0.59,"family":0.43,"physical_touch":0.42,"introvert_extrovert":0.53,"loyalty":0.92}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 383', 34, 'male', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.4488902888156, 10.941863574805582), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 384
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0104617309', 0.14, 0.68, 0.01, 0.80, 0.65, '{"ambition":0.14,"family":0.68,"physical_touch":0.01,"introvert_extrovert":0.8,"loyalty":0.65}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 384', 20, 'male', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.60721372421693, 10.888353783372336), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 385
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0800468869', 0.43, 0.68, 0.38, 0.66, 0.91, '{"ambition":0.43,"family":0.68,"physical_touch":0.38,"introvert_extrovert":0.66,"loyalty":0.91}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 385', 23, 'female', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.90445207355597, 10.637780838988132), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 386
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0387546516', 0.21, 0.50, 0.54, 0.78, 0.94, '{"ambition":0.21,"family":0.5,"physical_touch":0.54,"introvert_extrovert":0.78,"loyalty":0.94}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 386', 33, 'other', 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(106.49523413733183, 10.98627445089939), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 387
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0137829310', 0.38, 0.36, 0.67, 0.73, 0.53, '{"ambition":0.38,"family":0.36,"physical_touch":0.67,"introvert_extrovert":0.73,"loyalty":0.53}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 387', 24, 'male', 'Developer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.73470346876509, 10.694927209954896), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 388
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0470430461', 0.89, 0.04, 0.85, 0.66, 0.43, '{"ambition":0.89,"family":0.04,"physical_touch":0.85,"introvert_extrovert":0.66,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 388', 18, 'female', 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.88823040839239, 10.56593464073339), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 389
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0503141661', 0.65, 0.60, 0.01, 0.09, 0.49, '{"ambition":0.65,"family":0.6,"physical_touch":0.01,"introvert_extrovert":0.09,"loyalty":0.49}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 389', 34, 'male', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.5860771567618, 10.71457866349252), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 390
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0617504169', 0.27, 0.30, 0.05, 0.34, 0.35, '{"ambition":0.27,"family":0.3,"physical_touch":0.05,"introvert_extrovert":0.34,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 390', 38, 'male', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.73596768562058, 10.730356166393356), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 391
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0943850619', 0.52, 0.83, 0.42, 0.98, 0.61, '{"ambition":0.52,"family":0.83,"physical_touch":0.42,"introvert_extrovert":0.98,"loyalty":0.61}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 391', 34, 'male', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.72712870317095, 10.732035745247522), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 392
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0140816054', 1.00, 0.16, 0.83, 0.15, 0.97, '{"ambition":1,"family":0.16,"physical_touch":0.83,"introvert_extrovert":0.15,"loyalty":0.97}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 392', 29, 'other', 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.5699283651316, 10.522988469521179), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 393
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0822220714', 0.46, 0.41, 0.29, 0.34, 0.75, '{"ambition":0.46,"family":0.41,"physical_touch":0.29,"introvert_extrovert":0.34,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 393', 28, 'male', 'Developer', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.64262604208132, 10.96288967986964), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 394
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0852442718', 0.50, 0.66, 0.97, 0.96, 0.25, '{"ambition":0.5,"family":0.66,"physical_touch":0.97,"introvert_extrovert":0.96,"loyalty":0.25}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 394', 18, 'male', 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.56386535189708, 10.699629910379096), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 395
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0486333649', 0.35, 0.28, 0.09, 0.98, 0.70, '{"ambition":0.35,"family":0.28,"physical_touch":0.09,"introvert_extrovert":0.98,"loyalty":0.7}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 395', 29, 'female', 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.75914059557418, 10.987493740444833), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 396
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0666444831', 0.92, 0.62, 0.13, 0.83, 0.95, '{"ambition":0.92,"family":0.62,"physical_touch":0.13,"introvert_extrovert":0.83,"loyalty":0.95}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 396', 37, 'female', 'Giáo viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.86572691908624, 10.892030193762942), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 397
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0870436833', 0.66, 0.50, 0.16, 0.54, 0.40, '{"ambition":0.66,"family":0.5,"physical_touch":0.16,"introvert_extrovert":0.54,"loyalty":0.4}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 397', 33, 'other', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.67240165432332, 10.751429494321052), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 398
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0614226699', 0.88, 0.88, 0.65, 0.32, 0.01, '{"ambition":0.88,"family":0.88,"physical_touch":0.65,"introvert_extrovert":0.32,"loyalty":0.01}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 398', 24, 'other', 'Designer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.56661167852533, 10.813817224008368), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 399
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0241012563', 0.05, 0.05, 0.87, 0.76, 0.44, '{"ambition":0.05,"family":0.05,"physical_touch":0.87,"introvert_extrovert":0.76,"loyalty":0.44}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 399', 19, 'other', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.57996811594904, 10.723230824896067), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 400
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0199334839', 0.62, 0.00, 0.79, 0.27, 0.15, '{"ambition":0.62,"family":0,"physical_touch":0.79,"introvert_extrovert":0.27,"loyalty":0.15}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 400', 18, 'male', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.73167189261306, 10.533564598866098), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 401
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0690962149', 0.31, 0.44, 0.71, 0.66, 0.68, '{"ambition":0.31,"family":0.44,"physical_touch":0.71,"introvert_extrovert":0.66,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 401', 32, 'female', 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.72173536167041, 10.72236601919292), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 402
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0387672415', 0.62, 0.07, 0.44, 0.13, 0.34, '{"ambition":0.62,"family":0.07,"physical_touch":0.44,"introvert_extrovert":0.13,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 402', 19, 'male', 'Giáo viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.41772847004697, 10.791969985528212), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 403
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0955819414', 0.36, 0.92, 0.83, 0.81, 0.26, '{"ambition":0.36,"family":0.92,"physical_touch":0.83,"introvert_extrovert":0.81,"loyalty":0.26}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 403', 32, 'female', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.72045517096971, 10.748610573423482), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 404
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0591698339', 0.29, 0.91, 1.00, 0.97, 0.37, '{"ambition":0.29,"family":0.91,"physical_touch":1,"introvert_extrovert":0.97,"loyalty":0.37}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 404', 18, 'female', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.59434619368731, 11.00873165206347), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 405
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0315587307', 0.50, 0.38, 0.90, 0.98, 0.92, '{"ambition":0.5,"family":0.38,"physical_touch":0.9,"introvert_extrovert":0.98,"loyalty":0.92}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 405', 22, 'female', 'Developer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.82626792390239, 10.800045879410336), '["Ẩm thực","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 406
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0444582958', 0.83, 0.77, 0.91, 0.72, 0.33, '{"ambition":0.83,"family":0.77,"physical_touch":0.91,"introvert_extrovert":0.72,"loyalty":0.33}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 406', 30, 'other', 'Bác sĩ', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.72162010152464, 10.868275492866703), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 407
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0173742170', 0.30, 0.54, 0.25, 0.80, 0.60, '{"ambition":0.3,"family":0.54,"physical_touch":0.25,"introvert_extrovert":0.8,"loyalty":0.6}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 407', 30, 'other', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.72714641739695, 10.601961462861928), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 408
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0617592727', 0.36, 0.82, 0.11, 0.07, 0.04, '{"ambition":0.36,"family":0.82,"physical_touch":0.11,"introvert_extrovert":0.07,"loyalty":0.04}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 408', 30, 'other', 'Sinh viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.5468350757639, 10.999408046653834), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 409
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0215912650', 0.93, 0.19, 0.07, 0.60, 0.87, '{"ambition":0.93,"family":0.19,"physical_touch":0.07,"introvert_extrovert":0.6,"loyalty":0.87}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 409', 36, 'male', 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.7601977161416, 10.565514397340841), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 410
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0606561341', 0.07, 0.89, 0.14, 0.51, 0.76, '{"ambition":0.07,"family":0.89,"physical_touch":0.14,"introvert_extrovert":0.51,"loyalty":0.76}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 410', 36, 'other', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.73894353577505, 10.831545071129518), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 411
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0499284617', 0.36, 0.68, 0.35, 0.71, 0.07, '{"ambition":0.36,"family":0.68,"physical_touch":0.35,"introvert_extrovert":0.71,"loyalty":0.07}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 411', 23, 'other', 'Designer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.85374111395457, 10.685342366150925), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 412
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0170587731', 0.30, 0.19, 0.30, 0.32, 0.51, '{"ambition":0.3,"family":0.19,"physical_touch":0.3,"introvert_extrovert":0.32,"loyalty":0.51}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 412', 20, 'other', 'Sinh viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.81350008369756, 10.99463307520759), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 413
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0614019890', 0.88, 0.96, 0.12, 0.49, 0.09, '{"ambition":0.88,"family":0.96,"physical_touch":0.12,"introvert_extrovert":0.49,"loyalty":0.09}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 413', 19, 'male', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.85723160148048, 10.7337155056268), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 414
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0293164864', 0.61, 0.81, 0.81, 0.32, 1.00, '{"ambition":0.61,"family":0.81,"physical_touch":0.81,"introvert_extrovert":0.32,"loyalty":1}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 414', 20, 'male', 'Designer', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(106.85507309977291, 10.904958414174905), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 415
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0372937678', 0.25, 0.41, 0.77, 0.64, 0.76, '{"ambition":0.25,"family":0.41,"physical_touch":0.77,"introvert_extrovert":0.64,"loyalty":0.76}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 415', 23, 'female', 'Developer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.63621276480148, 10.924945066726892), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 416
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0416909862', 0.50, 0.92, 0.61, 0.98, 0.36, '{"ambition":0.5,"family":0.92,"physical_touch":0.61,"introvert_extrovert":0.98,"loyalty":0.36}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 416', 28, 'other', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.89141904272155, 10.884159398296008), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 417
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0926603577', 0.50, 0.60, 0.12, 0.55, 0.81, '{"ambition":0.5,"family":0.6,"physical_touch":0.12,"introvert_extrovert":0.55,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 417', 23, 'other', 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(106.42568848305542, 10.956002641692862), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 418
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0728240409', 0.04, 0.45, 0.65, 0.70, 0.30, '{"ambition":0.04,"family":0.45,"physical_touch":0.65,"introvert_extrovert":0.7,"loyalty":0.3}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 418', 22, 'male', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.53264088123262, 10.554305960639596), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 419
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0920589849', 0.69, 0.26, 0.65, 0.34, 0.16, '{"ambition":0.69,"family":0.26,"physical_touch":0.65,"introvert_extrovert":0.34,"loyalty":0.16}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 419', 29, 'female', 'Designer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.79751358640412, 10.651387873782006), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 420
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0744408543', 0.92, 0.02, 0.06, 0.05, 0.24, '{"ambition":0.92,"family":0.02,"physical_touch":0.06,"introvert_extrovert":0.05,"loyalty":0.24}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 420', 39, 'female', 'Developer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.81461315451286, 10.833461239163839), '["Ẩm thực","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 421
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0934520913', 0.04, 0.61, 0.94, 0.78, 0.38, '{"ambition":0.04,"family":0.61,"physical_touch":0.94,"introvert_extrovert":0.78,"loyalty":0.38}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 421', 39, 'female', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.85329052927226, 10.754605871480036), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 422
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0729298314', 0.57, 0.96, 0.66, 0.72, 0.34, '{"ambition":0.57,"family":0.96,"physical_touch":0.66,"introvert_extrovert":0.72,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 422', 28, 'other', 'Bác sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(106.8172785255752, 10.74495945389777), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 423
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0601011563', 0.20, 0.05, 0.17, 0.37, 0.90, '{"ambition":0.2,"family":0.05,"physical_touch":0.17,"introvert_extrovert":0.37,"loyalty":0.9}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 423', 22, 'female', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.76934238144719, 10.845477340931664), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 424
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0108150319', 0.12, 0.28, 0.09, 0.16, 0.61, '{"ambition":0.12,"family":0.28,"physical_touch":0.09,"introvert_extrovert":0.16,"loyalty":0.61}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 424', 31, 'female', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.82568259128071, 10.519812368765095), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 425
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0364533025', 0.28, 0.68, 0.69, 0.47, 0.61, '{"ambition":0.28,"family":0.68,"physical_touch":0.69,"introvert_extrovert":0.47,"loyalty":0.61}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 425', 37, 'other', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.57442620330355, 10.763695007622697), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 426
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0695803739', 0.23, 0.66, 0.29, 0.37, 0.99, '{"ambition":0.23,"family":0.66,"physical_touch":0.29,"introvert_extrovert":0.37,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 426', 30, 'male', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.47238104425129, 10.861346360977217), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 427
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0595262281', 0.71, 0.33, 0.53, 0.38, 0.83, '{"ambition":0.71,"family":0.33,"physical_touch":0.53,"introvert_extrovert":0.38,"loyalty":0.83}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 427', 24, 'male', 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.48190181907471, 10.920315953439454), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 428
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0745866109', 0.97, 0.09, 0.34, 0.29, 0.31, '{"ambition":0.97,"family":0.09,"physical_touch":0.34,"introvert_extrovert":0.29,"loyalty":0.31}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 428', 36, 'female', 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.54180371228338, 10.994534634859777), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 429
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0154663546', 0.91, 0.79, 0.18, 0.77, 0.36, '{"ambition":0.91,"family":0.79,"physical_touch":0.18,"introvert_extrovert":0.77,"loyalty":0.36}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 429', 34, 'female', 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.61482256788227, 10.908366240435313), '["Ẩm thực","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 430
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0495667895', 0.78, 0.80, 0.67, 0.68, 0.81, '{"ambition":0.78,"family":0.8,"physical_touch":0.67,"introvert_extrovert":0.68,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 430', 33, 'other', 'Developer', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.68113076610302, 10.564117098691883), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 431
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0819334673', 0.05, 0.88, 0.14, 0.30, 0.22, '{"ambition":0.05,"family":0.88,"physical_touch":0.14,"introvert_extrovert":0.3,"loyalty":0.22}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 431', 31, 'female', 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.59834004181916, 10.636136855283292), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 432
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0976210355', 0.93, 0.93, 0.94, 0.09, 0.46, '{"ambition":0.93,"family":0.93,"physical_touch":0.94,"introvert_extrovert":0.09,"loyalty":0.46}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 432', 30, 'male', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.46941957468665, 10.68624650108978), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 433
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0102158924', 0.40, 0.04, 0.30, 0.53, 0.81, '{"ambition":0.4,"family":0.04,"physical_touch":0.3,"introvert_extrovert":0.53,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 433', 28, 'other', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.78375913802277, 10.967958901776182), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 434
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0769197825', 0.80, 0.51, 0.29, 0.62, 0.20, '{"ambition":0.8,"family":0.51,"physical_touch":0.29,"introvert_extrovert":0.62,"loyalty":0.2}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 434', 26, 'female', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.65057522924494, 10.805537624231235), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 435
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0447065499', 0.33, 0.91, 0.62, 0.18, 0.58, '{"ambition":0.33,"family":0.91,"physical_touch":0.62,"introvert_extrovert":0.18,"loyalty":0.58}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 435', 23, 'male', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(106.52878685114453, 10.916032741787902), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 436
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0772852261', 0.31, 0.39, 0.51, 0.07, 0.02, '{"ambition":0.31,"family":0.39,"physical_touch":0.51,"introvert_extrovert":0.07,"loyalty":0.02}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 436', 23, 'other', 'Bác sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.86201440852513, 10.924050666760087), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 437
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0464601777', 0.62, 0.39, 0.07, 0.06, 0.68, '{"ambition":0.62,"family":0.39,"physical_touch":0.07,"introvert_extrovert":0.06,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 437', 32, 'other', 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.83261972897155, 10.948691646901743), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 438
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0457804386', 0.03, 0.02, 0.09, 0.99, 0.19, '{"ambition":0.03,"family":0.02,"physical_touch":0.09,"introvert_extrovert":0.99,"loyalty":0.19}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 438', 21, 'male', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.60057654750885, 10.898957709203577), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 439
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0226699633', 0.90, 0.99, 0.97, 0.87, 0.53, '{"ambition":0.9,"family":0.99,"physical_touch":0.97,"introvert_extrovert":0.87,"loyalty":0.53}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 439', 27, 'female', 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.43579320650792, 10.572373925108124), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 440
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0755957926', 0.43, 0.45, 0.58, 0.22, 0.18, '{"ambition":0.43,"family":0.45,"physical_touch":0.58,"introvert_extrovert":0.22,"loyalty":0.18}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 440', 31, 'male', 'Designer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.41940153198276, 10.957873483087996), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 441
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0103398863', 0.55, 0.22, 0.07, 0.58, 0.73, '{"ambition":0.55,"family":0.22,"physical_touch":0.07,"introvert_extrovert":0.58,"loyalty":0.73}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 441', 25, 'other', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.66202242457554, 10.566534499683051), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 442
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0694648199', 0.76, 0.99, 0.64, 0.83, 0.77, '{"ambition":0.76,"family":0.99,"physical_touch":0.64,"introvert_extrovert":0.83,"loyalty":0.77}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 442', 32, 'male', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.58113520421968, 10.611638992468812), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 443
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0518161778', 0.01, 0.71, 0.71, 0.74, 0.61, '{"ambition":0.01,"family":0.71,"physical_touch":0.71,"introvert_extrovert":0.74,"loyalty":0.61}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 443', 19, 'male', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.50550851536973, 10.669892403235192), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 444
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0167568719', 0.86, 0.74, 0.45, 0.12, 0.69, '{"ambition":0.86,"family":0.74,"physical_touch":0.45,"introvert_extrovert":0.12,"loyalty":0.69}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 444', 37, 'male', 'Bác sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.91001281068864, 10.637275447756767), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 445
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0491006368', 0.33, 0.51, 0.34, 0.49, 0.30, '{"ambition":0.33,"family":0.51,"physical_touch":0.34,"introvert_extrovert":0.49,"loyalty":0.3}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 445', 33, 'other', 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.86343861450788, 10.741830586802903), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 446
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0820368454', 0.49, 0.15, 0.54, 0.00, 0.30, '{"ambition":0.49,"family":0.15,"physical_touch":0.54,"introvert_extrovert":0,"loyalty":0.3}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 446', 32, 'female', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.83641597509336, 10.71687962886022), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 447
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0969761639', 0.95, 0.83, 0.63, 0.85, 0.28, '{"ambition":0.95,"family":0.83,"physical_touch":0.63,"introvert_extrovert":0.85,"loyalty":0.28}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 447', 39, 'male', 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.87525966519371, 10.695015371315568), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 448
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0901807956', 0.10, 0.34, 0.57, 0.19, 0.78, '{"ambition":0.1,"family":0.34,"physical_touch":0.57,"introvert_extrovert":0.19,"loyalty":0.78}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 448', 30, 'other', 'Sinh viên', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.48162534424372, 10.944238337585317), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 449
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0774490040', 0.70, 0.49, 0.30, 0.66, 0.08, '{"ambition":0.7,"family":0.49,"physical_touch":0.3,"introvert_extrovert":0.66,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 449', 19, 'female', 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(106.6982488438651, 10.734015835810448), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 450
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0187050993', 0.23, 0.59, 0.81, 0.27, 0.12, '{"ambition":0.23,"family":0.59,"physical_touch":0.81,"introvert_extrovert":0.27,"loyalty":0.12}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 450', 29, 'female', 'Sinh viên', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.47034570180341, 10.56091671667382), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 451
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0375104189', 0.47, 0.14, 0.02, 0.99, 0.66, '{"ambition":0.47,"family":0.14,"physical_touch":0.02,"introvert_extrovert":0.99,"loyalty":0.66}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 451', 19, 'other', 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(106.6013632336503, 10.622569559552211), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 452
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0704982301', 0.91, 0.48, 0.94, 0.97, 0.75, '{"ambition":0.91,"family":0.48,"physical_touch":0.94,"introvert_extrovert":0.97,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 452', 38, 'male', 'Developer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.89705194795827, 10.651546447368125), '["Công nghệ","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 453
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0439097794', 0.96, 0.61, 0.84, 0.69, 0.94, '{"ambition":0.96,"family":0.61,"physical_touch":0.84,"introvert_extrovert":0.69,"loyalty":0.94}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 453', 25, 'female', 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.6059373333781, 10.671006832009699), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 454
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0918249124', 0.74, 0.73, 0.02, 0.71, 0.06, '{"ambition":0.74,"family":0.73,"physical_touch":0.02,"introvert_extrovert":0.71,"loyalty":0.06}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 454', 37, 'female', 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.90194559203564, 10.88262385232686), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 455
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0454010387', 0.85, 0.38, 0.46, 0.18, 0.34, '{"ambition":0.85,"family":0.38,"physical_touch":0.46,"introvert_extrovert":0.18,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 455', 21, 'female', 'Developer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.8317415470984, 10.799845679992716), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 456
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0984915452', 0.73, 0.82, 0.76, 0.24, 0.75, '{"ambition":0.73,"family":0.82,"physical_touch":0.76,"introvert_extrovert":0.24,"loyalty":0.75}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 456', 37, 'male', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.4421165120463, 10.613924598322727), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 457
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0565563162', 0.37, 0.78, 0.37, 0.29, 0.97, '{"ambition":0.37,"family":0.78,"physical_touch":0.37,"introvert_extrovert":0.29,"loyalty":0.97}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 457', 35, 'male', 'Developer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.83027147975639, 10.750651036649801), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 458
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0187977524', 0.31, 0.98, 0.80, 0.46, 0.67, '{"ambition":0.31,"family":0.98,"physical_touch":0.8,"introvert_extrovert":0.46,"loyalty":0.67}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 458', 33, 'other', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.58419464780243, 10.619189997550574), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 459
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0813333413', 0.90, 0.93, 0.14, 0.10, 0.17, '{"ambition":0.9,"family":0.93,"physical_touch":0.14,"introvert_extrovert":0.1,"loyalty":0.17}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 459', 34, 'female', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.63145466337959, 10.77128879061766), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 460
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0875460607', 0.23, 0.68, 0.30, 0.73, 0.08, '{"ambition":0.23,"family":0.68,"physical_touch":0.3,"introvert_extrovert":0.73,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 460', 20, 'male', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.67881639971824, 10.583098742454663), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 461
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0607666206', 0.87, 0.51, 0.35, 0.56, 0.41, '{"ambition":0.87,"family":0.51,"physical_touch":0.35,"introvert_extrovert":0.56,"loyalty":0.41}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 461', 29, 'other', 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(106.88254953544379, 10.820593877581063), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 462
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0555382158', 0.84, 0.05, 0.28, 0.86, 0.13, '{"ambition":0.84,"family":0.05,"physical_touch":0.28,"introvert_extrovert":0.86,"loyalty":0.13}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 462', 34, 'other', 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.71602871261565, 10.553858362939643), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 463
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0925808598', 0.72, 0.30, 0.41, 0.41, 0.34, '{"ambition":0.72,"family":0.3,"physical_touch":0.41,"introvert_extrovert":0.41,"loyalty":0.34}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Hương 463', 24, 'male', 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(106.60864905933414, 10.709008730736512), '["Công nghệ","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 464
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0109572139', 0.84, 0.85, 0.68, 0.00, 0.80, '{"ambition":0.84,"family":0.85,"physical_touch":0.68,"introvert_extrovert":0,"loyalty":0.8}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 464', 36, 'other', 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(106.53234490256597, 10.78528544595497), '["Công nghệ","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 465
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0887553333', 0.61, 0.28, 0.70, 0.30, 0.97, '{"ambition":0.61,"family":0.28,"physical_touch":0.7,"introvert_extrovert":0.3,"loyalty":0.97}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 465', 26, 'other', 'Bác sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.56211602723151, 10.64931369977914), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 466
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0928614741', 0.70, 0.61, 0.35, 0.00, 0.52, '{"ambition":0.7,"family":0.61,"physical_touch":0.35,"introvert_extrovert":0,"loyalty":0.52}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 466', 33, 'other', 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.84870805028162, 10.892850564388361), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 467
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0321649598', 0.09, 0.28, 0.44, 0.47, 0.08, '{"ambition":0.09,"family":0.28,"physical_touch":0.44,"introvert_extrovert":0.47,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 467', 37, 'other', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.67679078214792, 10.94198359887574), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 468
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0101167081', 0.31, 0.58, 0.89, 0.59, 0.35, '{"ambition":0.31,"family":0.58,"physical_touch":0.89,"introvert_extrovert":0.59,"loyalty":0.35}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 468', 35, 'male', 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(106.60474280481809, 10.649252707639409), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 469
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0857763682', 0.20, 0.74, 0.46, 0.51, 0.43, '{"ambition":0.2,"family":0.74,"physical_touch":0.46,"introvert_extrovert":0.51,"loyalty":0.43}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 469', 37, 'other', 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(106.64762076970966, 10.56485827123462), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 470
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0256586371', 0.77, 0.79, 0.61, 0.85, 0.00, '{"ambition":0.77,"family":0.79,"physical_touch":0.61,"introvert_extrovert":0.85,"loyalty":0}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 470', 29, 'other', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.5354740214879, 10.818106618164176), '["Ẩm thực","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 471
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0325846696', 0.40, 0.36, 0.80, 0.66, 0.94, '{"ambition":0.4,"family":0.36,"physical_touch":0.8,"introvert_extrovert":0.66,"loyalty":0.94}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 471', 32, 'female', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.55288342439923, 10.812041233195202), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 472
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0185721886', 0.59, 0.48, 0.23, 0.77, 0.44, '{"ambition":0.59,"family":0.48,"physical_touch":0.23,"introvert_extrovert":0.77,"loyalty":0.44}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 472', 20, 'other', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.82309345369393, 10.81357215111656), '["Âm nhạc","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 473
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0316694267', 0.69, 0.96, 0.63, 0.65, 0.36, '{"ambition":0.69,"family":0.96,"physical_touch":0.63,"introvert_extrovert":0.65,"loyalty":0.36}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 473', 29, 'female', 'Kinh doanh', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.48585287466113, 10.636658155460115), '["Âm nhạc","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 474
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0844064390', 0.88, 0.02, 0.20, 0.30, 0.73, '{"ambition":0.88,"family":0.02,"physical_touch":0.2,"introvert_extrovert":0.3,"loyalty":0.73}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 474', 21, 'other', 'Giáo viên', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.49702705123914, 10.532949113465367), '["Công nghệ","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 475
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0691778221', 0.01, 0.52, 0.58, 0.53, 0.79, '{"ambition":0.01,"family":0.52,"physical_touch":0.58,"introvert_extrovert":0.53,"loyalty":0.79}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Anh 475', 24, 'male', 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(106.48612520663163, 10.951764614327907), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 476
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0967703651', 0.01, 0.96, 0.18, 0.25, 0.90, '{"ambition":0.01,"family":0.96,"physical_touch":0.18,"introvert_extrovert":0.25,"loyalty":0.9}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 476', 33, 'female', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.74402519533967, 10.514607512599257), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 477
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0635763833', 0.90, 0.98, 0.77, 0.76, 0.04, '{"ambition":0.9,"family":0.98,"physical_touch":0.77,"introvert_extrovert":0.76,"loyalty":0.04}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Tuấn 477', 24, 'female', 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(106.88471405404215, 10.734926411474218), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 478
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0790587629', 0.61, 0.68, 0.79, 0.79, 0.85, '{"ambition":0.61,"family":0.68,"physical_touch":0.79,"introvert_extrovert":0.79,"loyalty":0.85}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Quân 478', 30, 'male', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.55069511404007, 10.51986159161132), '["Thú cưng","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 479
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0509583573', 0.36, 0.77, 0.63, 0.67, 0.73, '{"ambition":0.36,"family":0.77,"physical_touch":0.63,"introvert_extrovert":0.67,"loyalty":0.73}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Linh 479', 21, 'female', 'Developer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.47417618124022, 10.873816261270443), '["Thú cưng","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 480
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0787728733', 0.02, 0.59, 0.35, 0.78, 0.05, '{"ambition":0.02,"family":0.59,"physical_touch":0.35,"introvert_extrovert":0.78,"loyalty":0.05}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 480', 33, 'female', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.52330351466179, 10.780268560011729), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 481
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0818265106', 0.84, 0.14, 0.07, 0.06, 0.81, '{"ambition":0.84,"family":0.14,"physical_touch":0.07,"introvert_extrovert":0.06,"loyalty":0.81}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 481', 27, 'other', 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(106.759460139971, 10.814522415588929), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 482
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0482405618', 0.34, 0.82, 0.99, 0.63, 0.08, '{"ambition":0.34,"family":0.82,"physical_touch":0.99,"introvert_extrovert":0.63,"loyalty":0.08}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 482', 31, 'other', 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(106.83382180463973, 10.893885807051419), '["Âm nhạc","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 483
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0625915353', 0.54, 0.96, 0.13, 0.77, 0.97, '{"ambition":0.54,"family":0.96,"physical_touch":0.13,"introvert_extrovert":0.77,"loyalty":0.97}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ngọc 483', 34, 'other', 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.626094068234, 10.717699281322517), '["Sách","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 484
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0414678203', 0.83, 0.49, 0.73, 0.64, 0.99, '{"ambition":0.83,"family":0.49,"physical_touch":0.73,"introvert_extrovert":0.64,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Phúc 484', 38, 'male', 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.43769901557019, 10.547548241476834), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 485
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0696788386', 0.97, 0.58, 0.13, 0.83, 0.53, '{"ambition":0.97,"family":0.58,"physical_touch":0.13,"introvert_extrovert":0.83,"loyalty":0.53}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 485', 30, 'male', 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.86075963265024, 10.67080252978734), '["Âm nhạc","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 486
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0461395542', 0.72, 0.66, 0.18, 0.75, 0.93, '{"ambition":0.72,"family":0.66,"physical_touch":0.18,"introvert_extrovert":0.75,"loyalty":0.93}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Vân 486', 32, 'other', 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(106.51890833805032, 10.751126205151587), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 487
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0403842756', 0.34, 0.11, 0.64, 0.65, 0.62, '{"ambition":0.34,"family":0.11,"physical_touch":0.64,"introvert_extrovert":0.65,"loyalty":0.62}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 487', 36, 'male', 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(106.521036349368, 10.637627269781873), '["Công nghệ","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 488
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0453299348', 0.43, 0.57, 0.53, 0.41, 0.30, '{"ambition":0.43,"family":0.57,"physical_touch":0.53,"introvert_extrovert":0.41,"loyalty":0.3}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Ly 488', 35, 'other', 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.65832495199898, 10.658728532864625), '["Âm nhạc","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 489
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0637539847', 0.10, 0.93, 0.72, 0.52, 0.21, '{"ambition":0.1,"family":0.93,"physical_touch":0.72,"introvert_extrovert":0.52,"loyalty":0.21}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thảo 489', 33, 'other', 'Developer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(106.5640259375879, 10.95184778038216), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 490
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0102397646', 0.20, 0.64, 0.26, 0.40, 0.32, '{"ambition":0.2,"family":0.64,"physical_touch":0.26,"introvert_extrovert":0.4,"loyalty":0.32}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Lan 490', 24, 'female', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.71954155407371, 10.933251566767346), '["Ẩm thực","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 491
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0209178481', 0.11, 0.18, 0.18, 0.79, 0.36, '{"ambition":0.11,"family":0.18,"physical_touch":0.18,"introvert_extrovert":0.79,"loyalty":0.36}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Nam 491', 35, 'other', 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.87776984989833, 10.755070267184005), '["Ẩm thực","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 492
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0549056322', 0.80, 0.60, 0.08, 0.93, 0.51, '{"ambition":0.8,"family":0.6,"physical_touch":0.08,"introvert_extrovert":0.93,"loyalty":0.51}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Yến 492', 29, 'female', 'Sinh viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(106.55060710607745, 10.9735565736129), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 493
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0153172502', 0.44, 0.01, 0.95, 0.47, 0.70, '{"ambition":0.44,"family":0.01,"physical_touch":0.95,"introvert_extrovert":0.47,"loyalty":0.7}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Dũng 493', 18, 'male', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(106.54813687270837, 10.93853265036623), '["Sách","Tìm"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 494
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0240542094', 0.31, 0.80, 0.63, 0.03, 0.84, '{"ambition":0.31,"family":0.8,"physical_touch":0.63,"introvert_extrovert":0.03,"loyalty":0.84}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 494', 21, 'male', 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.4159277647977, 10.724515753939913), '["Thú cưng","Yêu"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 495
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0359366180', 0.26, 0.18, 0.40, 0.58, 0.63, '{"ambition":0.26,"family":0.18,"physical_touch":0.4,"introvert_extrovert":0.58,"loyalty":0.63}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Sơn 495', 29, 'male', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(106.76657022576184, 10.599426754314132), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 496
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0149763434', 0.07, 0.68, 0.88, 0.46, 0.37, '{"ambition":0.07,"family":0.68,"physical_touch":0.88,"introvert_extrovert":0.46,"loyalty":0.37}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Chi 496', 22, 'other', 'Bác sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(106.43522624007254, 10.57118195096718), '["Sách","Đam"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 497
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0591779774', 0.54, 0.64, 0.19, 0.15, 0.99, '{"ambition":0.54,"family":0.64,"physical_touch":0.19,"introvert_extrovert":0.15,"loyalty":0.99}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Bình 497', 23, 'male', 'Designer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.82965304780525, 10.657744360573034), '["Sách","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 498
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0556468474', 0.44, 0.35, 0.45, 0.02, 0.68, '{"ambition":0.44,"family":0.35,"physical_touch":0.45,"introvert_extrovert":0.02,"loyalty":0.68}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Thanh 498', 21, 'other', 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(106.909597631684, 10.665486853845186), '["Thú cưng","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 499
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0802449724', 0.46, 0.51, 0.96, 0.20, 0.22, '{"ambition":0.46,"family":0.51,"physical_touch":0.96,"introvert_extrovert":0.2,"loyalty":0.22}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Minh 499', 29, 'male', 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.59730089652967, 10.551931351531694), '["Thú cưng","Người"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 500
INSERT INTO users (phone, ambition_score, family_score, physical_touch_score, introvert_extrovert_score, loyalty_score, dna_vector) VALUES ('0510964465', 0.30, 0.62, 0.14, 0.95, 0.19, '{"ambition":0.3,"family":0.62,"physical_touch":0.14,"introvert_extrovert":0.95,"loyalty":0.19}');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location, ai_match_keywords) VALUES (@user_id, 'Huy 500', 25, 'other', 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(106.79682091097808, 10.807617504299776), '["Sách","Thích"]');
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

