const express = require('express');
const dns = require('dns');
dns.setDefaultResultOrder('ipv4first');
const cors = require('cors');
const morgan = require('morgan');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));
app.use('/uploads', express.static('uploads'));

// Routes
app.get('/', (req, res) => {
    res.json({ message: 'Welcome to Tinder Clone API' });
});

// Auth Routes placeholder
app.use('/api/auth', require('./routes/authRoutes'));
app.use('/api/profile', require('./routes/profileRoutes'));
app.use('/api/swipes', require('./routes/swipeRoutes'));
app.use('/api/matches', require('./routes/matchRoutes'));
app.use('/api/messages', require('./routes/messageRoutes'));
app.use('/api/gamification', require('./routes/gamificationRoutes'));
app.use('/api/ai', require('./routes/aiRoutes')); // Added AI routes
app.use('/api/admin', require('./routes/adminRoutes')); // New Admin Routes
app.use('/api/notifications', require('./routes/notificationRoutes'));
app.use('/api/vouchers', require('./routes/voucherRoutes'));
app.use('/api/quiz', require('./routes/quizRoutes'));

// Error handling middleware
app.use((err, req, res, next) => {
    console.error('ERROR:', err);
    if (err.stack) console.error(err.stack);
    res.status(500).json({ error: err.message || 'Something went wrong!' });
});

const PORT = process.env.PORT || 5000;
const { sequelize } = require('./models');

console.log('Connecting to database...');
sequelize.sync().then(() => {
    console.log('Database synced successfully.');
    app.listen(PORT, () => {
        console.log(`🚀 Server is running on port ${PORT}`);
    });
}).catch(err => {
    console.error('❌ Unable to connect to the database:', err);
});
