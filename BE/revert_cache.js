const { sequelize, Photo } = require('./src/models');
const { Op } = require('sequelize');

async function revert() {
    try {
        const photos = await Photo.findAll({
            where: {
                image_url: {
                    [Op.like]: '/uploads/random%.jpg%'
                }
            }
        });

        for (const photo of photos) {
            const baseUrl = photo.image_url.split('?')[0];
            photo.image_url = baseUrl;
            await photo.save();
        }
        console.log('Successfully reverted ' + photos.length + ' photos.');
        process.exit(0);
    } catch (e) {
        console.error(e);
        process.exit(1);
    }
}
revert();
