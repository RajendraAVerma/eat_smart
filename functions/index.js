const functions = require("firebase-functions");

const vision = require('@google-cloud/vision');
const cors = require('cors')({ origin: true });
const fs = require('fs');
const client = new vision.ImageAnnotatorClient({
    credentials: JSON.parse(fs.readFileSync('./assets/eat-smart-prod-f694e3885236.json'))
});


exports.getImageLabel = functions.https.onRequest(async (req, res) => {
    cors(req, res, async () => {
        try {
            const imageLink = req.query.imageLink;
            const [result] = await client.labelDetection(imageLink);
            const labels = result.labelAnnotations;
            res.status(200).send(labels);
        } catch (error) {
            res.status(400).send({
                status: error,
            });
        }
    })
});