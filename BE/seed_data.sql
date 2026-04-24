USE lovesense;

-- User 1
INSERT INTO users (phone) VALUES ('0823183253');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 1', 36, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.743183773186262, 106.59062943694789));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 2
INSERT INTO users (phone) VALUES ('0499590846');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 2', 22, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.669070337279974, 106.66889267809256));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 3
INSERT INTO users (phone) VALUES ('0370328236');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 3', 30, 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.76380707532051, 106.77465247805078));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 4
INSERT INTO users (phone) VALUES ('0209943066');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 4', 22, 'Developer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.763435349782727, 106.51965015611421));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 5
INSERT INTO users (phone) VALUES ('0397577688');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 5', 39, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.640156973086519, 106.72645457816901));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 6
INSERT INTO users (phone) VALUES ('0677351153');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 6', 18, 'Developer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.583530645205087, 106.76831420517003));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 7
INSERT INTO users (phone) VALUES ('0198350578');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 7', 21, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.995234689806615, 106.53828263856681));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 8
INSERT INTO users (phone) VALUES ('0116970206');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 8', 35, 'Sinh viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.676886185614077, 106.86202712793299));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 9
INSERT INTO users (phone) VALUES ('0390884262');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 9', 19, 'Giáo viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.646964458781335, 106.45116800968789));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 10
INSERT INTO users (phone) VALUES ('0445615282');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 10', 34, 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.743808641893551, 106.51999857315846));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 11
INSERT INTO users (phone) VALUES ('0730247796');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 11', 25, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.811823655493567, 106.57378698120499));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 12
INSERT INTO users (phone) VALUES ('0567217390');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 12', 39, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.699326527902139, 106.85556476037348));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 13
INSERT INTO users (phone) VALUES ('0520776824');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 13', 22, 'Kinh doanh', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.825232471900799, 106.5739710252696));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 14
INSERT INTO users (phone) VALUES ('0915094261');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 14', 29, 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.762428474393086, 106.77196644109303));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 15
INSERT INTO users (phone) VALUES ('0981339765');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 15', 20, 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(10.929714999930102, 106.43908531360854));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 16
INSERT INTO users (phone) VALUES ('0238237748');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 16', 30, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.659427822480335, 106.54890874198809));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 17
INSERT INTO users (phone) VALUES ('0481607592');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 17', 19, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.887738249991672, 106.83756832703065));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 18
INSERT INTO users (phone) VALUES ('0118058589');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 18', 38, 'Giáo viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.756555338305153, 106.84887322245393));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 19
INSERT INTO users (phone) VALUES ('0542885810');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 19', 38, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.831745267107495, 106.51019532755316));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 20
INSERT INTO users (phone) VALUES ('0361972014');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 20', 25, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(11.000623833560327, 106.90589070143479));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 21
INSERT INTO users (phone) VALUES ('0828020325');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 21', 25, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.650486825144492, 106.7942628055352));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 22
INSERT INTO users (phone) VALUES ('0109568616');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 22', 33, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.700000485140041, 106.51506424135731));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 23
INSERT INTO users (phone) VALUES ('0373709195');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 23', 22, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.892114657470596, 106.77538532425446));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 24
INSERT INTO users (phone) VALUES ('0449668191');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 24', 37, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.826221587200937, 106.51231892006246));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 25
INSERT INTO users (phone) VALUES ('0517645704');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 25', 22, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.649882061793576, 106.82074122047332));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 26
INSERT INTO users (phone) VALUES ('0356634927');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 26', 20, 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.693558047177731, 106.65609768294566));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 27
INSERT INTO users (phone) VALUES ('0196451859');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 27', 39, 'Developer', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(11.01189709405923, 106.8007537815201));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 28
INSERT INTO users (phone) VALUES ('0315103906');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 28', 32, 'Designer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.597939203960971, 106.7582060577924));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 29
INSERT INTO users (phone) VALUES ('0238537187');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 29', 33, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.944043081560581, 106.57377364921882));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 30
INSERT INTO users (phone) VALUES ('0514765277');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 30', 34, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.640864842656493, 106.56581736430365));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 31
INSERT INTO users (phone) VALUES ('0523099786');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 31', 34, 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.578564000958542, 106.42659737787156));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 32
INSERT INTO users (phone) VALUES ('0251984713');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 32', 25, 'Developer', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.53154373659698, 106.7608812300251));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 33
INSERT INTO users (phone) VALUES ('0451049986');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 33', 27, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.622572433413884, 106.56582550155426));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 34
INSERT INTO users (phone) VALUES ('0167023461');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 34', 21, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.571941461924533, 106.68427768139081));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 35
INSERT INTO users (phone) VALUES ('0980012974');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 35', 24, 'Giáo viên', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.943116464449535, 106.54404180706878));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 36
INSERT INTO users (phone) VALUES ('0679411918');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 36', 32, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.547847041050458, 106.87635494697132));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 37
INSERT INTO users (phone) VALUES ('0657007165');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 37', 28, 'Bác sĩ', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(10.715292702737857, 106.65645129226692));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 38
INSERT INTO users (phone) VALUES ('0200594293');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 38', 25, 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.636191354753908, 106.69511774101169));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 39
INSERT INTO users (phone) VALUES ('0684316164');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 39', 33, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.865092663170287, 106.71031847451445));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 40
INSERT INTO users (phone) VALUES ('0991007307');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 40', 25, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.862665008043479, 106.76460424635673));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 41
INSERT INTO users (phone) VALUES ('0181420135');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 41', 20, 'Sinh viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.557937431878038, 106.51592432942553));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 42
INSERT INTO users (phone) VALUES ('0462853199');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 42', 20, 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.570130192242615, 106.55244713303229));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 43
INSERT INTO users (phone) VALUES ('0727146175');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 43', 30, 'Designer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.659516200967712, 106.53981214825664));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 44
INSERT INTO users (phone) VALUES ('0510050657');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 44', 35, 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(10.770688913632464, 106.87939957226244));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 45
INSERT INTO users (phone) VALUES ('0342046040');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 45', 20, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.92110170980209, 106.8269016740387));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 46
INSERT INTO users (phone) VALUES ('0424700801');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 46', 30, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.846011797445694, 106.81345861472084));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 47
INSERT INTO users (phone) VALUES ('0386726111');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 47', 18, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.796293371011794, 106.59964372741018));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 48
INSERT INTO users (phone) VALUES ('0138402924');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 48', 35, 'Giáo viên', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.7316286772104, 106.45185526980784));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 49
INSERT INTO users (phone) VALUES ('0848333708');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 49', 24, 'Bác sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.70504018627517, 106.76042761459483));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 50
INSERT INTO users (phone) VALUES ('0167482254');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 50', 30, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.541564226093662, 106.74147021406915));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 51
INSERT INTO users (phone) VALUES ('0298210109');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 51', 23, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.952890909197116, 106.50564429540869));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 52
INSERT INTO users (phone) VALUES ('0878962725');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 52', 36, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.715385814304346, 106.87684924825399));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 53
INSERT INTO users (phone) VALUES ('0916440361');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 53', 32, 'Developer', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.646659072472092, 106.54840845801401));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 54
INSERT INTO users (phone) VALUES ('0371612190');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 54', 19, 'Designer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.67856162424413, 106.77511623554349));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 55
INSERT INTO users (phone) VALUES ('0207837094');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 55', 31, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.712906093989975, 106.76921914519046));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 56
INSERT INTO users (phone) VALUES ('0527902709');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 56', 35, 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.81418963493265, 106.67182470485638));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 57
INSERT INTO users (phone) VALUES ('0747951641');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 57', 26, 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.626407381764835, 106.80927335830339));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 58
INSERT INTO users (phone) VALUES ('0305457099');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 58', 34, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.674508606581105, 106.85006588739684));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 59
INSERT INTO users (phone) VALUES ('0940162553');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 59', 34, 'Developer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.951254095944723, 106.5379850441291));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 60
INSERT INTO users (phone) VALUES ('0120474878');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 60', 27, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.974557282736875, 106.52832548365758));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 61
INSERT INTO users (phone) VALUES ('0283714229');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 61', 23, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.727594421399184, 106.69389800462203));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 62
INSERT INTO users (phone) VALUES ('0489537510');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 62', 33, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.987547790741184, 106.68629912828659));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 63
INSERT INTO users (phone) VALUES ('0836259564');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 63', 32, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.891245594064015, 106.79160571155896));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 64
INSERT INTO users (phone) VALUES ('0190636743');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 64', 35, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.788543056989027, 106.78893286687673));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 65
INSERT INTO users (phone) VALUES ('0702516648');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 65', 31, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.933242452107603, 106.5014000351318));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 66
INSERT INTO users (phone) VALUES ('0185721879');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 66', 38, 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.56061037793694, 106.82424040096652));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 67
INSERT INTO users (phone) VALUES ('0497374994');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 67', 22, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.888767003576856, 106.5730347868613));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 68
INSERT INTO users (phone) VALUES ('0749006725');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 68', 35, 'Sinh viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.525343229480065, 106.87972382880588));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 69
INSERT INTO users (phone) VALUES ('0599764633');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 69', 28, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.70996887534712, 106.48186811609409));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 70
INSERT INTO users (phone) VALUES ('0273672861');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 70', 39, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.976184495344027, 106.42880070057353));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 71
INSERT INTO users (phone) VALUES ('0450101685');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 71', 31, 'Sinh viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.725641565433827, 106.78686249708326));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 72
INSERT INTO users (phone) VALUES ('0923189961');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 72', 21, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.576466566699475, 106.73730567132979));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 73
INSERT INTO users (phone) VALUES ('0557260371');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 73', 38, 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.839306091363813, 106.89299082409065));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 74
INSERT INTO users (phone) VALUES ('0273130943');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 74', 38, 'Developer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.820860910959427, 106.80366477000197));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 75
INSERT INTO users (phone) VALUES ('0691183350');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 75', 33, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.528853260529909, 106.54417890971447));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 76
INSERT INTO users (phone) VALUES ('0128722342');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 76', 27, 'Designer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.658082294276568, 106.63553088162749));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 77
INSERT INTO users (phone) VALUES ('0360999882');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 77', 30, 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.572494127858768, 106.59229399989142));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 78
INSERT INTO users (phone) VALUES ('0771800487');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 78', 39, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.678795627025515, 106.67901965536178));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 79
INSERT INTO users (phone) VALUES ('0930587244');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 79', 33, 'Kinh doanh', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.921351863491193, 106.7343899781244));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 80
INSERT INTO users (phone) VALUES ('0121888573');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 80', 35, 'Developer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.66996141573365, 106.78711133828202));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 81
INSERT INTO users (phone) VALUES ('0893973082');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 81', 19, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.794751307878084, 106.60360341093408));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 82
INSERT INTO users (phone) VALUES ('0182366615');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 82', 24, 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.832289042423703, 106.71492096852499));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 83
INSERT INTO users (phone) VALUES ('0816002949');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 83', 28, 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.969203898770962, 106.75155512915765));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 84
INSERT INTO users (phone) VALUES ('0103908857');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 84', 25, 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.543986902110786, 106.53278281645679));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 85
INSERT INTO users (phone) VALUES ('0585798423');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 85', 39, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.605575874828848, 106.446402426993));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 86
INSERT INTO users (phone) VALUES ('0876188690');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 86', 28, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.63080011654366, 106.77619333837139));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 87
INSERT INTO users (phone) VALUES ('0100246873');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 87', 20, 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.696574909544779, 106.86418523288589));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 88
INSERT INTO users (phone) VALUES ('0715015806');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 88', 24, 'Developer', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(10.904424015484844, 106.6269917244808));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 89
INSERT INTO users (phone) VALUES ('0100777177');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 89', 34, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.876328539304088, 106.7315867883804));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 90
INSERT INTO users (phone) VALUES ('0443002979');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 90', 29, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.679019933753391, 106.57813864681381));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 91
INSERT INTO users (phone) VALUES ('0124737630');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 91', 21, 'Designer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.988347492617585, 106.85907226721996));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 92
INSERT INTO users (phone) VALUES ('0577352788');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 92', 24, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.861519652137863, 106.75882242324695));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 93
INSERT INTO users (phone) VALUES ('0276992715');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 93', 30, 'Designer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.548980389865905, 106.41061555467832));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 94
INSERT INTO users (phone) VALUES ('0669820260');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 94', 37, 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.794755509290775, 106.41818561979093));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 95
INSERT INTO users (phone) VALUES ('0382464989');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 95', 22, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.537923211392364, 106.68520706952926));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 96
INSERT INTO users (phone) VALUES ('0874722275');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 96', 36, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.759836616192489, 106.46103083545735));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 97
INSERT INTO users (phone) VALUES ('0930039899');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 97', 25, 'Developer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(11.011183425848078, 106.41547464462933));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 98
INSERT INTO users (phone) VALUES ('0133557288');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 98', 22, 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.966686013788639, 106.59523434558571));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 99
INSERT INTO users (phone) VALUES ('0873916475');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 99', 39, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.984832456033553, 106.54661720062442));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 100
INSERT INTO users (phone) VALUES ('0609818662');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 100', 39, 'Designer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.942487356048716, 106.67319849710424));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 101
INSERT INTO users (phone) VALUES ('0786833643');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 101', 24, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.733398175285123, 106.55930754825029));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 102
INSERT INTO users (phone) VALUES ('0904971513');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 102', 38, 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.762768876764792, 106.7240576372557));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 103
INSERT INTO users (phone) VALUES ('0202091903');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 103', 35, 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.902016114865281, 106.73842930432635));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 104
INSERT INTO users (phone) VALUES ('0989822602');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 104', 30, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.583837656841258, 106.87657119300128));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 105
INSERT INTO users (phone) VALUES ('0602781237');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 105', 36, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.841395963770294, 106.85548927535868));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 106
INSERT INTO users (phone) VALUES ('0828624018');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 106', 29, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.773513942752583, 106.46306640715478));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 107
INSERT INTO users (phone) VALUES ('0904141271');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 107', 23, 'Sinh viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.51830368074364, 106.69070641874737));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 108
INSERT INTO users (phone) VALUES ('0370067202');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 108', 22, 'Designer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.821194764107988, 106.6311559549051));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 109
INSERT INTO users (phone) VALUES ('0780749520');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 109', 34, 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(10.901198847936797, 106.5518614047005));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 110
INSERT INTO users (phone) VALUES ('0332974198');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 110', 22, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(10.658392948025545, 106.46731103044654));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 111
INSERT INTO users (phone) VALUES ('0543106139');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 111', 18, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.83297820371843, 106.78118267055358));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 112
INSERT INTO users (phone) VALUES ('0210295029');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 112', 19, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(10.68380926323957, 106.60204634273722));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 113
INSERT INTO users (phone) VALUES ('0745791093');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 113', 22, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.871499510239953, 106.63558958919702));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 114
INSERT INTO users (phone) VALUES ('0911407478');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 114', 24, 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.606936279767071, 106.41052545531103));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 115
INSERT INTO users (phone) VALUES ('0609182266');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 115', 28, 'Designer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.525732069317908, 106.76046645951523));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 116
INSERT INTO users (phone) VALUES ('0712697760');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 116', 22, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.538364109110047, 106.43935368226971));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 117
INSERT INTO users (phone) VALUES ('0866173384');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 117', 19, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.635350100170783, 106.54246969899316));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 118
INSERT INTO users (phone) VALUES ('0747134192');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 118', 25, 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.856761601387925, 106.85179541484243));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 119
INSERT INTO users (phone) VALUES ('0687309421');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 119', 39, 'Sinh viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.574960506061213, 106.70485148321043));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 120
INSERT INTO users (phone) VALUES ('0609669494');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 120', 34, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.746546403962446, 106.58576076997457));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 121
INSERT INTO users (phone) VALUES ('0495790218');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 121', 27, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.91634457353383, 106.4192555186327));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 122
INSERT INTO users (phone) VALUES ('0990892614');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 122', 26, 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.806052144728143, 106.67989236889613));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 123
INSERT INTO users (phone) VALUES ('0217199452');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 123', 30, 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.771749336736027, 106.7091504711616));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 124
INSERT INTO users (phone) VALUES ('0291819138');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 124', 23, 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.796079232121382, 106.44375972060334));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 125
INSERT INTO users (phone) VALUES ('0977877389');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 125', 34, 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.674521652145625, 106.63985603184781));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 126
INSERT INTO users (phone) VALUES ('0867951119');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 126', 33, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.516852444755525, 106.62852531282307));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 127
INSERT INTO users (phone) VALUES ('0194311818');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 127', 38, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.867662807658885, 106.68978954783744));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 128
INSERT INTO users (phone) VALUES ('0660224263');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 128', 26, 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.974986697158746, 106.78104488951794));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 129
INSERT INTO users (phone) VALUES ('0355734617');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 129', 20, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.642920356505494, 106.90525458303621));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 130
INSERT INTO users (phone) VALUES ('0248884655');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 130', 28, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.879720207801338, 106.53508561309154));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 131
INSERT INTO users (phone) VALUES ('0483412398');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 131', 20, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.85730642183629, 106.49391838515065));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 132
INSERT INTO users (phone) VALUES ('0326828996');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 132', 31, 'Bác sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.66380658884994, 106.88228702376594));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 133
INSERT INTO users (phone) VALUES ('0323228098');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 133', 22, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.746153355375279, 106.70553837993161));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 134
INSERT INTO users (phone) VALUES ('0131227461');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 134', 26, 'Developer', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.868882563647333, 106.86803936880582));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 135
INSERT INTO users (phone) VALUES ('0760654702');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 135', 22, 'Developer', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(10.578141959950134, 106.45867634411242));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 136
INSERT INTO users (phone) VALUES ('0783789132');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 136', 25, 'Sinh viên', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.562863130509388, 106.51253100608777));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 137
INSERT INTO users (phone) VALUES ('0115520864');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 137', 28, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.971184164809683, 106.61277025943333));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 138
INSERT INTO users (phone) VALUES ('0802384073');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 138', 37, 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(10.905652835053951, 106.51278276444638));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 139
INSERT INTO users (phone) VALUES ('0487892011');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 139', 33, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.693226124872286, 106.87335567208083));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 140
INSERT INTO users (phone) VALUES ('0379522111');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 140', 22, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.627480280939302, 106.5203934303511));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 141
INSERT INTO users (phone) VALUES ('0577420753');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 141', 28, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.565310370763342, 106.86470061171933));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 142
INSERT INTO users (phone) VALUES ('0912623407');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 142', 37, 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.70302701807589, 106.7115174265092));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 143
INSERT INTO users (phone) VALUES ('0412107915');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 143', 29, 'Developer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.796154170529942, 106.86211734752642));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 144
INSERT INTO users (phone) VALUES ('0173709355');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 144', 37, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.798555076029869, 106.68505657295688));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 145
INSERT INTO users (phone) VALUES ('0984789699');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 145', 32, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.816477259151767, 106.84021326963287));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 146
INSERT INTO users (phone) VALUES ('0213401228');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 146', 37, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.832405545524734, 106.62565028205798));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 147
INSERT INTO users (phone) VALUES ('0436312529');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 147', 24, 'Kinh doanh', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.850668254423146, 106.80490664486113));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 148
INSERT INTO users (phone) VALUES ('0521789752');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 148', 33, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.681374402149858, 106.7784771709867));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 149
INSERT INTO users (phone) VALUES ('0199612839');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 149', 18, 'Designer', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.812395276012104, 106.60067735084495));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 150
INSERT INTO users (phone) VALUES ('0364193861');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 150', 18, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.82489147198397, 106.60360860822156));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 151
INSERT INTO users (phone) VALUES ('0336156497');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 151', 25, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.59953990354713, 106.55229432244604));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 152
INSERT INTO users (phone) VALUES ('0452955051');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 152', 36, 'Bác sĩ', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.701386308498192, 106.73209399999767));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 153
INSERT INTO users (phone) VALUES ('0985925631');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 153', 39, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.828152102767545, 106.88726335710415));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 154
INSERT INTO users (phone) VALUES ('0437532076');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 154', 34, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.78399879213994, 106.74173860254778));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 155
INSERT INTO users (phone) VALUES ('0401820891');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 155', 20, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.661151779615889, 106.51395737440419));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 156
INSERT INTO users (phone) VALUES ('0560794622');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 156', 29, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.81401255946244, 106.60749725537181));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 157
INSERT INTO users (phone) VALUES ('0265199431');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 157', 39, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.548428177129987, 106.66035795346829));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 158
INSERT INTO users (phone) VALUES ('0284395453');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 158', 36, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.635692057070997, 106.67687642983915));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 159
INSERT INTO users (phone) VALUES ('0672945675');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 159', 31, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.72719077186622, 106.4903569627419));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 160
INSERT INTO users (phone) VALUES ('0403107034');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 160', 19, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.657243288193655, 106.43904929495332));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 161
INSERT INTO users (phone) VALUES ('0647549017');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 161', 33, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.884847010404457, 106.8459455957209));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 162
INSERT INTO users (phone) VALUES ('0942608690');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 162', 31, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.67403718910283, 106.57617369623306));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 163
INSERT INTO users (phone) VALUES ('0866111979');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 163', 33, 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.986396459715856, 106.78767252090847));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 164
INSERT INTO users (phone) VALUES ('0778266888');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 164', 24, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.531163257743978, 106.61469560698947));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 165
INSERT INTO users (phone) VALUES ('0334556215');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 165', 35, 'Sinh viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.602569818056224, 106.58003391203778));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 166
INSERT INTO users (phone) VALUES ('0473020120');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 166', 27, 'Developer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.9398136800463, 106.70018488365277));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 167
INSERT INTO users (phone) VALUES ('0739691805');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 167', 22, 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.60588549741345, 106.79797015002023));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 168
INSERT INTO users (phone) VALUES ('0403881430');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 168', 25, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.664325938102396, 106.48385061132879));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 169
INSERT INTO users (phone) VALUES ('0729353922');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 169', 23, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.520469876884635, 106.84795117036766));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 170
INSERT INTO users (phone) VALUES ('0267381942');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 170', 38, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.591792473916492, 106.5799083097854));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 171
INSERT INTO users (phone) VALUES ('0794629423');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 171', 34, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.565192097926415, 106.83641819854158));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 172
INSERT INTO users (phone) VALUES ('0642510265');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 172', 35, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.560781947410783, 106.49954904426204));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 173
INSERT INTO users (phone) VALUES ('0636100066');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 173', 19, 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.800210790469972, 106.79818477716567));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 174
INSERT INTO users (phone) VALUES ('0571417571');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 174', 19, 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(10.820368275949445, 106.4734039254436));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 175
INSERT INTO users (phone) VALUES ('0959125944');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 175', 24, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.524712572330504, 106.80913733538027));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 176
INSERT INTO users (phone) VALUES ('0461067917');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 176', 24, 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.522765319467554, 106.70844044669153));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 177
INSERT INTO users (phone) VALUES ('0142810826');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 177', 22, 'Giáo viên', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.542351268991332, 106.53548572339062));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 178
INSERT INTO users (phone) VALUES ('0750846302');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 178', 37, 'Giáo viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.755449852876067, 106.46314770422882));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 179
INSERT INTO users (phone) VALUES ('0608918972');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 179', 24, 'Giáo viên', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(10.546129254323132, 106.79406168381682));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 180
INSERT INTO users (phone) VALUES ('0732802946');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 180', 38, 'Sinh viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.656087441632758, 106.8487074550192));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 181
INSERT INTO users (phone) VALUES ('0613458755');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 181', 38, 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.948740617605242, 106.752434322831));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 182
INSERT INTO users (phone) VALUES ('0800854198');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 182', 36, 'Developer', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.89461158842457, 106.69867841677996));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 183
INSERT INTO users (phone) VALUES ('0749698043');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 183', 38, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.555148156223474, 106.45055560079487));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 184
INSERT INTO users (phone) VALUES ('0645909230');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 184', 32, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.603585252942766, 106.56146892147714));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 185
INSERT INTO users (phone) VALUES ('0363256894');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 185', 26, 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.86354392667208, 106.55483605879748));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 186
INSERT INTO users (phone) VALUES ('0866878354');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 186', 22, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.830735520669208, 106.80669972016827));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 187
INSERT INTO users (phone) VALUES ('0611797177');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 187', 34, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.69186288695343, 106.65140138373555));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 188
INSERT INTO users (phone) VALUES ('0218963044');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 188', 28, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.520521439640685, 106.70139900950167));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 189
INSERT INTO users (phone) VALUES ('0316442771');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 189', 34, 'Designer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.950087511143431, 106.81980883081842));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 190
INSERT INTO users (phone) VALUES ('0117639653');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 190', 34, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.88296384826295, 106.53778773668506));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 191
INSERT INTO users (phone) VALUES ('0561763190');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 191', 20, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.695306126630836, 106.52459932114887));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 192
INSERT INTO users (phone) VALUES ('0784954556');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 192', 33, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.913536274796884, 106.88586505743216));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 193
INSERT INTO users (phone) VALUES ('0426609251');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 193', 38, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.557669694496742, 106.64722643642622));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 194
INSERT INTO users (phone) VALUES ('0215131226');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 194', 36, 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.844964627116727, 106.82860912860001));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 195
INSERT INTO users (phone) VALUES ('0326892513');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 195', 19, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.722568780353944, 106.59470951427726));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 196
INSERT INTO users (phone) VALUES ('0188787128');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 196', 28, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.840256393471625, 106.54705907489024));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 197
INSERT INTO users (phone) VALUES ('0128682439');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 197', 20, 'Kinh doanh', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.948668978543123, 106.58289795613464));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 198
INSERT INTO users (phone) VALUES ('0290992248');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 198', 20, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.790065544225092, 106.56107931561792));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 199
INSERT INTO users (phone) VALUES ('0762708594');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 199', 32, 'Developer', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.766904386510863, 106.71265087087717));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 200
INSERT INTO users (phone) VALUES ('0431153435');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 200', 20, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.65952659712866, 106.68316665189023));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 201
INSERT INTO users (phone) VALUES ('0767525481');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 201', 23, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.908973214472706, 106.56870440520508));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 202
INSERT INTO users (phone) VALUES ('0105815199');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 202', 30, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.79161271263714, 106.90240267889219));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 203
INSERT INTO users (phone) VALUES ('0852115340');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 203', 36, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.795898454037456, 106.5885265839532));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 204
INSERT INTO users (phone) VALUES ('0326485000');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 204', 30, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.86619527508786, 106.70071134381196));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 205
INSERT INTO users (phone) VALUES ('0516829796');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 205', 18, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.662245689540079, 106.46215552332548));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 206
INSERT INTO users (phone) VALUES ('0468034986');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 206', 35, 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.69573984891574, 106.48216469385522));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 207
INSERT INTO users (phone) VALUES ('0202375505');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 207', 39, 'Bác sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.527732978791763, 106.4424855589038));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 208
INSERT INTO users (phone) VALUES ('0161344331');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 208', 33, 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.78594670536569, 106.64480143988368));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 209
INSERT INTO users (phone) VALUES ('0927779787');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 209', 18, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.880041632304128, 106.79813208411791));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 210
INSERT INTO users (phone) VALUES ('0964295566');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 210', 21, 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.700652443966968, 106.42045812294893));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 211
INSERT INTO users (phone) VALUES ('0529470837');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 211', 18, 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.991447136739094, 106.83173585517225));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 212
INSERT INTO users (phone) VALUES ('0870539092');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 212', 26, 'Kinh doanh', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.819881695807604, 106.89732452399264));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 213
INSERT INTO users (phone) VALUES ('0905268607');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 213', 31, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.89979610408805, 106.43276641968293));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 214
INSERT INTO users (phone) VALUES ('0705015607');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 214', 23, 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.910348290335666, 106.64572430010494));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 215
INSERT INTO users (phone) VALUES ('0353829100');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 215', 31, 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.674646607651619, 106.4487247117923));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 216
INSERT INTO users (phone) VALUES ('0408688202');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 216', 26, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.655159390716268, 106.73301622698435));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 217
INSERT INTO users (phone) VALUES ('0888473291');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 217', 23, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.8497286579475, 106.50562590347513));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 218
INSERT INTO users (phone) VALUES ('0378506203');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 218', 27, 'Developer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.864032130435856, 106.81920233678827));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 219
INSERT INTO users (phone) VALUES ('0854608696');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 219', 21, 'Giáo viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.905667849432714, 106.82942169790469));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 220
INSERT INTO users (phone) VALUES ('0280618945');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 220', 37, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.580138322821, 106.79034793508758));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 221
INSERT INTO users (phone) VALUES ('0815729663');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 221', 32, 'Designer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.922289805357057, 106.77932215852958));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 222
INSERT INTO users (phone) VALUES ('0260976713');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 222', 24, 'Sinh viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.801439413230863, 106.42437754251762));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 223
INSERT INTO users (phone) VALUES ('0676760196');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 223', 31, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.61340597318611, 106.4907180743109));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 224
INSERT INTO users (phone) VALUES ('0973514166');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 224', 19, 'Designer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.919965504486608, 106.65084098580598));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 225
INSERT INTO users (phone) VALUES ('0696449067');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 225', 33, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.879909163307806, 106.7357864940784));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 226
INSERT INTO users (phone) VALUES ('0512160549');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 226', 35, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.835633498301831, 106.47925896895413));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 227
INSERT INTO users (phone) VALUES ('0615691926');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 227', 29, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.789599147951783, 106.43780400023243));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 228
INSERT INTO users (phone) VALUES ('0124967029');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 228', 27, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.726386996376512, 106.72422752250763));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 229
INSERT INTO users (phone) VALUES ('0617291147');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 229', 35, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.644597546565016, 106.87243294716859));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 230
INSERT INTO users (phone) VALUES ('0396270651');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 230', 22, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.937888442492222, 106.42279915006169));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 231
INSERT INTO users (phone) VALUES ('0960436175');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 231', 18, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.551069377669089, 106.44714591451682));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 232
INSERT INTO users (phone) VALUES ('0476945389');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 232', 32, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.76680141048363, 106.66939696380308));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 233
INSERT INTO users (phone) VALUES ('0503835378');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 233', 25, 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.877491039966792, 106.59265732803385));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 234
INSERT INTO users (phone) VALUES ('0101329830');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 234', 39, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.96165437879592, 106.72150007455272));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 235
INSERT INTO users (phone) VALUES ('0950258562');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 235', 32, 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.949498372857043, 106.6028875104636));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 236
INSERT INTO users (phone) VALUES ('0642740863');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 236', 26, 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.519875096777948, 106.56287289688683));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 237
INSERT INTO users (phone) VALUES ('0565278547');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 237', 22, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.533290250374717, 106.90835112754436));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 238
INSERT INTO users (phone) VALUES ('0387419415');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 238', 30, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.685373280620206, 106.74049980247781));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 239
INSERT INTO users (phone) VALUES ('0516668911');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 239', 32, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.673834831127259, 106.82280588046987));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 240
INSERT INTO users (phone) VALUES ('0948909035');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 240', 35, 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.774626377052803, 106.8332463895722));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 241
INSERT INTO users (phone) VALUES ('0646732487');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 241', 30, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.56938379136445, 106.4973769678317));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 242
INSERT INTO users (phone) VALUES ('0933140772');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 242', 27, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.737116530041261, 106.49076376430533));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 243
INSERT INTO users (phone) VALUES ('0300939781');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 243', 32, 'Giáo viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.673713767163257, 106.7571700702476));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 244
INSERT INTO users (phone) VALUES ('0127750745');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 244', 31, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(10.777627261319955, 106.66431976748517));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 245
INSERT INTO users (phone) VALUES ('0916583792');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 245', 34, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.826898200449008, 106.73484070080123));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 246
INSERT INTO users (phone) VALUES ('0624262861');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 246', 22, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.65056292933724, 106.76852977174235));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 247
INSERT INTO users (phone) VALUES ('0900117918');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 247', 34, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.696639127808451, 106.44320350977627));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 248
INSERT INTO users (phone) VALUES ('0671966357');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 248', 21, 'Sinh viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.7755422284528, 106.5394053249325));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 249
INSERT INTO users (phone) VALUES ('0836458719');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 249', 36, 'Bác sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.812707757460391, 106.41769615280333));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 250
INSERT INTO users (phone) VALUES ('0464442169');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 250', 34, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.8312425866007, 106.59257341820263));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 251
INSERT INTO users (phone) VALUES ('0222354178');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 251', 28, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.900058427918808, 106.57547039539304));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 252
INSERT INTO users (phone) VALUES ('0577136799');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 252', 18, 'Sinh viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.566848923845892, 106.43013858385548));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 253
INSERT INTO users (phone) VALUES ('0968379239');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 253', 28, 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(10.669761624936445, 106.49446193813208));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 254
INSERT INTO users (phone) VALUES ('0337283410');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 254', 35, 'Sinh viên', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.966928897596395, 106.80715302359732));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 255
INSERT INTO users (phone) VALUES ('0977788530');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 255', 24, 'Giáo viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.947973120754641, 106.77867688383283));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 256
INSERT INTO users (phone) VALUES ('0401089399');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 256', 21, 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.568555446432427, 106.82848661003614));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 257
INSERT INTO users (phone) VALUES ('0977087974');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 257', 19, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.555043671388766, 106.63676213829055));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 258
INSERT INTO users (phone) VALUES ('0778829783');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 258', 30, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.750674030707827, 106.68547565544955));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 259
INSERT INTO users (phone) VALUES ('0471015606');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 259', 38, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.75073475791342, 106.44180896402136));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 260
INSERT INTO users (phone) VALUES ('0445724635');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 260', 20, 'Sinh viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.710297842681552, 106.87907672804215));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 261
INSERT INTO users (phone) VALUES ('0807895712');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 261', 18, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.980255944303343, 106.75051777967545));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 262
INSERT INTO users (phone) VALUES ('0311632484');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 262', 31, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.815487295939443, 106.66689279209444));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 263
INSERT INTO users (phone) VALUES ('0232032162');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 263', 23, 'Sinh viên', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.871061499861106, 106.61888301933861));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 264
INSERT INTO users (phone) VALUES ('0561314807');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 264', 35, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.517391610135897, 106.86504072232452));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 265
INSERT INTO users (phone) VALUES ('0576943438');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 265', 36, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(10.62714955377161, 106.82727901763477));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 266
INSERT INTO users (phone) VALUES ('0205198132');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 266', 34, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.59918206524451, 106.80675135815761));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 267
INSERT INTO users (phone) VALUES ('0196960861');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 267', 24, 'Designer', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.883070546855995, 106.79640900601208));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 268
INSERT INTO users (phone) VALUES ('0150732446');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 268', 37, 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.737039142626637, 106.72869190320515));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 269
INSERT INTO users (phone) VALUES ('0209818567');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 269', 22, 'Kinh doanh', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.760376605277505, 106.71353535671508));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 270
INSERT INTO users (phone) VALUES ('0216971712');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 270', 37, 'Designer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.81091369719348, 106.70247262560576));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 271
INSERT INTO users (phone) VALUES ('0824792271');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 271', 18, 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.723146233101716, 106.76479792195461));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 272
INSERT INTO users (phone) VALUES ('0992372202');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 272', 30, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.661510749043124, 106.6182453112341));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 273
INSERT INTO users (phone) VALUES ('0572436664');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 273', 21, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.84798325960256, 106.8958338118555));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 274
INSERT INTO users (phone) VALUES ('0965693918');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 274', 19, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.778198307597046, 106.62420195379102));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 275
INSERT INTO users (phone) VALUES ('0523362950');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 275', 29, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.56507162837442, 106.67662472374862));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 276
INSERT INTO users (phone) VALUES ('0111552015');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 276', 25, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.684245304069643, 106.58205136689553));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 277
INSERT INTO users (phone) VALUES ('0434596242');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 277', 22, 'Sinh viên', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.639272394392338, 106.42197594827624));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 278
INSERT INTO users (phone) VALUES ('0995623413');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 278', 18, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.565482841691809, 106.42603985924433));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 279
INSERT INTO users (phone) VALUES ('0155155081');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 279', 26, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.76572240766652, 106.80505284620192));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 280
INSERT INTO users (phone) VALUES ('0984300622');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 280', 19, 'Designer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.577284558381152, 106.59611088771035));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 281
INSERT INTO users (phone) VALUES ('0970231086');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 281', 36, 'Developer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.540444870562593, 106.80288165256579));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 282
INSERT INTO users (phone) VALUES ('0565679631');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 282', 31, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.670921683010379, 106.54201427202428));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 283
INSERT INTO users (phone) VALUES ('0990877975');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 283', 34, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.843423247814124, 106.43611699663474));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 284
INSERT INTO users (phone) VALUES ('0657351864');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 284', 25, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.579863643710645, 106.65821704191318));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 285
INSERT INTO users (phone) VALUES ('0815081856');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 285', 19, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.76014213848132, 106.51473641521784));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 286
INSERT INTO users (phone) VALUES ('0412982664');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 286', 37, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.530279910375462, 106.64761578492372));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 287
INSERT INTO users (phone) VALUES ('0539068230');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 287', 22, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.952766798104673, 106.77388208752227));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 288
INSERT INTO users (phone) VALUES ('0866414500');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 288', 22, 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.910933402444394, 106.52337288467135));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 289
INSERT INTO users (phone) VALUES ('0426686023');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 289', 33, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.739602440378244, 106.53498348147215));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 290
INSERT INTO users (phone) VALUES ('0180038853');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 290', 22, 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.859430130860893, 106.45728923656758));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 291
INSERT INTO users (phone) VALUES ('0585319159');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 291', 28, 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.753443429024966, 106.73832182546701));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 292
INSERT INTO users (phone) VALUES ('0497670334');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 292', 29, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.878384010478443, 106.70561397791703));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 293
INSERT INTO users (phone) VALUES ('0890195455');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 293', 29, 'Designer', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.85625148216157, 106.46456160174864));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 294
INSERT INTO users (phone) VALUES ('0234118554');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 294', 26, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.722317577583675, 106.70531268735688));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 295
INSERT INTO users (phone) VALUES ('0965844289');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 295', 36, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.914564795878086, 106.47039615633284));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 296
INSERT INTO users (phone) VALUES ('0913069812');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 296', 39, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.542552596983816, 106.6083351657095));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 297
INSERT INTO users (phone) VALUES ('0589722930');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 297', 27, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.51919004298541, 106.84634620150192));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 298
INSERT INTO users (phone) VALUES ('0911658305');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 298', 37, 'Developer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.641985724010247, 106.67018275515817));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 299
INSERT INTO users (phone) VALUES ('0603941241');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 299', 28, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.781943487749292, 106.57812729378062));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 300
INSERT INTO users (phone) VALUES ('0859692764');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 300', 28, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.647574135232723, 106.51035617575253));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 301
INSERT INTO users (phone) VALUES ('0887158883');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 301', 22, 'Designer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.956539950326428, 106.57253118310656));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 302
INSERT INTO users (phone) VALUES ('0124038860');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 302', 26, 'Designer', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.540731180991838, 106.90467824445206));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 303
INSERT INTO users (phone) VALUES ('0826980927');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 303', 31, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.939894941636782, 106.78247631219293));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 304
INSERT INTO users (phone) VALUES ('0256647144');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 304', 20, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.609393676345993, 106.68052514040392));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 305
INSERT INTO users (phone) VALUES ('0363784202');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 305', 39, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.977367981544846, 106.41665764842027));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 306
INSERT INTO users (phone) VALUES ('0333686498');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 306', 32, 'Developer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.620770658224885, 106.62704643539226));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 307
INSERT INTO users (phone) VALUES ('0844431805');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 307', 22, 'Kinh doanh', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.841846551906364, 106.4779762690822));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 308
INSERT INTO users (phone) VALUES ('0482763008');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 308', 23, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.646060246900428, 106.5331192021798));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 309
INSERT INTO users (phone) VALUES ('0840975134');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 309', 37, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.570909327330417, 106.46593616112293));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 310
INSERT INTO users (phone) VALUES ('0624525653');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 310', 29, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.96037216901393, 106.67817284880937));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 311
INSERT INTO users (phone) VALUES ('0282225486');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 311', 26, 'Developer', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.611968601068932, 106.67041110229404));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 312
INSERT INTO users (phone) VALUES ('0948919300');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 312', 32, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.668710414415017, 106.79472162754104));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 313
INSERT INTO users (phone) VALUES ('0622334274');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 313', 24, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.852421795601668, 106.85134067738075));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 314
INSERT INTO users (phone) VALUES ('0940823107');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 314', 19, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.582762742471914, 106.79228982522068));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 315
INSERT INTO users (phone) VALUES ('0155493010');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 315', 29, 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.97602162719973, 106.73355232238895));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 316
INSERT INTO users (phone) VALUES ('0174168324');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 316', 35, 'Giáo viên', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.778940427619112, 106.50660013127631));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 317
INSERT INTO users (phone) VALUES ('0404670456');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 317', 30, 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.66300235931235, 106.81563589841423));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 318
INSERT INTO users (phone) VALUES ('0804150722');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 318', 34, 'Developer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.568675841070212, 106.66257035078405));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 319
INSERT INTO users (phone) VALUES ('0397545212');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 319', 38, 'Developer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.689337481474151, 106.7421825881817));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 320
INSERT INTO users (phone) VALUES ('0874961791');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 320', 31, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.921463148356917, 106.76551046087368));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 321
INSERT INTO users (phone) VALUES ('0550405792');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 321', 37, 'Developer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.613012712837092, 106.83621267163029));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 322
INSERT INTO users (phone) VALUES ('0865056499');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 322', 19, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.888738006769897, 106.44504640789557));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 323
INSERT INTO users (phone) VALUES ('0322406144');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 323', 21, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.56243937489553, 106.61298791485659));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 324
INSERT INTO users (phone) VALUES ('0855474042');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 324', 37, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.81820389872488, 106.48734929991257));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 325
INSERT INTO users (phone) VALUES ('0263009029');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 325', 37, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.960286777413607, 106.42409387768843));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 326
INSERT INTO users (phone) VALUES ('0136649430');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 326', 25, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.840724381675532, 106.83666665081114));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 327
INSERT INTO users (phone) VALUES ('0202485487');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 327', 33, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.806661848802031, 106.44788852120105));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 328
INSERT INTO users (phone) VALUES ('0496095350');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 328', 32, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.679643633010025, 106.87987578003904));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 329
INSERT INTO users (phone) VALUES ('0243018700');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 329', 27, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.612698221630012, 106.90010226308226));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 330
INSERT INTO users (phone) VALUES ('0946521625');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 330', 33, 'Developer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.997983725804406, 106.50361149023692));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 331
INSERT INTO users (phone) VALUES ('0638803448');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 331', 25, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.94158090843922, 106.85932327585685));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 332
INSERT INTO users (phone) VALUES ('0790634985');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 332', 35, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.65825879302197, 106.47994213459187));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 333
INSERT INTO users (phone) VALUES ('0622146405');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 333', 33, 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.636631047215, 106.76775682267035));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 334
INSERT INTO users (phone) VALUES ('0389280483');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 334', 31, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.904190742103337, 106.53612965125377));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 335
INSERT INTO users (phone) VALUES ('0987052630');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 335', 34, 'Designer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.541238152571948, 106.8274245127293));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 336
INSERT INTO users (phone) VALUES ('0418615065');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 336', 32, 'Bác sĩ', 'Đam mê code và cà phê.', '["Thú cưng","Thời trang"]', POINT(10.52357377182302, 106.71137289100086));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 337
INSERT INTO users (phone) VALUES ('0325952662');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 337', 31, 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.640726224632138, 106.70272365796478));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 338
INSERT INTO users (phone) VALUES ('0599442568');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 338', 24, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(10.994995112516358, 106.44717214226621));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 339
INSERT INTO users (phone) VALUES ('0347567340');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 339', 38, 'Developer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.904084308866079, 106.90092966825416));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 340
INSERT INTO users (phone) VALUES ('0195822765');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 340', 36, 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.806366101116385, 106.90316753440055));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 341
INSERT INTO users (phone) VALUES ('0586749068');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 341', 33, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.847611695716113, 106.76259874020799));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 342
INSERT INTO users (phone) VALUES ('0669708831');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 342', 37, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.993741863841608, 106.42180357549903));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 343
INSERT INTO users (phone) VALUES ('0328628065');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 343', 34, 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.925875783777949, 106.65490824325323));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 344
INSERT INTO users (phone) VALUES ('0568949698');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 344', 30, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.74296535955986, 106.68513518177815));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 345
INSERT INTO users (phone) VALUES ('0991028204');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 345', 33, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.803993289899042, 106.74832725401897));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 346
INSERT INTO users (phone) VALUES ('0697584209');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 346', 39, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.540666614921534, 106.4673737374098));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 347
INSERT INTO users (phone) VALUES ('0641989708');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 347', 27, 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.77851316376338, 106.6763344841674));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 348
INSERT INTO users (phone) VALUES ('0105333215');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 348', 23, 'Designer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.557472358694852, 106.71582811506016));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 349
INSERT INTO users (phone) VALUES ('0887176203');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 349', 22, 'Nghệ sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.657934574128824, 106.59617269518743));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 350
INSERT INTO users (phone) VALUES ('0689910164');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 350', 31, 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.704603536260313, 106.48555899114595));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 351
INSERT INTO users (phone) VALUES ('0970684186');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 351', 33, 'Giáo viên', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.618248092084825, 106.7301949443582));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 352
INSERT INTO users (phone) VALUES ('0775114243');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 352', 30, 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.955915379578935, 106.44309239978966));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 353
INSERT INTO users (phone) VALUES ('0512093446');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 353', 20, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.562392603111642, 106.61837658838375));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 354
INSERT INTO users (phone) VALUES ('0363311538');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 354', 21, 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.86790303777786, 106.85126159879913));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 355
INSERT INTO users (phone) VALUES ('0776388079');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 355', 23, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.613912226290001, 106.57486077197954));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 356
INSERT INTO users (phone) VALUES ('0108065436');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 356', 18, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.587517465028137, 106.73502716722102));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 357
INSERT INTO users (phone) VALUES ('0483475762');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 357', 22, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.972644580372, 106.62215286683433));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 358
INSERT INTO users (phone) VALUES ('0163226223');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 358', 28, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.777671477212095, 106.8330048239843));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 359
INSERT INTO users (phone) VALUES ('0280415633');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 359', 32, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.7928031218983, 106.8269575600455));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 360
INSERT INTO users (phone) VALUES ('0387529438');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 360', 19, 'Kinh doanh', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.941453622222586, 106.73284681012585));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 361
INSERT INTO users (phone) VALUES ('0414056441');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 361', 28, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.56117595282009, 106.60779419862622));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 362
INSERT INTO users (phone) VALUES ('0697884777');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 362', 39, 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.606841504526521, 106.69506575156275));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 363
INSERT INTO users (phone) VALUES ('0740066246');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 363', 21, 'Kinh doanh', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.610104952791577, 106.88444689044378));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 364
INSERT INTO users (phone) VALUES ('0568687214');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 364', 27, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.538319055640407, 106.70356863988735));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 365
INSERT INTO users (phone) VALUES ('0273490692');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 365', 33, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.664709920260321, 106.69111897589063));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 366
INSERT INTO users (phone) VALUES ('0872189036');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 366', 35, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.702019593143143, 106.85479470172471));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 367
INSERT INTO users (phone) VALUES ('0393882396');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 367', 21, 'Nghệ sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.821400581357203, 106.50355985071224));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 368
INSERT INTO users (phone) VALUES ('0664189652');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 368', 32, 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.871512327894193, 106.69979027960721));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 369
INSERT INTO users (phone) VALUES ('0555364627');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 369', 29, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.920932688068838, 106.54396093434492));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 370
INSERT INTO users (phone) VALUES ('0910832483');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 370', 31, 'Developer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.789231372012694, 106.57890082266633));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 371
INSERT INTO users (phone) VALUES ('0950206498');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 371', 20, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.895006962200851, 106.62470695323312));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 372
INSERT INTO users (phone) VALUES ('0748802555');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 372', 26, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.848599292059445, 106.83552916719358));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 373
INSERT INTO users (phone) VALUES ('0205773802');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 373', 26, 'Developer', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.565758722984826, 106.80660515476642));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 374
INSERT INTO users (phone) VALUES ('0303362053');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 374', 24, 'Sinh viên', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.698399616630592, 106.69696165300756));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 375
INSERT INTO users (phone) VALUES ('0100937055');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 375', 19, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.533661879055098, 106.75768787072359));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 376
INSERT INTO users (phone) VALUES ('0300923820');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 376', 19, 'Designer', 'Yêu thể thao và lối sống lành mạnh.', '["Âm nhạc","Du lịch"]', POINT(10.88047746775498, 106.78477402401037));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 377
INSERT INTO users (phone) VALUES ('0456148645');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 377', 30, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.628294739658866, 106.66987768734569));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 378
INSERT INTO users (phone) VALUES ('0697044153');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 378', 38, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.528172453003641, 106.54416062741798));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 379
INSERT INTO users (phone) VALUES ('0192665792');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 379', 30, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.587661311218813, 106.45543028977063));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 380
INSERT INTO users (phone) VALUES ('0503407567');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 380', 32, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.829446390395313, 106.58331940467677));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 381
INSERT INTO users (phone) VALUES ('0124775656');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 381', 30, 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.731391975026026, 106.58235595077062));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 382
INSERT INTO users (phone) VALUES ('0458002470');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 382', 23, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.922732612979628, 106.715907670316));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 383
INSERT INTO users (phone) VALUES ('0346143832');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 383', 18, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.826982366678987, 106.72392774378635));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 384
INSERT INTO users (phone) VALUES ('0148381646');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 384', 18, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.97209702460267, 106.69610768803965));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 385
INSERT INTO users (phone) VALUES ('0108522814');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 385', 30, 'Developer', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.955287226117724, 106.49749521628601));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 386
INSERT INTO users (phone) VALUES ('0336012869');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 386', 27, 'Bác sĩ', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.524564610032739, 106.54998805615503));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 387
INSERT INTO users (phone) VALUES ('0760380660');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 387', 33, 'Bác sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.801689811772349, 106.58097667888077));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 388
INSERT INTO users (phone) VALUES ('0319154503');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 388', 20, 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.513658386085488, 106.48217716931043));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 389
INSERT INTO users (phone) VALUES ('0588022413');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 389', 32, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.949893950924803, 106.42549118905976));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 390
INSERT INTO users (phone) VALUES ('0686404369');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 390', 26, 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.767740130477765, 106.62645159461668));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 391
INSERT INTO users (phone) VALUES ('0745831989');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 391', 34, 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.718721684119219, 106.79978336604918));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 392
INSERT INTO users (phone) VALUES ('0699217502');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 392', 36, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.881627115748227, 106.68829143410242));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 393
INSERT INTO users (phone) VALUES ('0374792965');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 393', 26, 'Nghệ sĩ', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.961807328831116, 106.64527744222477));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 394
INSERT INTO users (phone) VALUES ('0677227660');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 394', 32, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.516619970221218, 106.57687993058522));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 395
INSERT INTO users (phone) VALUES ('0948507001');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 395', 26, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.903225738086418, 106.8408281483384));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 396
INSERT INTO users (phone) VALUES ('0924636010');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 396', 35, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.78160956776605, 106.45628772794204));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 397
INSERT INTO users (phone) VALUES ('0211480485');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 397', 27, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.685048636085973, 106.75263029888676));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 398
INSERT INTO users (phone) VALUES ('0874203666');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 398', 27, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.864704871094842, 106.75847970262954));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 399
INSERT INTO users (phone) VALUES ('0905699446');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 399', 31, 'Giáo viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.934574725320806, 106.57485833034461));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 400
INSERT INTO users (phone) VALUES ('0824510619');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 400', 30, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.58929978752123, 106.60611648309799));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 401
INSERT INTO users (phone) VALUES ('0737715241');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 401', 22, 'Giáo viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.763199454276261, 106.58808829766761));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 402
INSERT INTO users (phone) VALUES ('0348082345');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 402', 18, 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.946244741849414, 106.5951482740692));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 403
INSERT INTO users (phone) VALUES ('0494765945');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 403', 29, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(10.601483926289674, 106.54959518537497));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 404
INSERT INTO users (phone) VALUES ('0182200026');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 404', 32, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.902600025179733, 106.61100502804804));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 405
INSERT INTO users (phone) VALUES ('0917829025');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 405', 30, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(11.00512236649005, 106.45846633925113));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 406
INSERT INTO users (phone) VALUES ('0594312337');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 406', 27, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.822396422164081, 106.79858853598806));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 407
INSERT INTO users (phone) VALUES ('0904560454');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 407', 36, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.83964507872377, 106.50313478551097));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 408
INSERT INTO users (phone) VALUES ('0415214266');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 408', 30, 'Nghệ sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.738316394542453, 106.63705517860808));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 409
INSERT INTO users (phone) VALUES ('0101113617');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 409', 23, 'Designer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.686487984292143, 106.74306320479347));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 410
INSERT INTO users (phone) VALUES ('0666398946');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 410', 18, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.683980902351562, 106.89593236362462));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 411
INSERT INTO users (phone) VALUES ('0735768874');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 411', 34, 'Sinh viên', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.883576561821396, 106.69585188133057));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 412
INSERT INTO users (phone) VALUES ('0183979413');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 412', 33, 'Nghệ sĩ', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.882123733307607, 106.88112012549905));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 413
INSERT INTO users (phone) VALUES ('0760344574');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 413', 22, 'Designer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.555817492701838, 106.66970090608916));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 414
INSERT INTO users (phone) VALUES ('0316537276');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 414', 34, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.516175930853702, 106.41327979187322));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 415
INSERT INTO users (phone) VALUES ('0137980733');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 415', 32, 'Developer', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.898656565452947, 106.86955355506721));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 416
INSERT INTO users (phone) VALUES ('0975598281');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 416', 18, 'Giáo viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.91286668853719, 106.53756496814417));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 417
INSERT INTO users (phone) VALUES ('0868005871');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 417', 38, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.691346729419493, 106.66171172887309));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 418
INSERT INTO users (phone) VALUES ('0395852051');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 418', 27, 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.950017674249239, 106.76725369473719));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 419
INSERT INTO users (phone) VALUES ('0788685002');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 419', 33, 'Developer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.75103281805414, 106.44879211355807));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 420
INSERT INTO users (phone) VALUES ('0220169348');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 420', 21, 'Sinh viên', 'Thích du lịch và khám phá.', '["Thú cưng","Thời trang"]', POINT(10.911026987937898, 106.86937124012698));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 421
INSERT INTO users (phone) VALUES ('0532839059');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 421', 27, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.532291022951028, 106.60031090506261));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 422
INSERT INTO users (phone) VALUES ('0933185596');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 422', 21, 'Bác sĩ', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.67538631575824, 106.75785867276312));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 423
INSERT INTO users (phone) VALUES ('0434700940');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 423', 21, 'Developer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.91547966426959, 106.73068417055374));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 424
INSERT INTO users (phone) VALUES ('0916210811');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 424', 18, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.982263013687499, 106.78597147104605));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 425
INSERT INTO users (phone) VALUES ('0314624575');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 425', 37, 'Kinh doanh', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.646812709922894, 106.80778528526005));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 426
INSERT INTO users (phone) VALUES ('0440265010');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 426', 31, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.881548860061091, 106.51416587597444));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 427
INSERT INTO users (phone) VALUES ('0306233768');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 427', 39, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.933316214232574, 106.674709193587));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 428
INSERT INTO users (phone) VALUES ('0519285697');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 428', 19, 'Developer', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.7688765894913, 106.49031914360197));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 429
INSERT INTO users (phone) VALUES ('0290656038');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 429', 35, 'Giáo viên', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.865037776293388, 106.45488626970713));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 430
INSERT INTO users (phone) VALUES ('0946012764');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 430', 26, 'Developer', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.865793695428598, 106.85368665206724));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 431
INSERT INTO users (phone) VALUES ('0580010435');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 431', 29, 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.951114871314706, 106.5962789342649));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 432
INSERT INTO users (phone) VALUES ('0583262162');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 432', 32, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Âm nhạc","Du lịch"]', POINT(10.914648395782576, 106.57371788836164));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 433
INSERT INTO users (phone) VALUES ('0504268119');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 433', 29, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.91479118500895, 106.73104057145612));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 434
INSERT INTO users (phone) VALUES ('0514682540');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 434', 23, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.865010376550332, 106.68069741137587));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 435
INSERT INTO users (phone) VALUES ('0306245395');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 435', 30, 'Developer', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.64184694949008, 106.58733923634134));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 436
INSERT INTO users (phone) VALUES ('0436856535');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 436', 20, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.739386963549096, 106.8164436869744));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 437
INSERT INTO users (phone) VALUES ('0163025728');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 437', 34, 'Sinh viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.953035654831611, 106.4687681520043));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 438
INSERT INTO users (phone) VALUES ('0272852396');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 438', 21, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.831176284992319, 106.45320339593813));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 439
INSERT INTO users (phone) VALUES ('0643639047');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 439', 26, 'Nghệ sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.73196165804988, 106.82677782997284));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 440
INSERT INTO users (phone) VALUES ('0571599647');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 440', 38, 'Kinh doanh', 'Yêu thể thao và lối sống lành mạnh.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.981509513398096, 106.70689757937289));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 441
INSERT INTO users (phone) VALUES ('0881400043');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 441', 29, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.80906696658954, 106.88499803804459));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 442
INSERT INTO users (phone) VALUES ('0829056940');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 442', 32, 'Giáo viên', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.970886106190358, 106.84158712462826));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 443
INSERT INTO users (phone) VALUES ('0830262181');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 443', 26, 'Designer', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.926178883670401, 106.4530793080562));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 444
INSERT INTO users (phone) VALUES ('0615443281');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 444', 25, 'Sinh viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.697925327905258, 106.59548582072067));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 445
INSERT INTO users (phone) VALUES ('0914971270');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 445', 23, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.771398209833906, 106.51552025753719));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 446
INSERT INTO users (phone) VALUES ('0212851852');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 446', 22, 'Developer', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(10.872948529533039, 106.65319165648616));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 447
INSERT INTO users (phone) VALUES ('0503311284');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 447', 32, 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.909299712088384, 106.8331705392708));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 448
INSERT INTO users (phone) VALUES ('0822842630');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 448', 26, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.810822171033147, 106.8653357378359));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 449
INSERT INTO users (phone) VALUES ('0430987786');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 449', 29, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Thú cưng","Thời trang"]', POINT(10.599358016298453, 106.41806395261023));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 450
INSERT INTO users (phone) VALUES ('0288194846');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Dũng 450', 27, 'Sinh viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.673369508207928, 106.89177556301404));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 451
INSERT INTO users (phone) VALUES ('0530884543');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 451', 27, 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.702566072090688, 106.86085456918943));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 452
INSERT INTO users (phone) VALUES ('0311002650');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 452', 19, 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.531675134002976, 106.81759869390737));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 453
INSERT INTO users (phone) VALUES ('0738599180');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 453', 22, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Thú cưng","Thời trang"]', POINT(10.809256729985426, 106.71744514277438));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 454
INSERT INTO users (phone) VALUES ('0868863359');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 454', 33, 'Developer', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.889154590438451, 106.55903746072025));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 455
INSERT INTO users (phone) VALUES ('0135445567');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 455', 34, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.953178569122922, 106.90312208588215));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 456
INSERT INTO users (phone) VALUES ('0667149460');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 456', 21, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.95012491498074, 106.67211180696658));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 457
INSERT INTO users (phone) VALUES ('0995977733');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 457', 32, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Âm nhạc","Du lịch"]', POINT(10.57655085382528, 106.47076329520289));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 458
INSERT INTO users (phone) VALUES ('0529332411');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 458', 23, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Công nghệ","Thể hình"]', POINT(10.800602838540069, 106.48991406583743));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 459
INSERT INTO users (phone) VALUES ('0198663652');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 459', 28, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.862426176317502, 106.66368131169415));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 460
INSERT INTO users (phone) VALUES ('0408073655');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 460', 23, 'Sinh viên', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.634930510929772, 106.44385030764134));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 461
INSERT INTO users (phone) VALUES ('0481129484');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ngọc 461', 31, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.669844200431804, 106.54814490124515));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 462
INSERT INTO users (phone) VALUES ('0778724545');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 462', 22, 'Bác sĩ', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.991301268467051, 106.54193450288817));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 463
INSERT INTO users (phone) VALUES ('0457459368');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 463', 21, 'Bác sĩ', 'Yêu thể thao và lối sống lành mạnh.', '["Thú cưng","Thời trang"]', POINT(10.859425100756786, 106.7725512499349));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 464
INSERT INTO users (phone) VALUES ('0365942553');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 464', 20, 'Bác sĩ', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.616407733974398, 106.73255330304015));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 465
INSERT INTO users (phone) VALUES ('0220191962');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 465', 22, 'Giáo viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.968395597157144, 106.80138180214719));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 466
INSERT INTO users (phone) VALUES ('0133809822');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 466', 23, 'Giáo viên', 'Thích du lịch và khám phá.', '["Âm nhạc","Du lịch"]', POINT(10.666991007897606, 106.67636108447279));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 467
INSERT INTO users (phone) VALUES ('0190816011');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 467', 21, 'Sinh viên', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.923794529136277, 106.53378161643622));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 468
INSERT INTO users (phone) VALUES ('0936368200');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 468', 39, 'Bác sĩ', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.75912844480764, 106.62214009256984));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500', 1, 0);

