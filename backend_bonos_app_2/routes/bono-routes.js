const express=require('express');
const { addBono, getAllBonos ,getBono, updateBono,
deleteBono
}= require('../controllers/bonoController');

const router = express.Router();

router.post('/bono', addBono);
router.get('/bonos', getAllBonos);
router.get('/bono/:id', getBono);
router.put('/bono/:id', updateBono);
router.delete('/bono/:id', deleteBono);




module.exports={
    routes:router
}