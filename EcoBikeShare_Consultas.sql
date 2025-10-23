
SELECT 
    e.EstacionID, 
    e.Nombre, 
    e.Capacidad, 
    COUNT(b.BiciID) AS BicicletasActuales
FROM Estacion e
JOIN Bicicleta b ON e.EstacionID = b.EstacionID
GROUP BY e.EstacionID, e.Nombre, e.Capacidad
HAVING COUNT(b.BiciID) > e.Capacidad;

-- f) Incidencias abiertas con bicicleta y fecha
SELECT 
    i.IncidenciaID, 
    b.BiciID, 
    b.Marca, 
    b.Modelo, 
    i.FechaIncidencia, 
    i.Descripcion
FROM Incidencia i
JOIN Bicicleta b ON i.BiciID = b.BiciID
WHERE i.EstadoIncidencia = 'Abierta';

-- g) Coste medio de mantenimiento por tecnico
SELECT 
    m.Tecnico, 
    ROUND(AVG(m.Coste), 2) AS CosteMedio
FROM Mantenimiento m
GROUP BY m.Tecnico;

-- h) Usuarios que no han hecho ningun alquiler
SELECT 
    u.UsuarioID, 
    u.Nombre
FROM Usuario u
LEFT JOIN Alquiler a ON u.UsuarioID = a.UsuarioID
WHERE a.AlquilerID IS NULL;

-- i) Las 5 bicicletas mas usadas (por numero de alquileres)
SELECT 
    b.BiciID, 
    b.Marca, 
    b.Modelo, 
    COUNT(a.AlquilerID) AS VecesUsada
FROM Bicicleta b
JOIN Alquiler a ON b.BiciID = a.BiciID
GROUP BY b.BiciID, b.Marca, b.Modelo
ORDER BY VecesUsada DESC
LIMIT 5;

-- j) Planes con cantidad de usuarios activos e ingreso mensual estimado
SELECT p.PlanID, p.NombrePlan,
       COUNT(u.UsuarioID) AS UsuariosActivos,
       (COUNT(u.UsuarioID) * p.TarifaMensual) AS IngresoMensualEstimado
FROM Plan p
LEFT JOIN Usuario u ON p.PlanID = u.PlanID AND u.EstadoActivo = 1
GROUP BY p.PlanID, p.NombrePlan, p.TarifaMensual;

-- SHOW COLUMNS FROM Usuario;