-- User 469
INSERT INTO users (phone) VALUES ('0267605068');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 469', 22, 'Giáo viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.78097340626325, 106.53094205011409));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 470
INSERT INTO users (phone) VALUES ('0755740199');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Vân 470', 34, 'Nghệ sĩ', 'Thích xem phim và nghe nhạc.', '["Âm nhạc","Du lịch"]', POINT(10.842664740983142, 106.76613207654815));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 471
INSERT INTO users (phone) VALUES ('0262920548');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 471', 30, 'Bác sĩ', 'Thích xem phim và nghe nhạc.', '["Thú cưng","Thời trang"]', POINT(10.57635451012596, 106.83136470722016));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 472
INSERT INTO users (phone) VALUES ('0146739972');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Minh 472', 19, 'Developer', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.7625611127533, 106.65210154353467));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 473
INSERT INTO users (phone) VALUES ('0610486865');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thanh 473', 32, 'Giáo viên', 'Thích du lịch và khám phá.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.804800769171118, 106.86510583622008));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 474
INSERT INTO users (phone) VALUES ('0450401100');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 474', 19, 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.717164935245483, 106.88683579568378));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 475
INSERT INTO users (phone) VALUES ('0109215669');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 475', 36, 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.920459207367035, 106.66326024408517));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 476
INSERT INTO users (phone) VALUES ('0220229105');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 476', 36, 'Giáo viên', 'Đam mê code và cà phê.', '["Công nghệ","Thể hình"]', POINT(10.953525966459495, 106.7383887775026));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 477
INSERT INTO users (phone) VALUES ('0800702095');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 477', 29, 'Kinh doanh', 'Người hướng nội nhưng thích nói chuyện.', '["Thú cưng","Thời trang"]', POINT(10.673729012318015, 106.80517485880108));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 478
INSERT INTO users (phone) VALUES ('0193433011');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Huy 478', 33, 'Designer', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.72807611404676, 106.67944055343735));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 479
INSERT INTO users (phone) VALUES ('0622746927');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 479', 28, 'Sinh viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.751396554198681, 106.80631673987412));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 480
INSERT INTO users (phone) VALUES ('0742510880');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 480', 36, 'Sinh viên', 'Thích xem phim và nghe nhạc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.597688301343366, 106.60004632129049));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 481
INSERT INTO users (phone) VALUES ('0996651918');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Linh 481', 30, 'Nghệ sĩ', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.933121266596983, 106.56316887280275));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 482
INSERT INTO users (phone) VALUES ('0285931118');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 482', 33, 'Kinh doanh', 'Thích du lịch và khám phá.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.894786047878092, 106.77874583219665));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 483
INSERT INTO users (phone) VALUES ('0893287320');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Chi 483', 18, 'Giáo viên', 'Thích du lịch và khám phá.', '["Công nghệ","Thể hình"]', POINT(10.53505551771364, 106.41451297871508));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 484
INSERT INTO users (phone) VALUES ('0751469392');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 484', 26, 'Sinh viên', 'Đam mê code và cà phê.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.716100632179907, 106.56587444171548));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 485
INSERT INTO users (phone) VALUES ('0330035697');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Nam 485', 29, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Công nghệ","Thể hình"]', POINT(10.620121489931638, 106.78962700326572));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 486
INSERT INTO users (phone) VALUES ('0583256787');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 486', 35, 'Designer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.614900016426134, 106.90048580774905));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 487
INSERT INTO users (phone) VALUES ('0706907903');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Bình 487', 37, 'Kinh doanh', 'Thích xem phim và nghe nhạc.', '["Công nghệ","Thể hình"]', POINT(10.633448548145005, 106.6317233446802));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 488
INSERT INTO users (phone) VALUES ('0718452814');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Hương 488', 26, 'Designer', 'Yêu mèo, ghét sự giả dối.', '["Thú cưng","Thời trang"]', POINT(10.947805824797014, 106.73175143434317));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 489
INSERT INTO users (phone) VALUES ('0339282706');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Phúc 489', 39, 'Giáo viên', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.793730756784374, 106.83470464863892));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 490
INSERT INTO users (phone) VALUES ('0700841221');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Tuấn 490', 26, 'Kinh doanh', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Công nghệ","Thể hình"]', POINT(10.971789466442097, 106.69424576899141));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 491
INSERT INTO users (phone) VALUES ('0863717754');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 491', 35, 'Designer', 'Thích xem phim và nghe nhạc.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.629847179734144, 106.5706382308278));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500', 1, 0);

