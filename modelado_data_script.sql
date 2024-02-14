create schema academia;

set schema 'academia';

create table telefono(
	id smallserial primary key,
	valor varchar(15) not null,
	dni varchar(10) not null
);


create table persona(
	dni varchar(10) primary key,
	fecha_nacimiento date not null,
	nombre varchar(30) not null,
	appelido varchar(80) not null
);


create table email(
	id smallserial primary key,
	valor varchar(50) not null,
	dni varchar(10) not null
);


create table matricula(
	id smallserial primary key,
	dni_alumno varchar(10) not null,
	id_curso integer not null,
	fecha_matriculacion date not null	
);

alter table matricula
add column apto boolean default false;

alter table matricula
alter column id_curso type smallint;


create table profesor(
	id smallserial primary key,
	dni_profesor varchar(10) not null,
	id_asignatura integer not null

);

alter table profesor
alter column id_asignatura type smallint;

create table curso(
	id smallserial primary key,
	nombre varchar(20) not null

);

create table asignatura(
	id smallserial primary key,
	nombre varchar(10) not null,
	id_curso integer not null
);

alter table asignatura
alter column id_curso type smallint;

create table direccion(
	dni varchar(10) primary key,
	id_población integer not null,
	calle varchar(30) not null,
	numero varchar(5) not null,
	piso varchar(10) not null
);

alter table direccion
alter column id_población type smallint;

create table provincia(
	id smallserial primary key,
	valor varchar(20) not null
);

create table poblacion(
	id smallserial primary key,
	valor varchar(20) not null,
	id_provincia varchar(5)
);

alter table poblacion
alter column id_provincia type smallint using id_provincia::smallint;

alter table poblacion 
alter column id_provincia set not null;

create table calificacion(
	id smallserial primary key,
	dni_alumno varchar(10) not null,
	id_asignatura smallint not null,
	valor float not null
);

--

alter table telefono 
add constraint fk_persona_telefono
foreign key (dni) references persona(dni);

alter table email
add constraint fk_persona_email
foreign key (dni) references persona(dni);

alter table matricula
add constraint fk_persona_matricula
foreign key (dni_alumno) references persona(dni);

alter table matricula
add constraint fk_curso_matricula
foreign key (id_curso) references curso(id);

alter table profesor
add constraint fk_persona_profesor
foreign key (dni_profesor) references persona(dni);

alter table profesor
add constraint fk_asignatura_profesor
foreign key (id_asignatura) references asignatura(id);

alter table asignatura
add constraint fk_curso_asignatura
foreign key (id_curso) references curso(id);

alter table direccion 
add constraint fk_persona_direccion
foreign key (dni) references persona(dni);

alter table direccion 
add constraint fk_poblacion_direccion
foreign key (id_población) references poblacion(id);

alter table poblacion 
add constraint fk_provincia_poblacion 
foreign key (id_provincia) references provincia(id);

alter table calificacion 
add constraint fk_persona_calificacion
foreign key (dni_alumno) references persona(dni);

alter table calificacion 
add constraint fk_asignatura_calificacion
foreign key (id_asignatura) references asignatura(id);



--

alter table calificacion 
add constraint notas_entre_0_y_10
check (valor between'0' and '10'); 

alter table calificacion
drop constraint notas_entre_0_y_10;

alter table calificacion 
add constraint notas_entre_0_y_10
check (valor between 0 and 10); 

/* 
    Otra forma de definir los valores entre los que nos vamos a mover:
 
	alter table calificacion 
	add constraint notas_entre_0_y_10
	check (valor >= 0 and valor <= 10);
	
 */



-- INSERTS DE PRUEBA:


insert into persona (dni, fecha_nacimiento, nombre, appelido) values ('1234567890', '2000-01-01', 'Nombre', 'Apellido');

insert into curso (nombre) values ('NombreCurso');

insert into asignatura (nombre, id_curso) values ('Asignatura', 1);

insert into calificacion (dni_alumno, id_asignatura, valor) values ('1234567890', 1, 8);