const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Profile = sequelize.define('Profile', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'users',
            key: 'id'
        }
    },
    display_name: {
        type: DataTypes.STRING(100),
        allowNull: false
    },
    age: {
        type: DataTypes.INTEGER
    },
    gender: {
        type: DataTypes.ENUM('male', 'female', 'other')
    },
    occupation: {
        type: DataTypes.STRING(255)
    },
    bio: {
        type: DataTypes.TEXT
    },
    interests: {
        type: DataTypes.TEXT, // LONGTEXT in SQL
        get() {
            const val = this.getDataValue('interests');
            if (val && typeof val === 'string') {
                try {
                    return JSON.parse(val);
                } catch (e) {
                    return [];
                }
            }
            return val || [];
        },
        set(val) {
            this.setDataValue('interests', typeof val === 'string' ? val : JSON.stringify(val));
        }
    },
    location: {
        type: DataTypes.GEOMETRY('POINT'),
        allowNull: false
    },
    points: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    },
    current_title: {
        type: DataTypes.STRING(100),
        defaultValue: 'Newbie'
    },
    height: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    purpose: {
        type: DataTypes.STRING(100),
        allowNull: true
    },
    living_at: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    looking_for: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    ai_ideal_description: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    ai_match_keywords: {
        type: DataTypes.TEXT,
        allowNull: true,
        get() {
            const val = this.getDataValue('ai_match_keywords');
            if (val && typeof val === 'string') {
                try { return JSON.parse(val); } catch (e) { return []; }
            }
            return val || [];
        },
        set(val) {
            this.setDataValue('ai_match_keywords', typeof val === 'string' ? val : JSON.stringify(val));
        }
    },
    dna_vector: {
        type: DataTypes.JSON, // Stores { "extroversion": 0.8, "career_ambition": -0.2, ... }
        allowNull: true,
        defaultValue: {}
    },
    updated_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    tableName: 'profiles'
});

// Helper methods
Profile.findByUserId = async function (userId) {
    const profile = await Profile.findOne({ where: { user_id: userId } });
    if (!profile) return null;

    // Chuyển sang plain object để truy cập trực tiếp
    const data = profile.toJSON();
    if (data.location && data.location.coordinates) {
        data.lng = data.location.coordinates[0];
        data.lat = data.location.coordinates[1];
    }
    return data;
};

// Viết lại upsert bằng Sequelize
Profile.upsert = async function (profileData) {
    const { user_id, lat, lng, ...rest } = profileData;

    // Chuyển lat/lng về định dạng Sequelize POINT
    const location = { type: 'Point', coordinates: [lng, lat] };

    const [profile, created] = await Profile.findOrCreate({
        where: { user_id },
        defaults: { ...rest, user_id, location }
    });

    if (!created) {
        await profile.update({ ...rest, location });
    }

    return profile.id;
};

module.exports = Profile;
