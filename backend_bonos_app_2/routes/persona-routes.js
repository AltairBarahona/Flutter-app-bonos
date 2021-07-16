const express=require('express');
const { addPersona, getAllPersonas ,getPersona, updatePersona,
deletePersona
}= require('../controllers/personaController');

const router = express.Router();

router.post('/persona', addPersona);
router.get('/personas', getAllPersonas);
router.get('/persona/:id', getPersona);
router.put('/persona/:id', updatePersona);
router.delete('/persona/:id', deletePersona);




module.exports={
    routes:router
}