-- User 492
INSERT INTO users (phone) VALUES ('0561987817');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Quân 492', 37, 'Sinh viên', 'Yêu thể thao và lối sống lành mạnh.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.893363082648602, 106.44294263974115));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 493
INSERT INTO users (phone) VALUES ('0908945322');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Lan 493', 23, 'Bác sĩ', 'Người hướng nội nhưng thích nói chuyện.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(10.800556903014895, 106.66612085894158));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 494
INSERT INTO users (phone) VALUES ('0323573102');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 494', 25, 'Designer', 'Tìm kiếm một mối quan hệ nghiêm túc.', '["Âm nhạc","Du lịch"]', POINT(10.556500680026724, 106.88711691677658));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=500', 1, 0);

-- User 495
INSERT INTO users (phone) VALUES ('0879191029');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Thảo 495', 26, 'Kinh doanh', 'Đam mê code và cà phê.', '["Âm nhạc","Du lịch"]', POINT(10.574288048800103, 106.45793118421554));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 496
INSERT INTO users (phone) VALUES ('0612944383');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Anh 496', 38, 'Giáo viên', 'Yêu mèo, ghét sự giả dối.', '["Ẩm thực","Phim ảnh","Nghệ thuật"]', POINT(11.002570500734087, 106.63692927746136));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500', 1, 0);

