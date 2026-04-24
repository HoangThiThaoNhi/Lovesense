USE lovesense;

-- Sample Users
INSERT INTO users (phone, email, password) VALUES 
('0912345678', 'user1@example.com', '$2b$10$wI5fUXS8yO3Z6O3j9mR8Oe3fP1i5.Vf9P1i5.Vf9P1i5.Vf9P1i5.'), -- password: password123
('0987654321', 'user2@example.com', '$2b$10$wI5fUXS8yO3Z6O3j9mR8Oe3fP1i5.Vf9P1i5.Vf9P1i5.Vf9P1i5.'),
('0900000001', 'user3@example.com', '$2b$10$wI5fUXS8yO3Z6O3j9mR8Oe3fP1i5.Vf9P1i5.Vf9P1i5.Vf9P1i5.'),
('0900000002', 'user4@example.com', '$2b$10$wI5fUXS8yO3Z6O3j9mR8Oe3fP1i5.Vf9P1i5.Vf9P1i5.Vf9P1i5.');

-- Sample Profiles
INSERT INTO profiles (user_id, display_name, age, gender, occupation, bio, interests, location) VALUES 
(1, 'Anh Tuấn', 25, 'male', 'Software Engineer', 'Love coding and trekking.', '["tech", "gaming", "music"]', ST_GeomFromText('POINT(21.0285 105.8542)', 4326)), -- Hanoi
(2, 'Minh Hằng', 23, 'female', 'Designer', 'Art is my life.', '["art", "travel", "coffee"]', ST_GeomFromText('POINT(21.0300 105.8500)', 4326)),
(3, 'Quốc Huy', 28, 'male', 'Chef', 'I cook well.', '["food", "wine", "movies"]', ST_GeomFromText('POINT(21.0350 105.8450)', 4326)),
(4, 'Thùy Chi', 22, 'female', 'Student', 'Looking for friends.', '["books", "music", "cats"]', ST_GeomFromText('POINT(21.0400 105.8400)', 4326));

-- Sample Photos
INSERT INTO photos (user_id, image_url, is_main, `order`) VALUES 
(1, 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800', TRUE, 0),
(2, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800', TRUE, 0),
(3, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800', TRUE, 0),
(4, 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=800', TRUE, 0);

-- Initial Swipes (User 1 likes User 2)
INSERT INTO swipes (swiper_id, swiped_id, type) VALUES (1, 2, 'like');
