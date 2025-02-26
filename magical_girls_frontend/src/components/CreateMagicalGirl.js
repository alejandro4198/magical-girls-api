import React, { useState } from "react";

const CreateMagicalGirl = () => {
    const [nombre, setNombre] = useState("");
    const [apellido, setApellido] = useState("");
    const [edad, setEdad] = useState("");
    const [ciudadId, setCiudadId] = useState("");
    const [estadoId, setEstadoId] = useState("");
    const [fechaContrato, setFechaContrato] = useState("");

    const handleSubmit = (e) => {
        e.preventDefault();
        
        const nuevaChicaMagica = {
            nombre,
            apellido,
            edad: parseInt(edad),
            ciudad_id: parseInt(ciudadId),
            estado_id: parseInt(estadoId),
            fecha_contrato: fechaContrato
        };

        fetch("http://localhost:8080/girls", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(nuevaChicaMagica),
        })
        .then(response => response.json())
        .then(data => {
            console.log("Nuevo registro agregado:", data);
            alert("Registro creado con exito");
            setNombre("");
            setApellido("");
            setEdad("");
            setCiudadId("");
            setEstadoId("");
            setFechaContrato("");
        })
        .catch(error => console.error("Error al crear el registro:", error));
    };

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
                
                {/* Boton de enviar */}
                <button type="submit">Agregar Registro</button>
            </form>
        </div>
    );
};

// Exportar correctamente
export default CreateMagicalGirl;
