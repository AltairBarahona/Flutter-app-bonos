'use strict';

const firebase= require('../db');
const Bono =require('../models/bono');
const firestore=firebase.firestore();


const addBono = async(req, res, next)=>{
    try {
        const data= req.body;
        await firestore.collection('Bonos').doc().set(data);
        res.send('Bono saved successfuly');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const getAllBonos=async(req,res,next)=>{
    try {
        const bono= await firestore.collection('Bonos');
        const data = await bono.get();
        const bonosArray=[];
        if (data.empty) {
            res.status(404).send("No Bono record found");
        }else{
            data.forEach(doc => {
                const bono = new Bono(
                    doc.id,
                    doc.data().valor,
                    doc.data().fechaInicio,
                    doc.data().fechaFin,
                    doc.data().totalBono
                );
                bonosArray.push(bono);
            });
            res.send(bonosArray);
        }
    } catch (error) {
        res.status(400).send(error.message);
        
    }
}

const getBono= async(req,res,next)=>{
    try {
        const id = req.params.id;
        const bono= await firestore.collection('Bonos').doc(id);
        const data= await Bono.get();
        if (!data.exists) {
            res.status(404).send("Bono with the given ID not found");
        }else{
            res.send(data.data());
        }
    } catch (error) {
        res.status(400).send(error.message);
        
    }
}

const updateBono= async(req,res,next)=>{
    try {
        const id= req.params.id;
        const data= req.body;
        const bono =await firestore.collection('Bonos').doc(id);
        await bono.update(data);
        res.send('Bono record updated successfuly');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const deleteBono= async(req,res,next)=>{
    try {
        const id=req.params.id;
        await firestore.collection('Bonos').doc(id).delete();
        res.send('Bono Record deleted successfuly');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

module.exports={
    addBono,
    getAllBonos,
    getBono,
    updateBono,
    deleteBono
}