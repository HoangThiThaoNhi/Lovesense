USE lovesense;

-- 1. Add columns to profiles table
-- Note: If these columns already exist, this part might throw an error.
-- The updateDb.js script is updated to handle this case.
ALTER TABLE profiles ADD COLUMN points INT DEFAULT 0;
ALTER TABLE profiles ADD COLUMN current_title VARCHAR(100) DEFAULT 'Newbie';

-- 2. Create point_history table
CREATE TABLE IF NOT EXISTS point_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    points INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Create badges table
CREATE TABLE IF NOT EXISTS badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    points_required INT NOT NULL,
    icon_url VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Create user_badges table
CREATE TABLE IF NOT EXISTS user_badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    badge_id INT NOT NULL,
    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (badge_id) REFERENCES badges(id) ON DELETE CASCADE,
    UNIQUE KEY (user_id, badge_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Insert default badges
INSERT IGNORE INTO badges (name, description, points_required) VALUES 
('Bronze Heart', 'Bắt đầu hành trình', 100),
('Silver Heart', 'Thành viên tích cực', 500),
('Gold Heart', 'Người tình lý tưởng', 1000),
('Platinum Heart', 'Hội viên tinh tú', 5000);
