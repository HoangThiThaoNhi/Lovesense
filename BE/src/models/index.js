const sequelize = require('../config/db');
const User = require('./userModel');
const Profile = require('./profileModel');
const Photo = require('./photoModel');
const Swipe = require('./swipeModel');
const Match = require('./matchModel');
const Message = require('./messageModel');
const Survey = require('./surveyModel');
const PointHistory = require('./pointHistoryModel');
const Badge = require('./badgeModel');
const UserBadge = require('./userBadgeModel');
const AdminLog = require('./adminLogModel');
const Question = require('./questionModel');
const Challenge = require('./challengeModel');
const UserChallenge = require('./userChallengeModel');
const Notification = require('./notificationModel');
const AIChat = require('./aiChatModel');
const AISession = require('./aiSessionModel');
const Voucher = require('./voucherModel');
const UserVoucher = require('./userVoucherModel');
const QuizQuestion = require('./quizQuestionModel');
const QuizOption = require('./quizOptionModel');

// Associations
User.hasOne(Profile, { foreignKey: 'user_id', as: 'profile' });
Profile.belongsTo(User, { foreignKey: 'user_id', as: 'user' });

User.hasMany(AdminLog, { foreignKey: 'admin_id', as: 'adminLogs' });
AdminLog.belongsTo(User, { foreignKey: 'admin_id', as: 'admin' });

Question.hasMany(Survey, { foreignKey: 'question_id', as: 'surveys' });
Survey.belongsTo(Question, { foreignKey: 'question_id' });

User.hasMany(Survey, { foreignKey: 'user_id', as: 'surveys' });
Survey.belongsTo(User, { foreignKey: 'user_id' });

User.hasMany(Photo, { foreignKey: 'user_id', as: 'photos' });
Photo.belongsTo(User, { foreignKey: 'user_id' });

User.hasMany(Swipe, { foreignKey: 'swiper_id', as: 'swipesSent' });
User.hasMany(Swipe, { foreignKey: 'swiped_id', as: 'swipesReceived' });
Swipe.belongsTo(User, { foreignKey: 'swiper_id', as: 'swiper' });
Swipe.belongsTo(User, { foreignKey: 'swiped_id', as: 'swiped' });

User.hasMany(Match, { foreignKey: 'user1_id', as: 'matchesAsUser1' });
User.hasMany(Match, { foreignKey: 'user2_id', as: 'matchesAsUser2' });
Match.belongsTo(User, { foreignKey: 'user1_id', as: 'user1' });
Match.belongsTo(User, { foreignKey: 'user2_id', as: 'user2' });

Match.hasMany(Message, { foreignKey: 'match_id', as: 'messages' });
Message.belongsTo(Match, { foreignKey: 'match_id' });

User.hasMany(PointHistory, { foreignKey: 'user_id', as: 'pointHistory' });
PointHistory.belongsTo(User, { foreignKey: 'user_id' });

User.belongsToMany(Badge, { through: UserBadge, foreignKey: 'user_id', otherKey: 'badge_id', as: 'badges' });
Badge.belongsToMany(User, { through: UserBadge, foreignKey: 'badge_id', otherKey: 'user_id', as: 'users' });

User.belongsToMany(Challenge, { through: UserChallenge, foreignKey: 'user_id', otherKey: 'challenge_id', as: 'challenges' });
Challenge.belongsToMany(User, { through: UserChallenge, foreignKey: 'challenge_id', otherKey: 'user_id', as: 'users' });

Challenge.belongsTo(Badge, { foreignKey: 'reward_badge_id', as: 'rewardBadge' });
User.hasMany(Notification, { foreignKey: 'user_id', as: 'notifications' });
Notification.belongsTo(User, { foreignKey: 'user_id' });
User.hasMany(AIChat, { foreignKey: 'user_id', as: 'aiChats' });
AIChat.belongsTo(User, { foreignKey: 'user_id' });

User.hasMany(AISession, { foreignKey: 'user_id', as: 'aiSessions' });
AISession.belongsTo(User, { foreignKey: 'user_id' });

AISession.hasMany(AIChat, { foreignKey: 'session_id', as: 'messages' });
AIChat.belongsTo(AISession, { foreignKey: 'session_id' });

// Voucher Associations
Badge.hasMany(Voucher, { foreignKey: 'badge_id', as: 'vouchers' });
Voucher.belongsTo(Badge, { foreignKey: 'badge_id', as: 'badge' });
User.belongsToMany(Voucher, { through: UserVoucher, foreignKey: 'user_id', otherKey: 'voucher_id', as: 'userVouchers' });
Voucher.belongsToMany(User, { through: UserVoucher, foreignKey: 'voucher_id', otherKey: 'user_id', as: 'users' });

QuizQuestion.hasMany(QuizOption, { foreignKey: 'question_id', as: 'options' });
QuizOption.belongsTo(QuizQuestion, { foreignKey: 'question_id', as: 'question' });

module.exports = {
    sequelize,
    User,
    Profile,
    Photo,
    Swipe,
    Match,
    Message,
    Survey,
    PointHistory,
    Badge,
    UserBadge,
    AdminLog,
    Question,
    Challenge,
    UserChallenge,
    Notification,
    AIChat,
    AISession,
    Voucher,
    UserVoucher,
    QuizQuestion,
    QuizOption
};