-- User 497
INSERT INTO users (phone) VALUES ('0157750147');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 497', 37, 'Designer', 'Tìm người đồng hành cùng đi phượt.', '["Công nghệ","Thể hình"]', POINT(10.624321901915499, 106.74203057044555));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 498
INSERT INTO users (phone) VALUES ('0933463568');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Yến 498', 23, 'Kinh doanh', 'Yêu mèo, ghét sự giả dối.', '["Âm nhạc","Du lịch"]', POINT(10.899454445634948, 106.75914588105168));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500', 1, 0);

-- User 499
INSERT INTO users (phone) VALUES ('0713254885');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Sơn 499', 23, 'Sinh viên', 'Yêu mèo, ghét sự giả dối.', '["Công nghệ","Thể hình"]', POINT(10.867656683659082, 106.4524082574562));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

-- User 500
INSERT INTO users (phone) VALUES ('0156204244');
SET @user_id = LAST_INSERT_ID();
INSERT INTO profiles (user_id, display_name, age, occupation, bio, interests, location) VALUES (@user_id, 'Ly 500', 30, 'Giáo viên', 'Đam mê code và cà phê.', '["Sách","Chơi game","Thiên nhiên"]', POINT(10.624383301498609, 106.67528645606936));
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES (@user_id, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500', 1, 0);

