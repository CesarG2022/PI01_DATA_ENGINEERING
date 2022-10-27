# Proyecto Individual 1- Creación de DB con Carga Incremental (Data Engineering)

## Objetivos
- Procesar los diferentes datasets con diferentes formatos.
- Crear una base de datos con mySQL y el correspondiente DER.
- Realizar una carga incremental de los archivos

## Diagrama de flujo de trabajo
![image](https://raw.githubusercontent.com/CesarG2022/Prep-Course/main/_src/PI_1.jpg)

## Pasos en python para carga inicial

- Cargar dataset: en este punto se cargan dos tablas dimensionales(sucursal y producto) y tres tablas de precios(precio_1, precio_2, precio_3) utilizando la libreria pandas.

- Definir de tipo de datos de las columnas de los dataframes precio_1 , precio_2 ,precio_3: esto se realiza debido a que las tablas son cargadas con diferentes tipos de datos y con el objetivo de unirlas en un paso posterior. los tipos asignado a cada columna son: precio -> float64 , producto_id ->str, sucursal_id -> str

    - Quitar guiones de columnas de id de producto en las tres tablas de precio y en la tabla de productos: esto se hace para hacer conversion a INT en un paso posterior.

    - asignacion de NaN a tablas de precios: esto se hace en las columnas de precio y producto_id para los campos que no tienen dato o tienen el texto 'nan'

    - cambio de tipo de datos a float: este paso se relaiza para poder eliminar los valores NaN en pasos posteriores.

- Unificar de orden de columnas: para reordenar las columnas de la tabla precio_2 tal como se encuentran en las tablas precio_1 y precio_3.

- Unir dataframes precio_1, precio_2 y precio_3 en el dataframe precio

- Eliminar nulos:

    - Convertir 'nan' de columna sucursal_id en np.NAN: esto se hace despues de unir los dataframes de precios ya que el tipo de la columna sucursal_id es str en las tres tablas.

    - Eliminación de nulos sobre columnas precio y sucursal_id de tabla precio: los valores nulos de la columna producto_id se dejan ya que de esta manera se puede obtener información de precios filtrando por sucursal_id, la cantidad de datos con sucursal_id nulo y precio y producto_id no nulo es ínfima por lo que no se conservan.

    - se eliminan las columnas categoria1, categoria2, categoria3 , ya que solo tienen 4 valores no nulos de los aprox. 72000 totales.

    - de la tabla sucursales no hay nulos.

- Eliminar duplicados: se eliminan duplicados de la tabla precios; en las tablas sucursal y productos no hay duplicados.

- Definir nombres de columnas de todas las tablas: esto se hace con el objetivo de unificar nombres de columnas para la creación del DER en pasos posteriores.

 - Asignar None a los id_sucursal de tabla precios que no están en la tabla de sucursales: esto se realiza teniendo en cuenta que un id_sucursal de la tabla precio que no se encuentra en la tabla de sucursal no da información e impide la construcción del modelo relacional en mysql en pasos posteriores.

 - Carga inicial de las tablas a la base de datos: este paso requiere de hacer la creación previa de la base de datos usando en mysql, esta creacion se realizó en workbench y se muestra en el video.

    -se establece la conexión con la base de datos creada usando las funciones create_engine() y  conect() de sqlalchemy

    - se cargan los datos de las tres tablas, producto, sucursal y precio usando la funcion .to_sql() de alchemy. Cada carga tiene una definicion previa de un diccionario con los tipos con los que se desea ingestar la data en la base de datos

## Pasos en worbench

- Creacion de la base de dato con nombre pi_1: este paso se realizo antes la carga inicial de las tablas.

- Creación del DER: se crean claves primarias en las tres tablas como se describe a continuación:
    tabla productos: id_producto
    tabla sucursales: id_sucursal
    precios: id_precio ; esta clave es autoincremental para que se aumente automáticamente al hacer la carga incremental
también se crean en la tabla precios las claves foraneas para relacionarla con la tabla productos a través de la columna id_producto y con la tabla sucursales a través de la columna de id_sucursal.

- Creación del diagrama usando la herramienta reverse engineering

## Pasos en python para carga incremental

- carga a python y transformación: Para la carga incremental se realizan todos los pasos de carga y transformación que se realizaron a las tablas precio_1, precio_2, precio_3 y precio de manera tal que se puedan corregir la mayor cantidad errores en los datos. ya que uno de los pasos de transformación requiere de la tabla sucursales, esta se descarga de la base de datos 

- Establecer la conexion con la base de datos: tal cual como se realiza en la carga inicial.

- Carga incremental: aquí es donde está la diferencia entre la carga inicial y la carga incremental, debido a que en este caso se quiere adicionar los datos nuevos a los ya existentes, al momento de usar la funcion .to_sql() de sqlalchemy, se debe adicionar el parametro if_exist='append', de esta manera los nuevos datos se agregan al final de la tabla precios del db.

## link al video explicativo:

