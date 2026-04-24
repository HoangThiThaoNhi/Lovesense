const { Question } = require('../models');

const seedQuestions = async () => {
    try {
        console.log('Seeding initial questions...');
        
        const questions = [
            {
                text: 'Bạn thích buổi hẹn hò đầu tiên ở đâu?',
                category: 'lifestyle',
                difficulty: 'easy',
                status: 'active'
            },
            {
                text: 'Quan điểm của bạn về tình yêu sét đánh là gì?',
                category: 'personality',
                difficulty: 'medium',
                status: 'active'
            },
            {
                text: 'Nếu có 1 ngày để đi du lịch, bạn sẽ chọn núi hay biển?',
                category: 'lifestyle',
                difficulty: 'easy',
                status: 'active'
            },
            {
                text: 'Bạn mong đợi điều gì nhất ở đối phương?',
                category: 'personality',
                difficulty: 'hard',
                status: 'active'
            }
        ];

        for (const q of questions) {
            await Question.create(q);
        }

        console.log('Successfully seeded AI Question Bank!');
        process.exit(0);
    } catch (error) {
        console.error('Error seeding questions:', error);
        process.exit(1);
    }
};

seedQuestions();
