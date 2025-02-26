import React, { useEffect, useState } from "react";

//variable y funcion 
const MagicalGirlsList = () => {
    //estados para manejar la info
    const [girls, setGirls] = useState([]); //guarda los registros de la api 
    const [filteredGirls, setFilteredGirls] = useState([]); //solo guarda los registros filtrados 
    const [filter, setFilter] = useState("Todos"); //guarda el filtro actual, osea Todos, Activos, Desapaercido,...

    //obtener registros de la API
    useEffect(() => {
        fetch("http://localhost:8080/girls") //peticion a la API
            .then(response => response.json()) //lo convertimos a JSON
            .then(data => {
                setGirls(data); //guardar en girls
                setFilteredGirls(data); //todos los registros
            })
            .catch(error => console.error("Error al obtener los datos:", error));
    }, []);

    //borrar registros, funcion que tiene un parametro ID
    const handleDelete = (id) => {
        //hacer la peticion a la API
        fetch(`http://localhost:8080/girls/${id}`, {
            //
            method: "DELETE",
        })
        //cuando la API responda lo convierte en JSON
        .then(response => response.json())
        .then(data => {
            //se realizo un buen DELETE
            alert("Registro eliminado");
            setGirls(girls.filter(girl => girl.id !== id)); //Actualizar la lista en el registro, 
                                                            // crea una lista temporal con el registro eliminado
            setFilteredGirls(filteredGirls.filter(girl => girl.id !== id)); //lo mismo pero con el filtro de estado
        })
        .catch(error => console.error("Error al eliminar el registro:", error));
    };    

    //funcion que muestra el cambio de los filtros en el HOST
    const handleFilterChange = (estado) => {
        //guarda el estado seleccionado 
        setFilter(estado);
        //si estado es equivalente a todos, se muestra todos los registros
        if (estado === "Todos") {
            setFilteredGirls(girls);
        } else {
            //si no, el usuario escoge uno en especifico, filtramos los registros
            setFilteredGirls(girls.filter(girl => girl.estado.nombre_estado === estado));
        }
    };

    //cambio de estado 
    const handleChangeEstado = (id, nuevoEstado) => {
        //solicitud a la API
        fetch(`http://localhost:8080/girls/${id}/estado`, {
            method: "PATCH", //un metodo que solo actualiza un dato especifico 
            headers: { "Content-Type": "application/json" }, //indica el cuerpo de JSON 
            body: JSON.stringify({ estado_id: nuevoEstado }), //enviamos un nuevo estado
        })
        .then(response => response.json()) //convierte la respuesta de la API en JSON 
        .then(updatedGirl => {
            setGirls(girls.map(girl => (girl.id === id ? { ...girl, estado: { ...girl.estado, id: nuevoEstado } } : girl)));
            setFilteredGirls(filteredGirls.map(girl => (girl.id === id ? { ...girl, estado: { ...girl.estado, id: nuevoEstado } } : girl)));
        })
        .catch(error => console.error("Error al actualizar el estado:", error));
    };

    return (
        <div>
            <h2>Lista de Registros</h2>
            <div style={{ marginBottom: "20px" }}>
                <button onClick={() => handleFilterChange("Todos")}>Todos</button>
                <button onClick={() => handleFilterChange("Activa")}>Activos</button>
                <button onClick={() => handleFilterChange("Desaparecida")}>Desaparecidos</button>
                <button onClick={() => handleFilterChange("Rescatada por la Ley de los Ciclos")}>Rescatados</button>
            </div>
            <ul>   
                {filteredGirls.map(girl => (
                    <li key={girl.id}>
                        {girl.nombre} {girl.apellido} - Estado: {girl.estado.nombre_estado}
                        <button onClick={() => handleChangeEstado(girl.id, 1)}>Marcar como Activa</button>
                        <button onClick={() => handleChangeEstado(girl.id, 2)}>Marcar como Desaparecida</button>
                        <button onClick={() => handleChangeEstado(girl.id, 3)}>Marcar como Rescatada</button>
                        <button onClick={() => handleDelete(girl.id)}>Eliminar</button>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default MagicalGirlsList;
