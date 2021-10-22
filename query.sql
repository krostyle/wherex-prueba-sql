CREATE DATABASE wherex;

CREATE TABLE empresa(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	estado INT NOT NULL
);

CREATE TABLE persona(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	estado INT NOT NULL,
	empresa_id INT NOT NULL,
	CONSTRAINT fk_persona_empresa
	FOREIGN KEY(empresa_id) REFERENCES empresa(id)
)

CREATE TABLE vehiculo(
	id SERIAL PRIMARY KEY,
	tipo INT NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	persona_id INT NOT NULL,
	CONSTRAINT fk_vehiculo_persona
	FOREIGN KEY(persona_id) REFERENCES persona(id)
)

--1. Todas las personas que tengan al menos un vehículo con vehiculo.tipo 1.
--2. Columnas: empresa.nombre, persona.nombre, vehiculo.descripcion, vehiculo.tipo
--OPCION 1, busqueda mas estricta:
select empresa.nombre as nombre_empresa,persona.nombre as nombre_persona ,vehiculo.descripcion as descripcion_vehiculo,vehiculo.tipo as tipo_vehiculo
from empresa
inner join persona
on empresa.id=persona.empresa_id
inner join vehiculo
on persona.id=vehiculo.persona_id
where vehiculo.tipo=1
group by empresa.nombre,persona.nombre,vehiculo.descripcion,vehiculo.tipo
having count(vehiculo)>=1;

--OPCION 2 :
select empresa.nombre, persona.nombre, vehiculo.descripcion, vehiculo.tipo
from persona
inner join vehiculo 
on persona.id = vehiculo.persona_id
inner join empresa 
on persona.empresa_id = empresa.id
where vehiculo.tipo = 1;


--3. Todas las personas de la empresa_id 3, que se tengan persona.estado 1
--4. Columnas: persona.id, persona.nombre, persona.estado
select persona.id,persona.nombre,persona.estado
from persona
inner join empresa
on persona.empresa_id=empresa.id
where empresa.id=3 and persona.estado=1


--5. Todas las personas que tengan o no vehículo a cargo, ordenadas por empresa_id y persona.nombre.
--6. Columnas; empresa.nombre, persona.nombre, vehiculo.descripcion
--Se asumen que es un orden ascendente


--OPCION 1, busqueda mas estricta:
select empresa.nombre as nombre_empresa, persona.nombre as nombre_persona, vehiculo.descripcion as vehiculo_descripcion
from empresa
inner join persona
on empresa.id=persona.empresa_id
left join vehiculo
on persona.id=vehiculo.persona_id
group by empresa.nombre,persona.nombre,vehiculo.descripcion, persona.empresa_id,persona.nombre
having count(vehiculo)>=0
order by persona.empresa_id,persona.nombre asc;

--OPCION 2:
select empresa.nombre as nombre_empresa, persona.nombre as nombre_persona, vehiculo.descripcion as vehiculo_descripcion
from empresa
inner join persona
on empresa.id=persona.empresa_id
left join vehiculo
on persona.id=vehiculo.persona_id
order by persona.empresa_id,persona.nombre;