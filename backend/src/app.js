// IMPORTS
const express = require('express')
const { admin, database } = require('./utils/firebase')
const app = express();
const multer = require('multer');
const bodyParser = require('body-parser');
var request = require('request');
var fs = require('fs');
const { v4: uuidv4 } = require('uuid');

// MULTER CONFIGURATION
const upload = multer({
	limits: {
		fileSize: '5mb'
	}
})


const port = process.env.PORT || 8080;
app.use(bodyParser.json())


app.get('/', (req,res) => {
	res.status(200).send({msg: "Vision H+ Backend Service is online!"})
})

app.post('/stream', upload.single('image'), (req, res) => {
	try {
		var options = {
			'method': 'POST',
			'url': 'https://api.ocr.space/parse/image',
			'headers': {
				'apikey': 'dc53f888ba88957',
				'Content-Type': 'multipart/form-data; boundary=--------------------------686549698388108497808766'
			},
			formData: {
				'base64image': req.body.base64image,
				'language': 'eng'
			}
		};

		// API REQUEST FOR OCR
		request(options, function (error, response) {
			if (error) throw new Error(error);
			var ParsedResults = JSON.parse(response.body).ParsedResults[0].ParsedText;
			var items = ParsedResults.split("\n")

			// UPDATING DB WITH VALUES
			const dataRef = database.collection('data').doc('data')
			console.log(items);
			dataRef.update({
				heartrate: items[0],
				bloodpressure: items[1],
				respiration: items[2],
				temperature: items[3]
			})

			console.log(items);

			// SUCCESS
			res.send({
				statusCode: 200,
				payload: {
					msg: "Successfully transmitted data",
					data: items
				}
			}).status(200)
		});
	}
	catch (e) {
		res.send({
			error: e
		}).status(500)
	}

})


// CREATE A PATIENT RECORD
app.post('/create', async (req, res) => {
	try {
		console.log("CREATING PATIENT RECORD...");
		console.log(req.body);

		let patient_id = uuidv4();

		const patientRef = database.collection('patients').doc(patient_id)

		await patientRef.set({
			age: req.body.age,
			doctor_id: req.body.doctor_id,
			name: req.body.name,
			patient_id: patient_id,
			gender: req.body.gender,
			contact: req.body.contact,
			nurse_assigned: req.body.nurse_assigned
		})

		console.log("SUCCESSFULLY CREATED RECORD!");

		res.status(200).send({msg:"Successfully created patient!"})

	} catch (error) {
		console.log("AN ERROR OCCURED!");
		console.log(error)
		res.status(500).send({msg:"Failed to create patient!"})
	}
})


// MY PATIENTS
app.get('/my-patients/:id' , async(req,res) => {

	const patientRef = database.collection('patients').where('doctor_id' , '==' , req.params.id)
	let snapshot = await patientRef.get();

	let patients = [];

	snapshot.forEach((doc) => {
		patients.push(doc.data());
	})

	console.log(patients)

	res.status(200)
		.send({
			statusCode: 200,
			payload: {
				patients
			},})

})

// OPEN PORT
app.listen(port, () => {
	console.log('Server is up on port ', port)
})