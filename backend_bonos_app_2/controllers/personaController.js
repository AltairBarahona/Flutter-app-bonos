'use strict';

const firebase= require('../db');
const Persona =require('../models/persona');
const firestore=firebase.firestore();


const addPersona = async(req, res, next)=>{
    try {
        const data= req.body;
        await firestore.collection('Personas').doc().set(data);
        res.send('Persona saved successfuly');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const getAllPersonas=async(req,res,next)=>{
    try {
        const persona= await firestore.collection('Personas');
        const data = await persona.get();
        const personasArray=[];
        if (data.empty) {
            res.status(404).send("No Persona record found");
        }else{
            data.forEach(doc => {
                const persona = new Persona(
                    doc.id,
                    doc.data().nombre,
                    doc.data().apellido,
                    doc.data().totalBono,

                );
                personasArray.push(persona);
            });
            res.send(personasArray);
        }
    } catch (error) {
        res.status(400).send(error.message);
        
    }
}

const getPersona= async(req,res,next)=>{
    try {
        const id = req.params.id;
        const persona= await firestore.collection('Personas').doc(id);
        const data= await persona.get();
        if (!data.exists) {
            res.status(404).send("Persona with the given ID not found");
        }else{
            res.send(data.data());
        }
    } catch (error) {
        res.status(400).send(error.message);
        
    }
}

const updatePersona= async(req,res,next)=>{
    try {
        const id= req.params.id;
        const data= req.body;
        const persona =await firestore.collection('Personas').doc(id);
        await persona.update(data);
        res.send('Persona record updated successfuly');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const deletePersona= async(req,res,next)=>{
    try {
        const id=req.params.id;
        await firestore.collection('Personas').doc(id).delete();
        res.send('Persona Record deleted successfuly');
    } catch (error) {
        res.status(400).send(error.message);
    }
}

module.exports={
    addPersona,
    getAllPersonas,
    getPersona,
    updatePersona,
    deletePersona
}