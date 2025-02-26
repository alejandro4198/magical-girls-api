package main

import (
	"fmt"      //normalito, mensajes en la terminal
	"log"      //muestra los errores en la terminal
	"net/http" // ---------

	"github.com/gin-contrib/cors" // React se comunica con la API
	"github.com/gin-gonic/gin"    // Framework para la API
	"gorm.io/driver/postgres"     //Coneccion a la BD en pg admin4
	"gorm.io/gorm"                //ORM que interactua con la BD ----.--
)

// gin : peticiones HTTP
// gorm : BD
// cors : conexion con react

var db *gorm.DB //coneccion con la BD y tambien hacer consultas

// definir las tablas de la BD

// define la tabla Ciudad con sus 2 columnas, osea, define como es la tabla
type Ciudad struct {
	ID           uint   `gorm:"primaryKey" json:"id"`
	NombreCiudad string `gorm:"unique" json:"nombre_ciudad"`
}

// conexion entre la tabla Ciudad con el programa
func (Ciudad) TableName() string {
	return "ciudad" //aca toco ponerlo en "" pq el GORM lo pone en plural
}

// define la tabla Estado con sus 2 columnas, osea, define como es la tabla
type Estado struct {
	ID           uint   `gorm:"primaryKey" json:"id"`
	NombreEstado string `gorm:"unique" json:"nombre_estado"`
}

// conexion entre la tabla Estado con el programa
func (Estado) TableName() string {
	return "estado"
}

// define la tabla MagicalGirl con sus 9 columnas, osea, define como es la tabla
type MagicalGirl struct {
	ID            uint   `gorm:"primaryKey" json:"id"`
	Nombre        string `json:"nombre"`
	Apellido      string `json:"apellido"`
	Edad          int    `json:"edad"`
	CiudadID      uint   `json:"ciudad_id"`
	EstadoID      uint   `json:"estado_id"`
	FechaContrato string `json:"fecha_contrato"`
	Ciudad        Ciudad `gorm:"foreignKey:CiudadID" json:"ciudad"`
	Estado        Estado `gorm:"foreignKey:EstadoID" json:"estado"`
}

// Conectar a la BD
func initDB() {
	//la info necesaria para la conexion con la BD (Data Source Name)
	dsn := "host=localhost user=postgres password=1234 dbname=dbprogramacion port=5432 sslmode=disable"

	var err error //es para ver los errores de conexion en la BD

	//abre la conexion usando el DSN
	db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})

	//verificar si hay errores en la conexion a la BD
	// si error no es nil, hubo fallos
	if err != nil {
		log.Fatal("Error al conectar con la base de datos:", err) //muestra el error y machetazo al programa
	}

	// Migrar modelos
	db.AutoMigrate(&Ciudad{}, &Estado{}, &MagicalGirl{}) //si en la BD no hay tabllas, las crea (automigrate)
	//y &Ciudad{}, &Estado{}, &MagicalGirl{} es para asegurar que sus columnas
	// esten en el codigo de type y asi los actualiza
	fmt.Println("Conectado a PostgreSQL Admin 4") // por si acaso, solo se muestra en la consola si hay conexion a la BD
}

// obtener una lista de registros de las personas y eso de la BD, y lo devuelve JSON
func getMagicalGirls(c *gin.Context) {
	var girls []MagicalGirl          //crea el Slice de MagicalGirls, alamcena los registros, su tamaño cambia por
	estadoID := c.Query("estado_id") // Captura el parámetro de la URL mediante una solicitud, osea filtra por el estado_id
	//c es una instancia y Query obtiene el valor de la solicitud

	query := db.Preload("Ciudad").Preload("Estado") //Carga la informacion de Ciudad y Estado

	//Si el usuario busca filtrar por Estado_id2, le devuelve solo los que tengan 2
	//pero si no tiene una solicitud solo aparece todos los registros
	if estadoID != "" {
		query = query.Where("estado_id = ?", estadoID)
	}

	result := query.Find(&girls) //filtra los registros donde estado_id sea el valor asignado por la solicitud

	// si la busqueda da un numero diferente que los dados da el error, posibles errores en la consulta de BD
	if result.Error != nil {
		//error 500, maps que describe el error y lo da en JSON
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error al obtener registros", "detalle": result.Error.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, girls) //Cuando todo sale bien, devuelve todos los registros, codigo 200, girls es de la BD
}

// crea los registros,
func createMagicalGirl(c *gin.Context) {
	var girl MagicalGirl //almacenar los datos

	//coge los datos del front en forma de JSON y los convierte en la estructura de MagicalGirl
	//si hay errores en la conversion , devuelve el error
	if err := c.BindJSON(&girl); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	//verifica si la ciudad y el estado existen
	var ciudad Ciudad
	var estado Estado

	//busca la ciudad en la BD, y si no esta hay un error
	//busca en la tabla estado el registro donde ID=girl.CiudadId
	//y lo guarda en la variable ciudad
	//osea trae la ciudad que el usuario ingreso
	if err := db.First(&ciudad, girl.CiudadID).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Ciudad no registrada"})
		return
	}
	//busca el estado en la BD, y si no esta hay un error,
	//busca en la tabla estado el registro donde ID=girl.EstadoId
	//y lo guarda en la variable estado
	//osea trae el estado que el usuario ingreso
	if err := db.First(&estado, girl.EstadoID).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Estado no encontrado"})
		return
	}

	db.Create(&girl)                 //guarda el registro en la BD, girl tiene toda la info y los guarda en Magical_Girls
	c.JSON(http.StatusCreated, girl) //envia una respuesta con el registro en JSON, el registro fue creado bien
}

