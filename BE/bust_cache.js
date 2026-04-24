const { sequelize, Photo } = require('./src/models');
const { Op } = require('sequelize');

async function update() {
    try {
        const photos = await Photo.findAll({
            where: {
                image_url: {
                    [Op.like]: '/uploads/random%.jpg%'
                }
            }
        });

        for (const photo of photos) {
            // Remove any existing ?v= query, then add ?v=2
            const baseUrl = photo.image_url.split('?')[0];
            photo.image_url = baseUrl + '?v=' + Date.now();
            await photo.save();
        }
        console.log('Successfully updated ' + photos.length + ' photos to bust cache.');
        process.exit(0);
    } catch (e) {
        console.error(e);
        process.exit(1);
    }
}
update();
