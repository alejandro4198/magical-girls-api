import React from "react";
import "./App.css";
import MagicalGirlsList from "./components/MagicalGirlsList"; 
import CreateMagicalGirl from "./components/CreateMagicalGirl"; 

function App() {
    return (
        <div>
            <h1>PROYECTO PROGRAMACIÓN AVANZADA</h1>
            <MagicalGirlsList />
            <CreateMagicalGirl /> {/*formulario*/}
        </div>
    );
}

export default App;