// busca el id en los registros y lo actualiza, si no lo encuentra error
func updateMagicalGirl(c *gin.Context) {
	var girl MagicalGirl //alamcenar los registros

	//busca en la BD el registro, c.Paranam busca el id del registro a actualizar, lo saco mediante un parametro
	if db.First(&girl, c.Param("id")).Error != nil {
		//si no lo encuntra da error
		c.JSON(http.StatusNotFound, gin.H{"error": "Registro no encontrado"})
		return
	}
	// coge los datos del front y los convierte en un registro (JSON)
	// si hay un error al convertirlo JSON, error 400
	if err := c.BindJSON(&girl); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	db.Save(&girl)              //actualiza la info, si no hay ninguno lo crea
	c.JSON(http.StatusOK, girl) //envia una respuesta con el registro en JSON, el registro fue actualizado bien
}

// eliminar registros
func deleteMagicalGirl(c *gin.Context) {
	//Si en la BD y el registro es borrado, osea busca el ID y lo borra, RowsAffected, cuantos fueron borrados
	if db.Delete(&MagicalGirl{}, c.Param("id")).RowsAffected == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Registro no encontrado"}) //si no encontro registros para eliminar, error
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Registro eliminado"}) //si se elimino bien
}

// actualiza el estado de los registros
func updateEstadoMagicalGirl(c *gin.Context) {
	var girl MagicalGirl //almacenar los datos
	id := c.Param("id")  //id es igual al id dl front, lo obtiene desde el fromt

	// busca el registro en la BD y si no lo encunetra error, y si si lo guarda en girl
	if err := db.First(&girl, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Registro no encontrada"})
		return
	}

	//solo guarda el id nuevo, mediante una estructura temporal
	var temporalEstructura struct {
		EstadoID uint `json:"estado_id"`
	}

	//toma los datos del cambio y los pone en temporalEstructura
	// si hay un error en la conversion a JSON, error
	if err := c.BindJSON(&temporalEstructura); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Datos incorrectos"})
		return
	}

	//guarda el estado anterior antes de actualizar, regisrto de cambios
	estadoAnterior := girl.EstadoID

	// reemplaza el antiguo cambio por uno nuevo
	girl.EstadoID = temporalEstructura.EstadoID
	//guarda el registro y si hay algun error de conexion BD error
	if err := db.Save(&girl).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "No se pudo actualizar el estado"})
		return
	}

	//registra el cambio en historial_estados, los inserta manualmente en la BD, db.Exec es hacer una
	//consulta sin ORM, se usa para insertar los datos
	db.Exec("INSERT INTO historial_estados (chica_magica_id, estado_anterior, estado_nuevo, fecha_cambio) VALUES (?, ?, ?, NOW())",
		girl.ID, estadoAnterior, temporalEstructura.EstadoID)

	//se actualizo bien
	c.JSON(http.StatusOK, gin.H{"message": "Estado actualizado", "chica": girl})
}

// aca todas las funciones se ejecutan o la entrada al server
func main() {
	//inicia la conexion con la BD
	initDB()

	//crea el servidor y el middleware, osea los errores y la info
	r := gin.Default()

	//CORS (Cross-Origin Resource Sharing), comunicacion entr el frontend y la API
	r.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:3001"},                 //opermitido (React), osea solo recibe la info de ahi
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "PATCH"}, //los metodos permitidos
		AllowHeaders:     []string{"Content-Type"},                          //le dice al server que la info ya esta en JSON y que ya se puede interpretar
		AllowCredentials: true,                                              //permite las cookies, osea la info no se pierde en el navegador
	}))

	// Rutas o  Endpoints, son como el menu con opciones, cada menu hace un osas diferentes
	//el cliente React habla con el server
	// /girls es una conexion que permite el programa acceder a la BD
	r.GET("/girls", getMagicalGirls)                      //funcion Get obtener los registros, ver todos registros,
	r.POST("/girls", createMagicalGirl)                   //POST agregar registros, guarda el nuevo registro
	r.PUT("/girls/:id", updateMagicalGirl)                //PUT editar, cambiar datos de un registro, :id del registro
	r.DELETE("/girls/:id", deleteMagicalGirl)             //DELETE borra registro, eliminar registro :ID del registro
	r.PATCH("/girls/:id/estado", updateEstadoMagicalGirl) //PATCH cambiar solo el estado, cambiar :ID registro

	//inicia el server en el puerto 8080
	r.Run(":8080")
}
