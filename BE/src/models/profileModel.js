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
        allowNull: true
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
    city: {
        type: DataTypes.STRING(100),
        allowNull: true
    },
    district: {
        type: DataTypes.STRING(100),
        allowNull: true
    },
    address: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    ai_preferences: {
        type: DataTypes.JSON,
        allowNull: true,
        defaultValue: {}
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
    const User = sequelize.models.User;
    const profile = await Profile.findOne({ 
        where: { user_id: userId },
        include: [{
            model: User,
            as: 'user',
            attributes: [
                'email', 'phone', 'full_name', 'bio', 'gender',
                'ambition_score', 'personality_score', 'career_score', 
                'core_values_score', 'interests_score', 'lifestyle_score', 
                'family_orientation_score'
            ]
        }]
    });
    
    if (!profile) return null;

    // Merge user scores into profile data
    const data = profile.toJSON();
    if (data.user) {
        Object.assign(data, {
            ambition_score: data.user.ambition_score,
            personality_score: data.user.personality_score,
            career_score: data.user.career_score,
            core_values_score: data.user.core_values_score,
            interests_score: data.user.interests_score,
            lifestyle_score: data.user.lifestyle_score,
            family_orientation_score: data.user.family_orientation_score
        });
        delete data.user;
    }

    if (data.location && data.location.coordinates) {
        data.lng = data.location.coordinates[0];
        data.lat = data.location.coordinates[1];
    }
    return data;
};

// Viết lại upsert bằng Sequelize
Profile.upsert = async function (profileData) {
    const { user_id, location, lat, lng, ...rest } = profileData;
    
    // Construct location object from lat/lng if not already provided as a geometry object
    let finalLocation = location;
    if (!finalLocation && lat && lng) {
        finalLocation = { type: 'Point', coordinates: [parseFloat(lng), parseFloat(lat)] };
    }

    const [profile, created] = await Profile.findOrCreate({
        where: { user_id },
        defaults: { 
            ...rest, 
            user_id, 
            location: finalLocation || null, 
            living_at: rest.living_at || [rest.address, rest.district, rest.city].filter(Boolean).join(', '),
            points: 0, 
            current_title: 'Newbie' 
        }
    });

    if (!created) {
        // Prevent users from updating their own points or title through profile updates
        const { points, current_title, ...safeUpdateData } = rest;
        const living_at = safeUpdateData.living_at || [safeUpdateData.address, safeUpdateData.district, safeUpdateData.city].filter(Boolean).join(', ');
        await profile.update({ ...safeUpdateData, living_at, location: finalLocation });
    }

    return profile.id;
};

module.exports = Profile;
