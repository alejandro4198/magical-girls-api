import React, { useState } from "react";

// crear un registro, osea el formulario
const CreateMagicalGirl = () => {
    //[Almacena la info, setx Actualizar la informacion, ("") crea la variable vacia]
    const [nombre, setNombre] = useState("");
    const [apellido, setApellido] = useState("");
    const [edad, setEdad] = useState("");
    const [ciudadId, setCiudadId] = useState("");
    const [estadoId, setEstadoId] = useState("");
    const [fechaContrato, setFechaContrato] = useState("");

    //maneja el envio de formulario
    const handleSubmit = (e) => {
        e.preventDefault(); //no se reinicia el host cuando se envia el formulario
        
        //los datos del formulario se guardaran en nuevaChicaMagica
        const nuevaChicaMagica = {
            nombre, //asignacion directa
            apellido, //asignacion directa
            edad: parseInt(edad), //lo convierte a enteros
            ciudad_id: parseInt(ciudadId), //lo convierte a enteros
            estado_id: parseInt(estadoId), //lo convierte a enteros
            fecha_contrato: fechaContrato //normal, pq la fecha es formato String
        };

        //es hacer la solicutud de informacion en la API
        fetch("http://localhost:8080/girls", {
            method: "POST", //estamos enviando datos para crear un registro, por eso es POST
            headers: { "Content-Type": "application/json" }, //la info se enviara en JSON
            body: JSON.stringify(nuevaChicaMagica), //convierte nuevaChicaMagica a JSON antes de enviarlo al BACKEND 
            //se hace para que el server entienda la informacion 
        })
        //respuesta covertir a JSON
        .then(response => response.json())
        .then(data => {
            //cuando se hace el registro en la terminal aparece el mensaje de agregado
            console.log("Nuevo registro agregado:", data);
            //en el host al usuario
            alert("Registro creado con exito");
            //limpia el formulario para nuevos registros 
            setNombre("");
            setApellido("");
            setEdad("");
            setCiudadId("");
            setEstadoId("");
            setFechaContrato("");
        })
        //si hay algun error en la solicitud de informacion a la APi, error (problemas BD o Host)
        .catch(error => console.error("Error al crear el registro:", error));
    };

    //botones del formulario
    return (
        <div>
            <h2>Agregar Un Nuevo Registro</h2>
            <form onSubmit={handleSubmit}>
                <input type="text" placeholder="Nombre" value={nombre} onChange={(e) => setNombre(e.target.value)} required />
                <input type="text" placeholder="Apellido" value={apellido} onChange={(e) => setApellido(e.target.value)} required />
                <input type="number" placeholder="Edad" value={edad} onChange={(e) => setEdad(e.target.value)} required />
                <input type="number" placeholder="ID de la Ciudad" value={ciudadId} onChange={(e) => setCiudadId(e.target.value)} required />
                <input type="number" placeholder="ID del Estado" value={estadoId} onChange={(e) => setEstadoId(e.target.value)} required />
                <input type="date" value={fechaContrato} onChange={(e) => setFechaContrato(e.target.value)} required />
                
                {/*boton enviar */}
                <button type="submit">Agregar Registro</button>
            </form>
        </div>
    );
};

// Exportar correctamente
export default CreateMagicalGirl;
