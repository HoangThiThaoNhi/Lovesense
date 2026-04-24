const { sequelize, Photo } = require('./src/models');
async function check() {
    const photos = await Photo.findAll();
    console.log(photos.map(p => p.image_url));
    process.exit(0);
}
check();
